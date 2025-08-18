import prisma from '../../../plugin/prisma.js';
import generateOtp from '../../../utils/generate_otp.js';
import { hashedPassword } from '../../../utils/hash.js';
import { FastifyRequest, FastifyReply } from 'fastify';
import send_mail from '../../../utils/send_verification_mail.js';

interface EmailBody {
    email: string,
}

const verify_email = async (
    request: FastifyRequest< { Body: EmailBody }>,
    reply: FastifyReply
) => {

    const { email } = request.body;

    if(!email) {
        return reply.status(400).send(
            {
                success: false,
                message: "Please provide the email"
            }
        );
    }

    try {

        const existingUser = await prisma.userDetails.findUnique({
            where: { email }
        });

        if(existingUser) {
            return reply.status(400).send(
                {
                    success: false,
                    message: "User already exist with the same email id",
                }
            );
        }

        let generatedOtp = generateOtp();
        let otpExpiresAt = new Date(Date.now() + 5 * 60 * 1000);
        let hashedOtp = await hashedPassword(generatedOtp);

        const existingOtp = await prisma.otpVerification.findUnique({ where: {email}});

        if(existingOtp && existingOtp.otpExpiresAt! > new Date()) {
            return reply.status(429).send(
                {
                    success: false,
                    message: `Please wait until ${existingOtp.otpExpiresAt!.toISOString()} to request a new otp`
                }
            );
        }

      
        await prisma.otpVerification.upsert({
            where: { email },
            update: {
                otp: hashedOtp,
                otpExpiresAt: otpExpiresAt,
                isEmailVerified: false
            },
            create: {
                email: email,
                otp: hashedOtp,
                otpExpiresAt: otpExpiresAt,
                isEmailVerified: false
            }
        });

        try {
            send_mail(email, generatedOtp);
        } catch (error) {
            console.log("Failed to send email for verification code");
        }


        

        return reply.status(200).send(
            {
                success: true,
                message: "Otp sent successfully",
                data: {
                    otpExpiresIn: otpExpiresAt
                }
            }
        );

    } catch (error) {
        console.error(error);
        return reply.status(500).send(
            {
                success: false,
                message: "Internal server error"
            }
        );
    }

}

export default verify_email;