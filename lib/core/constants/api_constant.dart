abstract class ApiConstants {
  static const String baseUrl = 'https://supermarket-dan1.onrender.com/api/v1';
  static const String register = "/auth/signUp";
  static const String login = "/auth/signIn";

  static const String getProByCategory = '/home/products/category';
  static const String getAllCategories = '/home/categories';
  static const String getAllProduct = '/home/products';
  static const String getFavorite = '/user/getFavorite';
  static const String addToFavorite = '/user/addFavorite';
  static const String removeFavorite = '/user/deleteFavorite';
  static const String search = '/home/productsFilter';

  static const String getCart = '/user/getCart';
  static const String addCart = '/user/addCart';
  static const String deleteCart = '/user/deleteCart';
  static const String getUserData = '/portfoilo/userData';
  static const String editUserData = '/portfoilo/editUserData';
  static const String uploadImage = '/portfoilo/addImage';
}
