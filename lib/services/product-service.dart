import '../data_models/product.dart';
import 'api_service.dart';

class ProductService {
  final ApiService apiService = ApiService();

  // Fetch all products
  Future<List<Product>> getProducts() async {
    final List<dynamic> jsonList = await apiService.getRequest("products");
    return jsonList.map((json) => Product.fromJson(json)).toList();
  }

  // Fetch a single product by ID
  Future<Product> getProduct(int id) async {
    final Map<String, dynamic> json = await apiService.getRequest("products/$id");
    return Product.fromJson(json);
  }
}
