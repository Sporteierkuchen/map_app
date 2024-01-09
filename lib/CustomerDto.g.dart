// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CustomerDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerDto _$CustomerDtoFromJson(Map<String, dynamic> json) => CustomerDto(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      street: json['street'] as String?,
      streetNumber: json['streetNumber'] as String?,
      zip: json['zip'] as String?,
      city: json['city'] as String?,
      customerNumber: json['customerNumber'] as String?,
      email: json['email'] as String?,
      uuid: json['uuid'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$CustomerDtoToJson(CustomerDto instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'street': instance.street,
      'streetNumber': instance.streetNumber,
      'zip': instance.zip,
      'city': instance.city,
      'customerNumber': instance.customerNumber,
      'email': instance.email,
      'uuid': instance.uuid,
      'password': instance.password,
    };
