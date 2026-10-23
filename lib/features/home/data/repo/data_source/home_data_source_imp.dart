import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/home/data/api/api.dart';
import 'package:shopping_app/features/home/data/model/product_response_dto.dart';
import 'package:shopping_app/features/home/data/model/category_response_dto.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';
import 'package:shopping_app/features/home/domain/entities/category_entity.dart';
import 'package:shopping_app/features/home/domain/repo/home_data_source_interface.dart';

String getFriendlyErrorMessage(Object error) {
  if (error is DioException) {
    if (error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      return 'Check your internet connection and try again.';
    }

    if (error.type == DioExceptionType.badResponse) {
      final statusCode = error.response?.statusCode;

      if (statusCode == 401 || statusCode == 403) {
        return 'Please log in to continue.';
      }

      if (statusCode != null && statusCode >= 500) {
        return 'The server is temporarily unavailable. Try again later.';
      }
    }

    if (error.type == DioExceptionType.cancel) {
      return 'The request was cancelled.';
    }

    if (error.type == DioExceptionType.badCertificate) {
      return 'A secure connection could not be established.';
    }
  }

  return 'Something went wrong. Please try again.';
}

@LazySingleton(as: HomeDataSourceInterface)
class HomeDataSourceImpl implements HomeDataSourceInterface {
  final Api _api;

  HomeDataSourceImpl(this._api);

  @override
  Future<ResultApi<ProductResponseEntity>> getallproduct({
    required int skip,
    int limit = 10,
  }) async {
    try {
      final json = await _api.getAllProducts(skip: skip, limit: limit);

      final dto = ProductResponseDto.fromJson(json);

      final products = (dto.list ?? []).map((item) {
        return ProductItemEntity(
          id: item.id ?? 0,
          title: item.title ?? '',
          description: item.description ?? '',
          price: item.price ?? 0.0,
          discountPercentage: item.discountPercentage ?? 0.0,
          rating: item.rating ?? 0.0,
          images: item.images ?? [],
        );
      }).toList();

      return Success<ProductResponseEntity>(
        ProductResponseEntity(
          list: products,
          total: dto.total ?? 0,
          skip: dto.skip ?? skip,
          limit: dto.limit ?? limit,
        ),
      );
    } catch (e) {
      return Error<ProductResponseEntity>(getFriendlyErrorMessage(e));
    }
  }

  @override
  Future<ResultApi<List<CategoryEntity>>> getAllCategories() async {
    try {
      final json = await _api.getAllCategories();

      final dto = CategoryResponseDto.fromJson(json);

      final categories = (dto.list ?? []).map((item) {
        return CategoryEntity(
          slug: item.slug ?? '',
          name: item.name ?? '',
          url: item.url ?? '',
          image: item.image ?? '',
        );
      }).toList();

      return Success<List<CategoryEntity>>(categories);
    } catch (e) {
      return Error<List<CategoryEntity>>(getFriendlyErrorMessage(e));
    }
  }
}
