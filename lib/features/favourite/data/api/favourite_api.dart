import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/constants/api_constant.dart';

@lazySingleton
class FavouriteApi {
  final Dio _dio;

  FavouriteApi(this._dio);

  Future<dynamic> getFavourites() async {
    final response = await _dio.get(ApiConstants.getFavorite);
    return response.data;
  }

  Future<void> addToFavourite({required int productId}) async {
    await _dio.post(ApiConstants.addToFavorite, data: {'productId': productId});
  }

  Future<void> removeFromFavourite({required int productId}) async {
    await _dio.delete(
      ApiConstants.removeFavorite,
      data: {'productId': productId},
    );
  }
}
