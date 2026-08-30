import '../models/product.dart';
import '../models/category.dart';

class ProductService {
  Future<List<Category>> getCategories() async {
    // Simulación de datos locales o respuesta de API
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      Category(id: '1', name: 'Sensores', icon: 'sensors'),
      Category(id: '2', name: 'Hardware', icon: 'memory'),
    ];
  }

  Future<List<Product>> getProducts() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      Product(
        id: 'p1',
        name: 'Módulo Sensor de Batería',
        price: 29.99,
        categoryId: '1',
        imageUrl: 'https://via.placeholder.com/150',
      ),
      Product(
        id: 'p2',
        name: 'Controlador Adaptativo',
        price: 59.99,
        categoryId: '2',
        imageUrl: 'https://via.placeholder.com/150',
      ),
    ];
  }
}