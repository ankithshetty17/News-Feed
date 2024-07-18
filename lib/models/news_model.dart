
import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  final String apiKey = '25110abf45f64ee1b90e51a94028948f';
  final String apiUrl = 'https://newsapi.org/v2/top-headlines';

  final String countryCode; // Add countryCode field

  NewsService({required this.countryCode});

  Future<List<Article>> fetchTopHeadlines() async {
    final String url = '$apiUrl?country=$countryCode&apiKey=$apiKey';
    final response = await http.get(Uri.parse(url));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    print(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List articles = data['articles'];
      return articles.map((article) => Article.fromJson(article)).toList();
    } else {
      throw Exception('Failed to load headlines');
    }
  }
}

class Article {
  final String title;
  final String description;
  final String urlToImage;

  Article({
    required this.title,
    required this.description,
    required this.urlToImage,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      urlToImage: json['urlToImage'] ?? '',
    );
  }
}
