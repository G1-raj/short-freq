import Fastify from 'fastify';
import { configDotenv } from 'dotenv';
import userRoutes from './routes/auth.routes.js'
import fastifyJwt from '@fastify/jwt';
import ratelimit from '@fastify/rate-limit';

configDotenv();

const fastify = Fastify({logger: true});
const availablePort = parseInt(process.env.PORT || "4000", 10);

const start = async () => {
    try {

        fastify.register(fastifyJwt, {
            secret: process.env.JWT_SECRET as string
        });

        fastify.register(ratelimit, {
            max: 100,
            timeWindow: '1 minute',
            ban: 2,
            keyGenerator: (req) => req.ip
        });

        fastify.register(userRoutes, { prefix: '/api/v1/' });


        await fastify.listen({ port: availablePort });
        console.log(`Server is running at port: ${availablePort}`);
    } catch (error) {
        fastify.log.error(`Error is: ${error}`);
        process.exit(1);
    }
}

start();
