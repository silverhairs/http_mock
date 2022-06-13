import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

/// A mock [http.Client] object to mock http methods.
class MockClient extends Mock implements http.Client {
  MockClient([Uri? uri]) {
    registerFallbackValue(uri ?? Uri());
  }

  /// Mocks a successful `POST` request.
  void postSucess<B>({required http.Response respondWith, B? body}) {
    when(
      () => post(
        any<Uri>(),
        body: any<B>(named: 'body'),
        headers: any<Map<String, String>>(named: 'headers'),
      ),
    ).thenAnswer(
      (_) => Future<http.Response>.value(respondWith),
    );
  }

  /// Mocks a failed http `POST` request on a body of type [B] and fails by
  /// throwing the specified exception of type [E].
  void postFailure<E extends Exception, B>({required E throwsA, B? body}) {
    when(
      () => post(
        any<Uri>(),
        body: any<B>(named: 'body'),
        headers: any<Map<String, String>>(named: 'headers'),
      ),
    ).thenThrow(throwsA);
  }

  /// Mocks a successful `GET` request.
  void getSuccess({required http.Response respondWith}) {
    when(
      () => get(
        any<Uri>(),
        headers: any<Map<String, String>>(named: 'headers'),
      ),
    ).thenAnswer((_) => Future<http.Response>.value(respondWith));
  }

  /// Mocks a failed http `GET` request and fails by throwing the specified
  /// exception.
  void getFailure<E extends Exception>({required E throwsA}) {
    when(
      () => get(
        any<Uri>(),
        headers: any<Map<String, String>>(named: 'headers'),
      ),
    ).thenThrow(throwsA);
  }

  /// Mocks a successful `PUT` request.
  void putSuccess<B>({required http.Response respondWith, B? body}) {
    when(
      () => put(
        any<Uri>(),
        body: any<B>(named: 'body'),
        headers: any<Map<String, String>>(named: 'headers'),
      ),
    ).thenAnswer((_) => Future<http.Response>.value(respondWith));
  }

  /// Mocks a failed http `PUT` request with a body of type [B] and fails by
  /// throwing the specified an exception of type [E].
  void putFailure<E extends Exception, B>({required E throwsA, B? body}) {
    when(
      () => put(
        any<Uri>(),
        body: any<B>(named: 'body'),
        headers: any<Map<String, String>>(named: 'headers'),
      ),
    ).thenThrow(throwsA);
  }

  /// Mocks a successful `PATCH` request that responds with the specified
  /// response in [respondWith].
  void patchSuccess<B>({required http.Response respondWith, B? body}) {
    when(
      () => patch(
        any<Uri>(),
        body: any<B>(named: 'body'),
        headers: any<Map<String, String>>(named: 'headers'),
      ),
    ).thenAnswer((_) => Future<http.Response>.value(respondWith));
  }

  void patchFailure<T extends Exception>({required T throwsA}) {}
}
