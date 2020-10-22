import 'dart:convert';

import 'package:behavior_subject/src/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'geo.dart';

part 'address.g.dart';

abstract class Address implements Built<Address, AddressBuilder> {
  Address._();

  factory Address([updates(AddressBuilder b)]) = _$Address;

  @BuiltValueField(wireName: 'street')
  String get street;

  @BuiltValueField(wireName: 'suite')
  String get suite;

  @BuiltValueField(wireName: 'city')
  String get city;

  @BuiltValueField(wireName: 'zipcode')
  String get zipcode;

  @BuiltValueField(wireName: 'geo')
  Geo get geo;

  String toJson() {
    return json
        .encode(standardSerializer.serializeWith(Address.serializer, this));
  }

  static Address fromJson(String jsonString) {
    return standardSerializer.deserializeWith(
        Address.serializer, json.decode(jsonString));
  }

  static Serializer<Address> get serializer => _$addressSerializer;
}
