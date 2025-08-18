import { FastifyInstance } from "fastify";
import signup from "../controllers/auth/signup/signup.register.user.js";
import verify_email from "../controllers/auth/signup/verify_email.js";
import verifyOtp from "../controllers/auth/signup/verify_otp.js";
import login, { LoginBody } from "../controllers/auth/login/login.js";
import reset_password from "../controllers/auth/forgot_password/reset_password.js";
import loginLimitter from "../middlewares/login_limmiter.js";
import refreshToken from "../controllers/auth/refresh_token.js";
import verify_user from "../middlewares/verify_user.js";
import logout, { LogoutBody } from "../controllers/auth/logout/logout.js";

const standartRateLimit = {
    config: {
        rateLimit: {
            max: 10,
            timeWindow: '1 minute'
        }
    }
};


const authRoutes = async (fastify: FastifyInstance) => {

    fastify.post('/verify-email', standartRateLimit, verify_email);
    fastify.post('/verify-otp', standartRateLimit, verifyOtp);
    fastify.post('/signup', standartRateLimit, signup);

    fastify.post< { Body: LoginBody} >('/login', { ...standartRateLimit, preHandler: loginLimitter }, login);

    fastify.post('/reset-password', standartRateLimit, reset_password);

    fastify.post('/refresh', refreshToken);

    fastify.post< { Body: LogoutBody} >('/logout', { ...standartRateLimit, preHandler: verify_user}, logout);
}

export default authRoutes;