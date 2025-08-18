import prisma from '../../../plugin/prisma.js';
import { comparePassword } from '../../../utils/hash.js';
import { FastifyRequest, FastifyReply } from 'fastify';

interface OtpBody {
    email: string,
    otp: string
}

const verifyOtp = async (
    request: FastifyRequest< { Body: OtpBody } >,
    reply: FastifyReply
) => {
    const { email, otp } = request.body;

    try {

        const existingUser = await prisma.otpVerification.findUnique( { where: { email }});

        if(!existingUser) {
            return reply.status(404).send(
                {
                    success: false,
                    message: "User not exist with provided email id"
                }
            );
        }

        if (existingUser.isEmailVerified) {
            return reply.status(400).send({
                success: false,
                message: "Email is already verified"
            });
        }


        if(!existingUser.otpExpiresAt || existingUser.otpExpiresAt < new Date()) {
            return reply.status(400).send(
                {
                    success: false,
                    message: "Otp is expired"
                }
            );
        }

        if(!existingUser.otp) {
            return reply.status(400).send(
                {
                    success: false,
                    message: "No OTP found, please request a new one"
                }
            );
        }

        let isOtpMatched = await comparePassword(otp, existingUser.otp);

        if(!isOtpMatched) {
            return reply.status(400).send(
                {
                    success: false,
                    message: "Otp does not matched"
                }
            );
        }

        const emailVerified = await prisma.otpVerification.update({
            where: { email },
            data: {
                isEmailVerified: true,
                otp: null,
                otpExpiresAt: null
            }
        });

        return reply.status(200).send(
            {
                success: true,
                message: "Otp matched successfully",
                data: emailVerified
            }
        );
        
    } catch (error) {
        console.error(error);

    }
}

export default verifyOtp;