import nodemailer from "nodemailer";

const transporter = nodemailer.createTransport(
    {
        secure: true,
        host: "smtp.gmail.com",
        port: 465,
        auth: {
            user: "gullurajput18@gmail.com",
            pass: "brofislqtqsfhtty"
        }
    }
);

const send_mail = (to: string, otp: string) => {
    transporter.sendMail(
        {
            to: to,
            subject: "Shortfreq email verification code",
            html: `Your verification otp for shortfreqtr trading application is: ${otp}`
        }
    );
}

export default send_mail;