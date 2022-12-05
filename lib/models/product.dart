import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String? id;
  final String? title;
  final double? amount;
  final String? image;
  final String? description;
  bool favorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.image,
    @required this.description,
    this.favorite = false,
  });

  void toggleFavoriteStatus() {
    favorite = !favorite;
    notifyListeners();
  }
}
