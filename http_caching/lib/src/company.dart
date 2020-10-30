import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:http_caching/src/serializers.dart';

part 'company.g.dart';

abstract class Company implements Built<Company, CompanyBuilder> {
  Company._();

  factory Company([updates(CompanyBuilder b)]) = _$Company;

  @BuiltValueField(wireName: 'name')
  String get name;

  @BuiltValueField(wireName: 'catchPhrase')
  String get catchPhrase;

  @BuiltValueField(wireName: 'bs')
  String get bs;

  String toJson() {
    return json
        .encode(standardSerializer.serializeWith(Company.serializer, this));
  }

  static Company fromJson(String jsonString) {
    return standardSerializer.deserializeWith(
        Company.serializer, json.decode(jsonString));
  }

  static Serializer<Company> get serializer => _$companySerializer;
}
