import 'dart:convert';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

import '../../data/http/http.dart';

class HttpAdpter implements HttpClient {
  final Client client;
  HttpAdpter(this.client);

  Future<Map> request({
    @required String url,
    @required String method,
    Map body,
  }) async {
    final headers = {'content-type': 'application/json', 'accept': 'application/json'};
    final jsonBody = body != null ? jsonEncode(body) : null;
    final response = await client.post(url, headers: headers, body: jsonBody);
    return response.statusCode == 200 ? response.body.isEmpty ? null : jsonDecode(response.body) : null;
  }
}
