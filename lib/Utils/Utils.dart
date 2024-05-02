import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yuktiidea/Constants/Colors.dart';

class Utils {
  showSnackBar(context, message) {
    var snackBar = SnackBar(
      content: Text(
        message,
        style: GoogleFonts.metrophobic(
          color: black,
          fontWeight: FontWeight.w400,
          fontSize: 10,
        ),
      ),
      backgroundColor: white,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
