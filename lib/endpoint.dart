class Endpoint {
  static const apiSchema = 'https';
  static const apiHost = 'fluttercrashcourse.com';
  static const prefix = '/api/v1';

  static Uri uri(String path, {Map<String, dynamic>? queryParameters}) {
    final uri = Uri(
        scheme: apiSchema,
        host: apiHost,
        path: '$prefix$path',
        queryParameters: queryParameters);
    return uri;
  }
}
