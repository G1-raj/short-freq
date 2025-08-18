import prisma from '../../../plugin/prisma.js';
import generateUserId from '../../../utils/generate_userid.js';
import { hashedPassword } from '../../../utils/hash.js';
import { FastifyRequest, FastifyReply } from 'fastify';

interface SignupBody {
    email: string,
    password: string,
    name: string,
    phoneNumber: string
}

const signup = async (
    request: FastifyRequest< { Body: SignupBody } >,
    reply: FastifyReply
) => {

    const { email, password, name, phoneNumber } = request.body;

    try {

        const existingUser = await prisma.userDetails.findUnique({
            where: { email }
        });
        
        if(existingUser) {
            return reply.status(400).send({
                success: false,
                message: "Please login email already registered"
            });
        }

        const emailVerified = await prisma.otpVerification.findUnique({ where: { email }});

        if(!emailVerified?.isEmailVerified) {
            return reply.status(400).send({
                success: false,
                message: "Email is not verified, please verify your email first"
            });
        }

        let encryptedPassword = await hashedPassword(password);
        let userId: string;

        while (true) {
            userId = await generateUserId();
            const exist = await prisma.userDetails.findUnique({ where: { userId }});
            if(!exist) break;
        }


        let user = await prisma.userDetails.create({
            data: {
                email: email,
                password: encryptedPassword,
                name: name,
                phoneNumber: phoneNumber,
                userId: userId
            }
        });


        return reply.status(200).send({
            success: true,
            message: "User registered successfully",
            data: user
        });
        
    } catch (error) {
        console.error(error);
        return reply.status(500).send({
            success: false,
            message: "Internal server error"
        });
    }

}

export default signup;