import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shortfreq/core/config/app_colors.dart';
import 'package:shortfreq/core/widgets/app_button/app_button.dart';
import 'package:shortfreq/core/widgets/google_login_button/google_login_button.dart';

class AuthNavigator extends StatelessWidget {
  const AuthNavigator({super.key});

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,

      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.12, right: screenWidth * 0.12, top: screenHeight * 0.04, bottom: screenHeight * 0.04),
                  child: Text("Hello! Start your crypto Investment today", 
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.075,
                  ),),
                ),

                SizedBox(height: 18,),

                GoogleLoginButton(
                  width: screenWidth * 0.85,
                  height: screenHeight * 0.06,
                  text: "Continue with Google",
                  textColor: AppColors.buttonColor,
                  buttonColor: AppColors.whiteColor,
                  borderColor: AppColors.greayColor,
                  onPressed: () {},
                ),

                SizedBox(height: screenHeight * 0.03,),

                AppButton(
                  width: screenWidth * 0.85,
                  height: screenHeight * 0.06,
                  text: "Login with email",
                  textColor: AppColors.whiteColor,
                  buttonColor: AppColors.buttonColor,
                  onPressed: () {
                    GoRouter.of(context).push("/login");
                  },
                ),

                SizedBox(height: screenHeight * 0.34,),

                GestureDetector(
                  child: Text("Don't have an account?", style: TextStyle(
                    color: AppColors.greayColor,
                    fontWeight: FontWeight.w600
                  ),)
                ),

                SizedBox(height: screenHeight * 0.03,),

                AppButton(
                  width: screenWidth * 0.85,
                  height: screenHeight * 0.06,
                  text: "Sign In",
                  textColor: AppColors.buttonColor,
                  buttonColor: AppColors.whiteColor,
                  borderColor: AppColors.buttonColor,
                  onPressed: () {
                    GoRouter.of(context).push("/signup");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}