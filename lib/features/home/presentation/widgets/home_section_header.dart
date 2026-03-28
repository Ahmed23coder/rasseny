import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeSectionHeader extends StatelessWidget {
  const HomeSectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFF43474D).withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Side
          Text(
            'GLOBAL INTELLIGENCE\nSTREAM',
            style: GoogleFonts.inter(
              color: const Color(0xFFC3C6CE),
              fontSize: 10,
              fontWeight: FontWeight.w300,
              letterSpacing: 2.4,
              height: 1.33,
            ),
          ),
          
          // Right Side
          Text(
            'Updated 2m\nago',
            style: GoogleFonts.inter(
              color: const Color(0xFF8D9198),
              fontSize: 10,
              fontWeight: FontWeight.w300,
              height: 1.33,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}
