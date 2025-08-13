import 'package:flutter/material.dart';
import 'package:shortfreq/core/config/app_colors.dart';

class CustomFormField extends StatelessWidget {
  final double height;
  final double width;
  final String hintText;
  final IconData prefixIcon;
  const CustomFormField(
    {
      super.key,
      required this.height,
      required this.width,
      required this.hintText,
      required this.prefixIcon
    }
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon, color: AppColors.secondaryColor,),
          suffixIcon: Icon(Icons.wifi_calling_3, color: AppColors.successColor,),

          hintText: hintText,

          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(width: 1, color: AppColors.secondaryColor)
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(width: 1, color: AppColors.secondaryColor)
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
      )
    );
  }
}