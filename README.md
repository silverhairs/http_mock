# Http Mock

A dart library that provides testing tools for the dart [http](https://pub.dev/packagse/http) package.

## Features

### MockClient:

A mock of the `Client` class from the http package. Provides shortcuts for testing http requests. f

Use `getSuccess` method to stub a successful `GET` request and pass the `respondWith` parameter as the `Response` that should be returned by the request.

**Instead of**

```dart
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart';

class MockClient extends Mock implements Client{}

void main(){
    const data = {'data':'test'};

    late final Client client;
    late final APIClient subject;

    setUpAll((){
        client = MockClient();
        subject = APIClient(client:client);

        when(() => client.get(any<Uri>())).thenAnswer(
            (_) => Future<Response>.value(Response(jsonEncode(data), 200)
            ,)
        ,)
    });

    test('should get the data from the API', (){
        expectLater(subject.getData(), completion({data}));
    });
}
```

**Do**

```dart
import 'package:http_mock/http_mock.dart';

void main(){
    const data = {'data':'test'};

    final client = MockClient();
    final APIClient subject = APIClient(client:client);;

    setUpAll(()=>client.getSuccess(respondWith: Response(jsonEncode(data), 200)));

    test('should get the data from the API', (){
        expectLater(subject.getData(), completion({data}));
    });
}
```
