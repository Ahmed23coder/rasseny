import '../../data/models/article_model.dart';

/// Domain-layer contract for article and news data fetching.
abstract class NewsRepository {
  /// Fetches available news categories.
  Future<List<String>> getCategories();

  /// Fetches trending news articles (default home view).
  Future<List<ArticleModel>> getTrendingArticles();

  /// Fetches news articles filtered by a specific category.
  Future<List<ArticleModel>> getArticlesByCategory(String category);
}
