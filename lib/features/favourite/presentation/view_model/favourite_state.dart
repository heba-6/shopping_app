import 'package:flutter/material.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';

@immutable
class FavouriteState {
  final FavouriteStatus status;
  final List<ProductsEntity> items;
  final String? errorMessage;
  final Set<int> processingProductIds;

  const FavouriteState({
    this.status = FavouriteStatus.initial,
    this.items = const [],
    this.errorMessage,
    this.processingProductIds = const {},
  });

  bool isFavourite(int productId) {
    return items.any((item) => item.id == productId);
  }

  bool isProcessing(int productId) {
    return processingProductIds.contains(productId);
  }

  FavouriteState copyWith({
    FavouriteStatus? status,
    List<ProductsEntity>? items,
    String? errorMessage,
    Set<int>? processingProductIds,
    bool clearError = false,
  }) {
    return FavouriteState(
      status: status ?? this.status,
      items: items ?? this.items,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      processingProductIds: processingProductIds ?? this.processingProductIds,
    );
  }
}

enum FavouriteStatus { initial, loading, success, failure }
