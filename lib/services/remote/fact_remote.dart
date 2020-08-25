import 'package:dio/dio.dart';
import 'package:healthpadi/models/fact_category.dart';
import 'package:healthpadi/models/fact_list_response.dart';
import 'package:healthpadi/utilities/connections.dart';

class FactRemote {
  List<FactCategory> _categoriesCache = [];
  Future<FactListResponse> fetchFact(
      {int page = 1, FactCategory category}) async {
    try {
      final categoryQuery =
          category != null ? '&categoryId=${category.id}' : '';
      Response factsListResponse =
          await (await baseDio()).get('/facts?page=$page$categoryQuery');
      return FactListResponse.fromJson(factsListResponse.data);
    } catch (error) {
      return handleError(error: error, message: 'getting facts');
    }
  }

  Future<FactListResponse> fetchRandomFacts() async {
    try {
      Response factsListResponse =
          await (await baseDio()).get('/facts?random=true');
      return FactListResponse.fromJson(factsListResponse.data);
    } catch (error) {
      return handleError(error: error, message: 'getting facts');
    }
  }

  Future<List<FactCategory>> fetchCategories() async {
    try {
      if (_categoriesCache.isEmpty) {
        Response categoriesResponse =
            await (await baseDio()).get('/fact-categories');
        _categoriesCache = (categoriesResponse.data as List)
            .map((category) => FactCategory.fromJson(category))
            .toList();
      }
      return _categoriesCache;
    } catch (error) {
      return handleError(error: error, message: 'getting facts categories');
    }
  }
}
