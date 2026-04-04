import 'article_model.dart';

class ArticleMockData {
  static const List<String> categories = [
    'All',
    'Technology',
    'Science',
    'Finance',
    'Health',
    'Entertainment',
    'Sports',
  ];

  static const List<ArticleModel> articles = [
    ArticleModel(
      id: '1',
      title: 'The Future of AI: Silicon Valley\'s Next Big Bet',
      category: 'Technology',
      source: 'TechCrunch',
      timeAgo: '2h ago',
      thumbnailUrl: null,
    ),
    ArticleModel(
      id: '2',
      title: 'Quantum Computing Reaches New Milestone in Stability',
      category: 'Science',
      source: 'Nature',
      timeAgo: '5h ago',
      thumbnailUrl: null,
    ),
    ArticleModel(
      id: '3',
      title: 'Global Markets Stabilize Amid Improved Economic Indicators',
      category: 'Finance',
      source: 'Bloomberg',
      timeAgo: '8h ago',
      thumbnailUrl: null,
    ),
    ArticleModel(
      id: '4',
      title: 'Breakthrough in Sustainable Fusion Energy Announced',
      category: 'Science',
      source: 'Scientific American',
      timeAgo: '12h ago',
      thumbnailUrl: null,
    ),
    ArticleModel(
      id: '5',
      title: 'Smartphone Innovation: What to Expect in 2026',
      category: 'Technology',
      source: 'Wired',
      timeAgo: '1d ago',
      thumbnailUrl: null,
    ),
  ];

  static const List<Map<String, String>> channels = [
    {'name': 'BBC News', 'followers': '25.4M', 'letter': 'B'},
    {'name': 'The Guardian', 'followers': '18.2M', 'letter': 'G'},
    {'name': 'Al Jazeera', 'followers': '12.8M', 'letter': 'A'},
    {'name': 'Reuters', 'followers': '22.1M', 'letter': 'R'},
    {'name': 'The New York Times', 'followers': '30.5M', 'letter': 'N'},
  ];
}
