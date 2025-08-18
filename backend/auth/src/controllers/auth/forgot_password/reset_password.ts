import prisma from '../../../plugin/prisma.js';
import { FastifyRequest, FastifyReply } from 'fastify';
import { hashedPassword } from '../../../utils/hash.js';

interface ResetPasswordBody {
    email: string,
    password: string
}

const reset_password = async (
    request: FastifyRequest< { Body: ResetPasswordBody } >,
    reply: FastifyReply
) => {

    const { email, password } = request.body;

    try {

        const existingUser = await prisma.userDetails.findUnique({
            where: { email }
        });

        if(!existingUser) {
            return reply.status(401).send({
                success: false,
                message: "User does not exist"
            });
        }

        const hashPassword = await hashedPassword(password);

        const user = await prisma.userDetails.update({
            where: { email },
            data: {
                password: hashPassword
            }
        });

        return reply.status(200).send({
            success: true,
            message: "Password changed successfully",
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

export default reset_password;