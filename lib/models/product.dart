import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

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

  Future<void> toggleFavoriteStatus() async {
    final bool oldStatus = favorite;
    try {
      //await http.patch(url);
    } catch (exception) {
      throw exception;
    }
    favorite = !favorite;
    notifyListeners();
  }
}
