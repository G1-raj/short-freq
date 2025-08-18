import { FastifyRequest, FastifyReply } from "fastify";

const verify_user = async (
    request: FastifyRequest,
    reply: FastifyReply
) => {

    try {

        await request.jwtVerify();
        
    } catch (error) {
        return reply.status(401).send({
            success: false,
            message: "Unauthorized: Invalid or missing access token",
        });
    }

}

export default verify_user;