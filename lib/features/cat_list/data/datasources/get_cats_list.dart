import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:cat_brochure_app/core/constants/api_key.dart';
import 'package:cat_brochure_app/core/constants/urls.dart';
import 'package:cat_brochure_app/core/errors/exceptions.dart';
import 'package:cat_brochure_app/features/cat_list/data/models/cats_dto.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetCatsList {
  final http.Client _client;
  GetCatsList(this._client);

  int currentPage = 0;

  static const int fetchLimit = 15;
  static const int maxPageNumber = 3;

  Future<List<CatsDto>> getCatsByBreed(String breed) async {
    if (currentPage >= maxPageNumber) {
      throw NoMoreCatsException();
    }

    currentPage++;

    final response = await _client.get(
      Uri.parse(
          "${baseUrl}images/search?breed_ids=$breed&limit=$fetchLimit&page=$currentPage"),
      headers: {
        'x-api-key': apiKey,
      },
    );

    if (response.statusCode == 200) {
      List<CatsDto> listOfCats = [];
      for (Map<String, dynamic> res in jsonDecode(response.body)) {
        listOfCats.add(CatsDto.fromJson(res));
      }
      return listOfCats;
    } else {
      throw ServerException();
    }
  }

  void resetCurrentPage() => currentPage = 0;
}
