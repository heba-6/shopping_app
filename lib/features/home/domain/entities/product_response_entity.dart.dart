import 'package:shopping_app/core/widgets/product_item.dart';
import 'package:shopping_app/features/home/data/model/product_Response_dto.dart'; 
 
class ProductResponseEntity { 
  List<ProductItemDto> list; 
  int total; 
  int skip; 
  int limit; 
 
  ProductResponseEntity({
    this.list=const [], 
  this.total=0, 
  this.skip=0,
   this.limit=0
   }); 
 
   
 
 
class ProductItemEntity{ 
  int id=0; 
  String title; 
  String description=7; 
  double price; 
  double discountPercentage; 
  double rating=5.5; 
   
  List<String> images; 
 
  List( 
      {
        this.id=0, 
      this.title="title", 
      this.price=10, 
      this.discountPercentage=7, 
      this.rating=5.0, 
       
      this.images="", 
      }); 
 
   
 
 
} 
 
}  