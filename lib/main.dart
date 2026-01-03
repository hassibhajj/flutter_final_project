import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_theme.dart';
import 'product.dart';
import 'cart_item.dart';

import 'product_list_screen.dart';

void main() {
  runApp(const SimpleEcommerceApp());
}

class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];
  List<CartItem> get items => List.unmodifiable(_items);
  double get total => _items.fold(0.0, (sum, item) => sum + item.lineTotal);

  void add(Product product) {
    final index = _items.indexWhere((i) => i.product.id == product.id);
    if (index >= 0) {
      _items[index].quantity += 1;
    } else {
      _items.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void remove(Product product) {
    final index = _items.indexWhere((i) => i.product.id == product.id);
    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity -= 1;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

class UserModel extends ChangeNotifier {
  bool _loggedIn = false;
  String? _email;

  bool get isLoggedIn => _loggedIn;
  String? get email => _email;

  void login(String email) {
    _loggedIn = true;
    _email = email;
    notifyListeners();
  }

  void logout() {
    _loggedIn = false;
    _email = null;
    notifyListeners();
  }
}

class SimpleEcommerceApp extends StatelessWidget {
  const SimpleEcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartModel()),
        ChangeNotifierProvider(create: (_) => UserModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Simple E-Commerce',
        theme: AppTheme.lightTheme,
        home: const ProductListScreen(), //  Start at Home
      ),
    );
  }
}
