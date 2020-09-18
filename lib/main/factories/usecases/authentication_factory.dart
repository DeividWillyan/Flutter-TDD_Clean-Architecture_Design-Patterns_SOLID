import 'package:flutter_avancado/data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';

import '../http/http.dart';

Authentication makeAuthentication() =>
    RemoteAuthentication(httpClient: makeHttpAdpter(), url: makeApiUrl('login'));
