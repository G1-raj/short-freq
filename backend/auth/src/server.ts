import Fastify from 'fastify';

const fastify = Fastify({logger: true});

fastify.get("/", async (request, reply) => {
    return { message: "Hello fastify" };
})

const start = async () => {
    try {
        await fastify.listen({ port: 3000 });
        console.log("Server is running at port: 3000");
    } catch (error) {
        fastify.log.error(`Error is: ${error}`);
        process.exit(1);
    }
}

start();
