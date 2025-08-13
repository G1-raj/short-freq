import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shortfreq/core/config/app_colors.dart';
import 'package:shortfreq/core/widgets/app_button/app_button.dart';
import 'package:shortfreq/core/widgets/custom_form_field/custom_form_field.dart';
import 'package:shortfreq/core/widgets/google_login_button/google_login_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(

      backgroundColor: AppColors.whiteColor,

      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
      ),

      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.12, right: screenWidth * 0.12),
                    child: Text("Login to your Account", 
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.075,
                    ),),
                  ),

                  SizedBox(
                    height: screenHeight * 0.05,
                  ),

                  CustomFormField(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.06,
                    hintText: "Email",
                    prefixIcon: Icons.mail_outline,
                  ),

                  SizedBox(
                    height: screenHeight * 0.02,
                  ),

                  CustomFormField(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.06,
                    hintText: "Password",
                    prefixIcon: Icons.lock_outline,
                  ),

                  SizedBox(
                    height: screenHeight * 0.02,
                  ),

                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Forgot your password?", style: TextStyle(
                          color: AppColors.darkThemePrimaryColor,
                          fontWeight: FontWeight.w500
                        ),),

                        SizedBox(width: screenWidth * 0.01,),

                        Text("Click here", style: TextStyle(
                          color: AppColors.secondaryColor
                        ),)
                      ],
                    ),
                  ),

                  SizedBox(
                    height: screenHeight * 0.02,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Unlock with fingerprint?"),
                      CupertinoSwitch(
                        activeTrackColor: AppColors.secondaryColor,
                        inactiveTrackColor: AppColors.greayColor,
                        value: false, 
                        onChanged: (value) {}
                      )
                    ],
                  ),


                  SizedBox(
                    height: screenHeight * 0.02,
                  ),

                  AppButton(
                    width: screenWidth * 0.85,
                    height: screenHeight * 0.06,
                    text: "Login",
                    textColor: AppColors.whiteColor,
                    buttonColor: AppColors.buttonColor,
                    onPressed: () {
                      
                    },
                  ),

                  SizedBox(
                    height: screenHeight * 0.15,
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