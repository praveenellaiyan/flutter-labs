import 'dart:convert' as json;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:http_caching/src/serializers.dart';

import 'address.dart';
import 'company.dart';

part 'user.g.dart';

abstract class User implements Built<User, UserBuilder> {
  User._();

  factory User([updates(UserBuilder b)]) = _$User;

  @BuiltValueField(wireName: 'id')
  int get id;

  @BuiltValueField(wireName: 'name')
  @nullable
  String get name;

  @BuiltValueField(wireName: 'username')
  String get username;

  @BuiltValueField(wireName: 'email')
  String get email;

  @BuiltValueField(wireName: 'address')
  Address get address;

  @BuiltValueField(wireName: 'phone')
  String get phone;

  @BuiltValueField(wireName: 'website')
  String get website;

  @BuiltValueField(wireName: 'company')
  Company get company;

  String toJson() {
    return json
        .jsonEncode(standardSerializer.serializeWith(User.serializer, this));
  }

  static User fromJson(String jsonString) {
    return standardSerializer.deserializeWith(
        User.serializer, json.jsonDecode(jsonString));
  }

  static Serializer<User> get serializer => _$userSerializer;
}
