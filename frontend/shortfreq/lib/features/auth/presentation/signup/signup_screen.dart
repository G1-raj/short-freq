import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shortfreq/core/config/app_colors.dart';
import 'package:shortfreq/core/widgets/app_button/app_button.dart';
import 'package:shortfreq/core/widgets/google_login_button/google_login_button.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(

      backgroundColor: AppColors.homeBackgroundColor,

      appBar: AppBar(
        backgroundColor: AppColors.homeBackgroundColor,
      ),

      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
          
                  SizedBox(height: screenHeight * 0.02,),
          
                  Text("What's your email?", style: TextStyle(
                    color: AppColors.darkThemePrimaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: screenWidth * 0.08
                  ),),
          
                  SizedBox(
                    width: screenWidth * 0.85,
                    child: Text("Enter the email address you want to use to register with us", 
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.darkThemePrimaryColor,
                        fontSize: screenWidth * 0.04
                    ),),
                  ),
          
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),
          
                  SizedBox(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.06,
                    child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: AppColors.whiteColor,
                        prefixIcon: Icon(Icons.mail_outline, color: AppColors.greayColor,),
                        hintText: "Email Address",
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(width: 2, color: AppColors.greayColor)
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(width: 2, color: AppColors.greayColor)
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(width: 1, color: AppColors.secondaryColor)
                        ),

                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(width: 1, color: AppColors.errorColor)
                        )
                      ),
                    ),
                  ),

                  SizedBox(
                    height: screenHeight * 0.02,
                  ),

                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Have an account?", style: TextStyle(
                          color: AppColors.darkThemePrimaryColor,
                          fontWeight: FontWeight.w500
                        ),),

                        SizedBox(width: screenWidth * 0.01,),

                        Text("Login here", style: TextStyle(
                          color: AppColors.secondaryColor
                        ),)
                      ],
                    ),
                  ),

                  SizedBox(
                    height: screenHeight * 0.2,
                  ),

                   AppButton(
                    width: screenWidth * 0.85,
                    height: screenHeight * 0.06,
                    text: "Continue",
                    textColor: AppColors.whiteColor,
                    buttonColor: AppColors.buttonColor,
                    onPressed: () {
                      GoRouter.of(context).push('/verify-otp');
                    },
                  ),

                  SizedBox(
                    height: screenHeight * 0.03,
                  ),

                  SizedBox(
                    width: screenWidth * 0.95,
                    child: Text("By registering you accept our Terms & Conditions and Privacy Policy. Your data will be security encrypted with TLS", 
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.darkThemePrimaryColor,
                        fontSize: screenWidth * 0.03
                    ),),
                  ),

                  SizedBox(
                    height: screenHeight * 0.05,
                  ),

                  Text("or continue with", style: TextStyle(
                    color: AppColors.greayColor
                  ),),

                  SizedBox(
                    height: screenHeight * 0.02,
                  ),

                  GoogleLoginButton(
                    width: screenWidth * 0.85,
                    height: screenHeight * 0.06,
                    text: "Continue with Google",
                    textColor: AppColors.buttonColor,
                    buttonColor: AppColors.whiteColor,
                    borderColor: AppColors.greayColor,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}