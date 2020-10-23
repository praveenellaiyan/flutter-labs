import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:flutter_animation/src/address.dart';
import 'package:flutter_animation/src/company.dart';
import 'package:flutter_animation/src/geo.dart';
import 'package:flutter_animation/src/user.dart';

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
