import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/models/article_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeStandardCard extends StatelessWidget {
  final Article article;

  const HomeStandardCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          if (article.urlToImage != null && article.urlToImage!.isNotEmpty)
            Container(
              height: 200,
              width: double.infinity,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                color: Color(0xFF001428),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: article.urlToImage!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const SizedBox(),
                    errorWidget: (context, url, error) => const SizedBox(),
                  ),
                  // Slight bottom gradient for blending if needed, matching 'Gradient' node
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Color(0xFF001428),
                          Colors.transparent,
                        ],
                        stops: [0.0, 0.5],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          
          const SizedBox(height: 24),
          
          // Content Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  article.title,
                  style: GoogleFonts.newsreader(
                    color: const Color(0xFFC6C6C6),
                    fontSize: 24,
                    height: 1.33,
                    fontWeight: FontWeight.w200,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: 12),
                
                // Description
                Text(
                  article.description ?? '',
                  style: GoogleFonts.newsreader(
                    color: const Color(0xFFC3C6CE),
                    fontSize: 16,
                    height: 1.5,
                    fontWeight: FontWeight.w200,
                    fontStyle: FontStyle.italic,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: 16),
                
                // Footer
                Row(
                  children: [
                    Text(
                      article.sourceName.toUpperCase(),
                      style: GoogleFonts.inter(
                        color: const Color(0xFFACCAEA),
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      article.formattedDate.toUpperCase(),
                      style: GoogleFonts.inter(
                        color: const Color(0xFF8D9198),
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
