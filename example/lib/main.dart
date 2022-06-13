import 'example.dart';

Future<void> main() async {
  final server = Example();
  final todo = await server.getTodo('1');
  print(todo);
}
