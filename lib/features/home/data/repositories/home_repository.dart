import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/api_constants.dart';
import '../models/article_model.dart';

class HomeRepository {
  Future<List<Article>> fetchTopHeadlines({String country = 'us'}) async {
    final response = await http.get(
      Uri.parse('${ApiConstants.newsBaseUrl}/top-headlines?country=$country&apiKey=${ApiConstants.newsApiKey}'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List articlesJson = data['articles'];
      return articlesJson.map((json) => Article.fromJson(json)).toList();
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized: Please check your API key.');
    } else if (response.statusCode == 429) {
      throw Exception('Rate Limit Exceeded: Please try again later.');
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<List<Article>> searchNews(String query) async {
    final response = await http.get(
      Uri.parse('${ApiConstants.newsBaseUrl}/everything?q=$query&apiKey=${ApiConstants.newsApiKey}'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List articlesJson = data['articles'];
      return articlesJson.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search news');
    }
  }
}
