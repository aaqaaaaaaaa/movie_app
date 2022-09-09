import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/movie_details/data/models/movie_details_model.dart';

class MovieDetailsRemoteDatasource {
  Future<dynamic> getMovieDetailsData(int id) async {
    // final List<MovieDetailModel> list = [];
    {
      try {
        final response = await http.get(Uri.parse(
            'https://api.themoviedb.org/3/movie/$id?api_key=4ca5bf2b2bd241d425c76c79df401e5f&page=1'));
        if (response.statusCode == 200) {
          // return list;
          print(response.body);
          return MovieDetailsModel.fromJson(jsonDecode(response.body));
        } else {
          return {};
        }
      } catch (e) {
        return null;
      }
    }
  }
}
