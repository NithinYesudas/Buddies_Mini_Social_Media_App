import 'package:buddies/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccessoryWidgets {
  static void snackBar(String message, BuildContext ctx) {
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
      content: Text(
        message,
        style: GoogleFonts.nunitoSans(),
      ),
      backgroundColor: CustomColors.red,
    ));
  }
}
