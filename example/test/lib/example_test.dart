import 'dart:convert';

import 'package:http/http.dart';
import 'package:http_mock/http_mock.dart';
import 'package:test/test.dart';

import '../../lib/example.dart';

void main() {
  late final MockClient client;
  late final Example subject;

  final data = <String, dynamic>{
    'userId': 1,
    'title': 'John Cena',
    'completed': false,
  };

  setUpAll(() {
    client = MockClient()
      ..getSuccess(respondWith: Response(jsonEncode(data), 200))
      ..postSucess(body: data, respondWith: Response(jsonEncode(data), 200));

    subject = Example(client: client);
  });

  group('getTodo', () {
    test('should return the data', () {
      expectLater(subject.getTodo('1'), completion(data));
    });

    test('should throw a [$HttpFailure]', () {
      client.getFailure(throwsA: HttpFailure(StackTrace.current));
      expect(() => subject.getTodo('1'), throwsA(isA<HttpFailure>()));
    });
  });

  group('postSomething', () {
    test('should return the data', () {
      expectLater(subject.postSomething(data), completion(data));
    });

    test('should throw a [$HttpFailure]', () {
      client.postFailure(
        throwsA: Exception(),
        body: data,
      );

      expect(() => subject.postSomething(data), throwsA(isA<HttpFailure>()));
    });
  });
}
