import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/models/article_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeHeroCard extends StatelessWidget {
  final Article article;

  const HomeHeroCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFF1B1C1E),
        border: Border(
          bottom: BorderSide(color: Colors.white.withValues(alpha: 0.1), width: 1),
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          if (article.urlToImage != null && article.urlToImage!.isNotEmpty)
            CachedNetworkImage(
              imageUrl: article.urlToImage!,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(color: const Color(0xFF001428)),
              errorWidget: (context, url, error) => Container(color: const Color(0xFF001428)),
            )
          else
            Container(color: const Color(0xFF001428)),

          // Gradient Overlay
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color(0xFF001428),
                  Color(0x66001428), // 40%
                  Colors.transparent,
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
          ),

          // Vault Badge
          Positioned(
            top: 24,
            right: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF1B1C1E).withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: const Color(0xFFACCAEA).withValues(alpha: 0.2)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.shield_outlined, color: Color(0xFFC6C6C6), size: 12),
                  const SizedBox(width: 6),
                  Text(
                    'VAULT PROTECTED',
                    style: GoogleFonts.inter(
                      color: const Color(0xFFC6C6C6),
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          Positioned(
            bottom: 32,
            left: 32,
            right: 32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Category & Time
                Row(
                  children: [
                    Text(
                      article.sourceName.toUpperCase(),
                      style: GoogleFonts.inter(
                        color: const Color(0xFFACCAEA),
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 1.0,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      '/',
                      style: TextStyle(color: Color(0xFF43474D), fontSize: 10),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '12 MIN READ',
                      style: GoogleFonts.inter(
                        color: const Color(0xFFACCAEA),
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Title
                Text(
                  article.title,
                  style: GoogleFonts.newsreader(
                    color: const Color(0xFFC6C6C6),
                    fontSize: 36,
                    height: 1.25,
                    fontWeight: FontWeight.w200, // Extra Light
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                
                // Footer
                Text(
                  '${article.sourceName} • ${article.formattedDate}',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9AB8D8),
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
