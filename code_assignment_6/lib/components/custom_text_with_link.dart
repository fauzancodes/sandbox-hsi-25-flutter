import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextWithLink extends StatelessWidget {
  final String text;
  final String textLink;
  final Widget destination;

  const CustomTextWithLink({
    super.key,
    required this.text,
    required this.textLink,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF394675),
          ),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => destination),
            );
          },
          child: Text(
            textLink,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF394675),
            ),
          ),
        ),
      ],
    );
  }
}
