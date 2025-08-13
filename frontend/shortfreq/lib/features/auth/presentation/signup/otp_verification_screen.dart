import 'package:flutter/material.dart';
import 'package:shortfreq/core/config/app_colors.dart';
import 'package:shortfreq/core/widgets/app_button/app_button.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

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
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.02,),
          
                Text("Please enter the code", style: TextStyle(
                  color: AppColors.darkThemePrimaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: screenWidth * 0.08
                ),),
        
                SizedBox(
                  width: screenWidth * 0.85,
                  child: Text("We sent an email to example@gmail.com", 
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.darkThemePrimaryColor,
                      fontSize: screenWidth * 0.04
                  ),),
                ),

                SizedBox(
                  height: screenHeight * 0.02,
                ),

                Icon(Icons.mail, size: 50, color: Color.fromRGBO(150, 208, 241, 1),),

                SizedBox(
                  height: screenHeight * 0.02,
                ),

                OtpField(),

                SizedBox(
                  height: screenHeight * 0.02,
                ),

                GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Didn't get a mail?", style: TextStyle(
                          color: AppColors.darkThemePrimaryColor,
                          fontWeight: FontWeight.w500
                        ),),

                        SizedBox(width: screenWidth * 0.01,),

                        Text("send again", style: TextStyle(
                          color: AppColors.secondaryColor
                        ),)
                      ],
                    ),
                  ),

                  SizedBox(
                    height: screenHeight * 0.06,
                  ),

                  AppButton(
                    width: screenWidth * 0.85,
                    height: screenHeight * 0.06,
                    text: "Continue",
                    textColor: AppColors.whiteColor,
                    buttonColor: AppColors.buttonColor,
                    onPressed: () {
                      
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

class OtpField extends StatelessWidget {
  const OtpField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.1,
      color: Colors.blue,
    );
  }
}