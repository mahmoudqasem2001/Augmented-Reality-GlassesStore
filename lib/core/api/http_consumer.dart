import 'dart:convert';
import 'package:http/http.dart';
import 'package:shop_app/core/api/api_consumer.dart';

class HttpConsumer extends ApiConsumer {
  final HttpConsumer client;

  HttpConsumer({required this.client});
  @override
  Future get(String path, {Map<String, dynamic>? queryParameters}) async {
    final response = await client.get(path, queryParameters: queryParameters);
    return jsonDecode(response.data.toString());
  }

  @override
  Future post(String path,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters}) async {
    final response =
        await client.post(path, queryParameters: queryParameters, body: body);
    return _handleResponseAsJson(response);
  }

  @override
  Future put(String path,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters}) async {
    final response =
        await client.post(path, queryParameters: queryParameters, body: body);
    return _handleResponseAsJson(response);
  }

  dynamic _handleResponseAsJson(Response response) {
    final responseJson = jsonDecode(response.body.toString());
    return responseJson;
  }
}
