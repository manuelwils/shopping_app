import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String? id;
  final String? title;
  final int? amount;
  final String? image;
  final String? desc;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.image,
    @required this.desc,
    this.isFavorite = false,
  });

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
