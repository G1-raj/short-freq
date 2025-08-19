import prisma from "../plugin/prisma.js";
import { FastifyRequest, FastifyReply } from "fastify";

const user = async (
    request: FastifyRequest,
    reply: FastifyReply
) => {
    try {

        const { userId } = request.user as { userId: string };

        const user = await prisma.userDetails.findUnique({
            where: { userId },
            select: {
                id: true,
                userId: true,
                name: true,
                email: true,
                phoneNumber: true,
                account: {
                    select: {
                        accountBalance: true
                    }
                }
            }
        });


        if(!user) {
            return reply.status(404).send({
                success: false,
                message: "User not found"
            });
        }

        return reply.status(200).send({
            success: true,
            message: "User fetched successfully",
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

export default user;