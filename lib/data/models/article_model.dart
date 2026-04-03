import 'package:equatable/equatable.dart';

/// Data model for an article displayed on the Home screen.
class ArticleModel extends Equatable {
  final String id;
  final String title;
  final String category;
  final String source;
  final String timeAgo;
  final String? thumbnailUrl;

  const ArticleModel({
    required this.id,
    required this.title,
    required this.category,
    required this.source,
    required this.timeAgo,
    this.thumbnailUrl,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    category,
    source,
    timeAgo,
    thumbnailUrl,
  ];
}
