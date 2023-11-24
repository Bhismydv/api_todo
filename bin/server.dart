import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'content.dart';

List<Article> content=[];

// Configure routes.
final _router = Router()
  ..get('/', _rootHandler)
  ..post('/content', _postArticlesHandler)
  ..get('/content', _getArticlesHandler);

Response _getArticlesHandler(Request request) {
  return Response.ok(articlesToJson(content));
}

Future<Response> _postArticlesHandler(Request request) async{
  String body = await request.readAsString();
  Article article = articleFromJson(body);
  content.add(article);
  return Response.ok(articleToJson(article));
}

Response _rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}

Response _echoHandler(Request request) {
  final message = request.params['message'];
  return Response.ok('$message\n');
}

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
