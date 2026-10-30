import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/favourite/data/api/favourite_api.dart';
import 'package:shopping_app/features/favourite/data/model/favourite_dto.dart';
import 'package:shopping_app/features/favourite/domain/repo/favourite_data_source_interface.dart';

@LazySingleton(as: FavouriteDataSourceInterface)
class FavouriteDataSourceImp implements FavouriteDataSourceInterface {
  final FavouriteApi _api;

  FavouriteDataSourceImp(this._api);

  @override
  Future<ResultApi<List<ProductsEntity>>> getFavourites() async {
    try {
      final response = await _api.getFavourites();
      final rawList = _extractList(response);

      final items = rawList
          .whereType<Map>()
          .map(
            (item) => FavouriteDto.fromJson(
              Map<String, dynamic>.from(item),
            ).toEntity(),
          )
          .toList();

      return Success<List<ProductsEntity>>(items);
    } catch (e) {
      return Error<List<ProductsEntity>>(_errorMessage(e));
    }
  }

  @override
  Future<ResultApi<void>> addToFavourite({required int productId}) async {
    try {
      await _api.addToFavourite(productId: productId);
      return Success<void>(null);
    } catch (e) {
      return Error<void>(_errorMessage(e));
    }
  }

  @override
  Future<ResultApi<void>> removeFromFavourite({required int productId}) async {
    try {
      await _api.removeFromFavourite(productId: productId);
      return Success<void>(null);
    } catch (e) {
      return Error<void>(_errorMessage(e));
    }
  }

  List<dynamic> _extractList(dynamic response) {
    if (response is List) return response;

    if (response is Map) {
      for (final key in [
        'data',
        'favorites',
        'favourites',
        'list',
        'products',
      ]) {
        final value = response[key];

        if (value is List) return value;

        if (value is Map) {
          final nested = _extractList(value);
          if (nested.isNotEmpty) return nested;
        }
      }
    }

    return [];
  }

  String _errorMessage(Object error) {
    if (error is DioException) {
      final data = error.response?.data;

      if (data is Map && data['message'] != null) {
        return data['message'].toString();
      }

      return error.message ?? 'Something went wrong. Please try again.';
    }

    return 'Something went wrong. Please try again.';
  }
}
