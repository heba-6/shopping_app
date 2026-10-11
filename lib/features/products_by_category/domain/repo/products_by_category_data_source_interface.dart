abstract class ProductsByCategoryDataSourceInterface {
  Future<List<dynamic>> getProductsByCategory(String slug);
}
