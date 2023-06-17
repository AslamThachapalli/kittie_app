import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double? fontSize;
  final int? maxLines;
  final TextAlign? textAlign;

  const SmallText({
    super.key,
    required this.text,
    this.textColor,
    this.fontSize,
    this.maxLines,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
      style: TextStyle(
        color: textColor ?? Colors.black87,
        fontSize: fontSize ?? 12,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
