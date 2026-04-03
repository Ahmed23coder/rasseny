import '../../domain/repositories/news_repository.dart';
import '../models/article_model.dart';

/// Data-layer mock implementation of [NewsRepository].
class NewsRepositoryImpl implements NewsRepository {
  static const _categories = [
    'All',
    'Politics',
    'Technology',
    'Science',
    'Business',
    'Sports',
  ];

  static const _mockArticles = [
    ArticleModel(
      id: '1',
      title: 'Global AI Summit 2026: Key Takeaways and Future Projections',
      category: 'Technology',
      source: 'Reuters',
      timeAgo: '2h ago',
    ),
    ArticleModel(
      id: '2',
      title: 'Breakthrough in Quantum Computing Achieved by Research Team',
      category: 'Science',
      source: 'Nature',
      timeAgo: '4h ago',
    ),
    ArticleModel(
      id: '3',
      title: 'Markets Rally as Central Banks Signal Policy Shift',
      category: 'Business',
      source: 'Bloomberg',
      timeAgo: '6h ago',
    ),
    ArticleModel(
      id: '4',
      title: 'Champions League Semi-Finals Preview: What to Expect',
      category: 'Sports',
      source: 'ESPN',
      timeAgo: '8h ago',
    ),
    ArticleModel(
      id: '5',
      title: 'New Trade Agreements Reshape Global Economic Landscape',
      category: 'Politics',
      source: 'AP News',
      timeAgo: '12h ago',
    ),
  ];

  @override
  Future<List<String>> getCategories() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    return _categories;
  }

  @override
  Future<List<ArticleModel>> getTrendingArticles() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    return _mockArticles;
  }

  @override
  Future<List<ArticleModel>> getArticlesByCategory(String category) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    if (category == 'All') {
      return _mockArticles;
    }
    
    return _mockArticles.where((a) => a.category == category).toList();
  }
}
