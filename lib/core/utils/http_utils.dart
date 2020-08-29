import 'dart:convert';
import 'dart:io';

class HttpUtils {
  static Future<String> post(String path, Object body) async {
    final HttpClient httpClient = new HttpClient();
    final HttpClientRequest request = await httpClient.postUrl(Uri.parse(path));
    request.headers.set('content-type', 'application/json');
    request.write(json.encode(body));
    final HttpClientResponse response = await request.close();
    final String responseJson = await response.transform(utf8.decoder).join();
    httpClient.close();
    return responseJson;
  }

  static Future<String> get(String path) async {
    final HttpClient httpClient = new HttpClient();
    final HttpClientRequest request = await httpClient.getUrl(Uri.parse(path));
    request.headers.set('content-type', 'application/json');
    final HttpClientResponse response = await request.close();
    final String responseJson = await response.transform(utf8.decoder).join();
    httpClient.close();
    return responseJson;
  }
}