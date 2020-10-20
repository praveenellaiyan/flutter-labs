import 'dart:convert' as json;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter_networking/src/serializers.dart';

part 'geo.g.dart';

abstract class Geo implements Built<Geo, GeoBuilder> {

  @BuiltValueField(wireName: 'lat')
  String get lat;
  @BuiltValueField(wireName: 'lng')
  String get lng;

  Geo._();
  factory Geo([void Function(GeoBuilder) updates]) = _$Geo;

  String toJson() {
    return json.jsonEncode(standardSerializer.serializeWith(Geo.serializer, this));
  }

  static Geo fromJson(String jsonString) {
    return standardSerializer.deserializeWith(
        Geo.serializer, json.jsonDecode(jsonString));
  }

  static Serializer<Geo> get serializer => _$geoSerializer;
}