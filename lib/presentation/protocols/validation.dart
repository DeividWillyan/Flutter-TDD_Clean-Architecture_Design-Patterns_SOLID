import 'package:meta/meta.dart';

abstract class Validation {
  validate({@required String field, @required String value});
}
