import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/now_playing/data/models/now_playing_movie.dart';

class NowPlayingRemoteDatasource {
  List<NowPlayingModel> list = [];

  Future<dynamic> getNowPlayingData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/now_playing?api_key=4ca5bf2b2bd241d425c76c79df401e5f&page=1'));
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        // debugPrint(parsed);
        for (int i = 0; i < (parsed['results'] as List).length; i++) {
          list.add(NowPlayingModel.fromJson(parsed['results'][i]));
          print(list[i]);
        }

        return list;
        // return [
        //   for (final item in jsonDecode(response.body)) Results.fromJson(item)
        // ];
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
