class Url {
  static const String baseUrl = 'https://f8e3-105-113-10-23.ngrok.io/api';

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
