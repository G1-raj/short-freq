import prisma from '../../../plugin/prisma.js';
import { FastifyRequest, FastifyReply } from "fastify";

export interface LogoutBody {
    refreshToken: string
}


const logout = async (
    request: FastifyRequest< { Body: LogoutBody} >,
    reply: FastifyReply
) => {

    const { refreshToken } = request.body;

    try {

        const deleted = await prisma.refreshToken.deleteMany({
            where: { token: refreshToken}
        });

        if(deleted.count === 0) {
            return reply.status(401).send({
                success: false,
                message: "Invalid or expired refresh token"
            });
        }

        return reply.status(200).send({
            success: true,
            message: "Logged out successfully"
        });

       
        
    } catch (error) {
        console.error(error);
        return reply.status(500).send({
            success: false,
            message: "Internal server error"
        });
    }

}

export default logout;