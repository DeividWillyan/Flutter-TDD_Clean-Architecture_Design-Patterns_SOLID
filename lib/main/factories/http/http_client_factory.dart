import 'package:http/http.dart';

import '../../../infra/http/http.dart';

HttpAdpter makeHttpAdpter() {
  final client = Client();
  return HttpAdpter(client);
}
