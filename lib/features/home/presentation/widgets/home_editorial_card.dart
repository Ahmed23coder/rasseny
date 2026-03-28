import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/models/article_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeEditorialCard extends StatelessWidget {
  final Article article;

  const HomeEditorialCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF011D35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 37, 40, 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Urgent Intelligence Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: const BoxDecoration(
                    color: Color(0xFF2C4964),
                  ),
                  child: Text(
                    'URGENT INTELLIGENCE',
                    style: GoogleFonts.inter(
                      color: const Color(0xFFACCAEA),
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                
                const SizedBox(height: 22),
                
                // Quote / Title
                Text(
                  '"${article.title}"',
                  style: GoogleFonts.newsreader(
                    color: const Color(0xFFC6C6C6),
                    fontSize: 36,
                    height: 1.11,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w200, // Extra Light Italic
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Author row
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 1,
                      color: const Color(0xFFACCAEA),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        '${article.sourceName.toUpperCase()} / Analyst',
                        style: GoogleFonts.inter(
                          color: const Color(0xFFC3C6CE),
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Bottom Portrait Image
          if (article.urlToImage != null && article.urlToImage!.isNotEmpty)
            SizedBox(
              height: 350,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: article.urlToImage!,
                fit: BoxFit.cover,
                colorBlendMode: BlendMode.saturation, // The design specifies mix-blend-saturation for the image overlay
                placeholder: (context, url) => Container(color: const Color(0xFF001428)),
                errorWidget: (context, url, error) => Container(color: const Color(0xFF001428)),
              ),
            ),
            
        ],
      ),
    );
  }
}
