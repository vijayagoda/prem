import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  CustomText(this.text, this.color, this.size, this.weight, this.overflow,
      this.textAlign);
  final String text;
  final Color color;
  final double size;
  final FontWeight weight;
  final TextOverflow overflow;
  final TextAlign textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      textAlign: textAlign,
      style: GoogleFonts.metrophobic(
        fontSize: size,
        fontWeight: weight,
        color: color,
      ),
    );
  }
}
