class Url {
  static const String baseUrl = 'http://7d46-105-113-12-252.ngrok.io/api';

  static const Map<String, Map<String, String>> to = {
    'product': {
      'store': baseUrl + '/product/store',
      'fetch': baseUrl + '/product/fetch',
      'edit': baseUrl + '/product', //+id
      'delete': baseUrl + '/product', //+id
      'patch': baseUrl + '/product', //+id
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
