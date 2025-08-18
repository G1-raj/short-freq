import prisma from '../../plugin/prisma.js';
import { FastifyRequest, FastifyReply } from 'fastify';
import { configDotenv } from 'dotenv';
import { verify } from 'crypto';

configDotenv();

interface RefreshTokenBody {
    refreshToken: string
}

const refreshToken = async (
    request: FastifyRequest< { Body: RefreshTokenBody } >,
    reply: FastifyReply
) => {

    const { refreshToken } = request.body;

    try {

        const decoded = request.server.jwt.verify(refreshToken) as { userId: string };

        const storedToken = await prisma.refreshToken.findUnique({
            where: { token: refreshToken }
        });

        if(!storedToken) {
            return reply.status(401).send({
                success: false,
                message: "Invalid refresh token"
            });
        }

        const accessToken = request.server.jwt.sign(
            { userId: decoded.userId},
            { expiresIn: '15M'}
        );



        return reply.status(200).send({
            success: true,
            message: "New access token generated",
            data: {
                accessToken: accessToken
            }
        });
        
    } catch (error) {
        console.log(error);

        return reply.status(500).send({
            success: false,
            message: "Internal server error"
        });
    }

}

export default refreshToken;