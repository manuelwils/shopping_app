class Url {
  static const String baseUrl = 'http://a51b-105-113-12-252.ngrok.io/api';

  static const Map<String, Map<String, String>> to = {
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
      'delete': baseUrl + '/orders', //+id
    },
  };

  static const Map<String, Map<String, String>> headers = {
    'json_headers': {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    },
  };

  const Url();
}
