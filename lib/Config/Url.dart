class Url {
  static const String baseUrl = 'https://b820-105-113-12-139.ngrok.io/api';
  static String token = '';

  static const Map<String, Map<String, String>> to = {
    'auth': {
      'register': baseUrl + '/auth/register',
      'login': baseUrl + '/auth/login',
    },
    'product': {
      'store': baseUrl + '/product/store',
      'fetch': baseUrl + '/product/fetch',
      'edit': baseUrl + '/product', //+id
      'delete': baseUrl + '/product', //+id
      'patch': baseUrl + '/product', //+id
    },
    'orders': {
      'store': baseUrl + '/orders/store',
      'fetch': baseUrl + '/orders/fetch',
    },
  };

  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };
}
