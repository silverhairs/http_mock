import 'dart:convert';

import 'package:http/http.dart';

class Example {
  Example({Client? client}) : _client = client ?? Client();

  final Client _client;

  static String authority = 'jsonplaceholder.typicode.com';

  Future<Map<String, dynamic>> getTodo(String id) async {
    final uri = Uri.https(authority, '/todos/$id');
    late final Response response;

    try {
      response = await _client.get(uri);
    } catch (e, s) {
      throw HttpFailure(s);
    }

    if (response.statusCode > 299 || response.statusCode < 200) {
      throw HttpFailure(StackTrace.current);
    }
    final decoded = json.decode(response.body) as Map<String, dynamic>;
    return decoded;
  }

  Future<Map<String, dynamic>> postSomething(
    Map<String, dynamic> something,
  ) async {
    final uri = Uri.https(authority, '/todos/');
    late final Response response;

    try {
      response = await _client.post(uri, body: something);
    } catch (e, s) {
      throw HttpFailure(s);
    }

    if (response.statusCode > 299 || response.statusCode < 200) {
      throw HttpFailure(StackTrace.current);
    }
    final decoded = json.decode(response.body) as Map<String, dynamic>;
    return decoded;
  }
}

class HttpFailure implements Exception {
  const HttpFailure(this.stackTrace);
  final StackTrace stackTrace;
}
