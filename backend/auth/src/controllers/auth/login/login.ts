import prisma from '../../../plugin/prisma.js';
import { FastifyRequest, FastifyReply } from 'fastify';
import { comparePassword } from '../../../utils/hash.js';
import loginLimitter from '../../../middlewares/login_limmiter.js';

export interface LoginBody {
    userId: string,
    password: string
}


const login = async (
    request: FastifyRequest< { Body: LoginBody } >,
    reply: FastifyReply
) => {

    const { userId, password } = request.body;

    try {

        const existingUser = await prisma.userDetails.findUnique( { where: { userId }});

        if(!existingUser) {
            return reply.status(401).send(
                {
                    success: false,
                    message: "Invalid credentials"
                }
            );
        }

        await loginLimitter(request, reply);
        let isPasswordMatched = await comparePassword(password, existingUser.password);

        if(!isPasswordMatched) {

            let failedAttempts = existingUser.failedLoginAttempts + 1;

            if(failedAttempts > 3) {
                await prisma.userDetails.update({
                    where: { userId },
                    data: {
                        failedLoginAttempts: failedAttempts,
                        lockUntil: new Date(Date.now() + 30 * 60 * 1000),
                    }
                });

                return reply.status(429).send({
                    success: false,
                    message: "Account is locked for multiple failed attempts. Try again in 30 minutes"
                });
            } else {
                return reply.status(401).send({
                    success: false,
                    message: "Invalid Credentials"
                });
            }
        }

        const accessToken = request.server.jwt.sign(
            { userId: existingUser.id },
            { expiresIn: "15M" }
        );

        const refreshToken = request.server.jwt.sign(
            { userId: existingUser.id },
            { expiresIn: "7D" }
        );

        await prisma.refreshToken.create({
            data: {
                userId: existingUser.id,
                token: refreshToken,
                expiresAt: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000),
            }
        });

        const user = {
            id: existingUser.id,
            name: existingUser.name,
            email: existingUser.email,
            userId: existingUser.userId,
            phoneNumber: existingUser.phoneNumber,
            role: existingUser.role
        };

        await prisma.userDetails.update({
            where: { userId },
            data: {
                failedLoginAttempts: 0,
                lockUntil: null,
                lastLoginAt: new Date()
            }
        });


        return reply.status(200).send({
            success: true,
            message: "User logged in successfully",
            data: {
                user: user,
                tokens: {
                    accessToken: accessToken,
                    refreshToken: refreshToken
                }
            }
        });

        
        
    } catch (error) {
        console.error(error);
        return reply.status(500).send({
            success: false,
            message: "Internal server error"
        });
    }

}

export default login;