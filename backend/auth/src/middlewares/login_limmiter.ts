import prisma from "../plugin/prisma.js";
import { FastifyRequest, FastifyReply } from "fastify";

const loginLimitter = async (
    request: FastifyRequest,
    reply: FastifyReply
) => {

    const { userId } = request.body as { userId: string, password: string }

    const user = await prisma.userDetails.findUnique({
        where: { userId }
    });

    if(!user) return;

    if(user.lockUntil && user.lockUntil > new Date) {
        const waitMinutes = Math.ceil(
            (user.lockUntil.getTime() - Date.now()) / (1000 / 60)
        );

        return reply.status(429).send({
            success: false,
            message: `Too many failed attempts, please try again after ${waitMinutes} minutes`
        });
    }

}

export default loginLimitter;