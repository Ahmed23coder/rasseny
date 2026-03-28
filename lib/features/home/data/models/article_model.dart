import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Article extends Equatable {
  final String title;
  final String? description;
  final String? urlToImage;
  final String? author;
  final DateTime publishedAt;
  final String sourceName;

  const Article({
    required this.title,
    this.description,
    this.urlToImage,
    this.author,
    required this.publishedAt,
    required this.sourceName,
  });

  String get formattedDate {
    return DateFormat('MMM d • h:mm a').format(publishedAt);
  }

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? 'No Title',
      description: json['description'],
      urlToImage: json['urlToImage'],
      author: json['author'],
      publishedAt: DateTime.parse(json['publishedAt']),
      sourceName: json['source']['name'] ?? 'Unknown Source',
    );
  }

  @override
  List<Object?> get props => [
        title,
        description,
        urlToImage,
        author,
        publishedAt,
        sourceName,
      ];
}
