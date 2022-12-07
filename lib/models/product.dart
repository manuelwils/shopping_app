import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/Exceptions/HttpException.dart';

import '../Config/Url.dart';

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
    final _updateFavStatusUrl =
        Uri.parse(Url.to['product']!['patch']! + '/$id');
    bool? _oldStatus = favorite;

    favorite = !favorite;
    notifyListeners();

    final _response = await http.patch(
      _updateFavStatusUrl,
      body: {
        'favorite': favorite == true ? '1' : '0',
      },
    );

    if (_response.statusCode >= 400) {
      favorite = _oldStatus;
      _oldStatus = null;
      notifyListeners();
      throw const HttpException('Coudn\'t update favorite status');
    } else {
      _oldStatus = null;
    }
  }
}
