import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final double height;
  final double width;
  final String text;
  final Color textColor;
  final double textSize;
  final Color buttonColor;
  final Color borderColor;
  final double borderRadius;
  final VoidCallback? onPressed;
  const AppButton(
    {
      super.key,
      required this.height,
      required this.width,
      required this.text,
      required this.textColor,
      required this.buttonColor,
      this.borderColor = Colors.transparent,
      this.textSize = 18,
      this.borderRadius = 16,
      this.onPressed
    }
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(width: 1, color: borderColor)
          )
        ),
        child: Text(text, style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w700,
          fontSize: textSize
        ),),
      ),
    );
  }
}