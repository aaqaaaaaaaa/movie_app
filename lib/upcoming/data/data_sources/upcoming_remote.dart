import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/popular/data/models/popular_model.dart';
import 'package:movie_app/upcoming/data/models/upcoming_movie.dart';

class UpcomingRemote {
  final List<UpcomingModel> list = [];

  Future<dynamic> getUpcomingMovie() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/upcoming?api_key=4ca5bf2b2bd241d425c76c79df401e5f&page=1'));
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        for (int i = 0; i < (parsed['results'] as List).length; i++) {
          list.add(UpcomingModel.fromJson(parsed['results'][i]));
        }

        return list;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
