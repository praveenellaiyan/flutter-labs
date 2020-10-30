import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:http_caching/src/address.dart';
import 'package:http_caching/src/company.dart';
import 'package:http_caching/src/geo.dart';
import 'package:http_caching/src/user.dart';

part 'serializers.g.dart';

@SerializersFor([
  Address,
  Geo,
  Company,
  User,
])
final Serializers serializers = _$serializers;

Serializers standardSerializer =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
