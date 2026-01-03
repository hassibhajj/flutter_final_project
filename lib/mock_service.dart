import 'product.dart';

class MockService {
  static Future<List<Product>> fetchProducts() async {
    await Future.delayed(const Duration(milliseconds: 500)); // simulate network
    return [
      Product(
        id: 1,
        name: 'Organic Shampoo',
        description: 'Gentle, sulfate-free shampoo for daily use.',
        price: 34.99,
        stockQuantity: 20,
        image: 'https://picsum.photos/seed/shampoo/300/200',
      ),
      Product(
        id: 2,
        name: 'Moisturizing Cream',
        description: 'Hydrates dry skin with natural oils.',
        price: 18.99,
        stockQuantity: 15,
        image: 'https://picsum.photos/seed/cream/300/200',
      ),
      Product(
        id: 3,
        name: 'Face Cleanser',
        description: 'Foaming cleanser for oily skin.',
        price: 14.99,
        stockQuantity: 30,
        image: 'https://picsum.photos/seed/cleanser/300/200',
      ),
    ];
  }

  static Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 400));
    // Simple mock rule: any non-empty credentials succeed
    return email.isNotEmpty && password.isNotEmpty;
  }
}