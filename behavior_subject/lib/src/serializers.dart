import 'package:behavior_subject/src/address.dart';
import 'package:behavior_subject/src/company.dart';
import 'package:behavior_subject/src/geo.dart';
import 'package:behavior_subject/src/user.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

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
