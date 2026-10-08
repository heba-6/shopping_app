import 'package:shopping_app/features/home/data/model/product_Response_dto.dart';

part 'home_cubit.dart';
@immutable
abstract Homeinitial extends HomeState{

}
class HProductloading extends Homestate{}

class HProductSuccess extends HomeState{
  final List<ProductItemEntity> ProductItemEntity;
  HProductSuccess(this.ProductItemEntity)
}
class HProducError extends HomeState{
  final String error;
  HProducError(this.error);
}
