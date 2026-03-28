import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeAiHubBanner extends StatelessWidget {
  const HomeAiHubBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
          decoration: BoxDecoration(
            color: const Color(0xFF052139).withValues(alpha: 0.7),
            border: Border(
              bottom: BorderSide(
                color: Colors.transparent, // Replaced with transparent since the figma showed rgba(0,0,0,0) with b-2 solid but no color in reality. 
                width: 2,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left side: Text Block
              Row(
                children: [
                  // Abstract Star icon placeholder
                  Container(
                    width: 46,
                    height: 46,
                    decoration: const BoxDecoration(
                      color: Colors.transparent, // Could add SVG icon here later
                    ),
                    child: const Icon(
                      Icons.hub_outlined, // Fallback icon
                      color: Color(0xFFACCAEA),
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'INTELLIGENCE\nLAYER',
                        style: GoogleFonts.inter(
                          color: const Color(0xFFACCAEA),
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 1.2,
                          height: 1.33,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'AI\nSummary\nHub',
                        style: GoogleFonts.newsreader(
                          color: const Color(0xFFC6C6C6),
                          fontSize: 30,
                          height: 1.2,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              // Right side: Launch Terminal
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'LAUNCH\nTERMINAL',
                    style: GoogleFonts.inter(
                      color: const Color(0xFFC6C6C6),
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.call_made_rounded, // Launch arrow icon
                    color: Color(0xFFC6C6C6),
                    size: 16,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
