import 'package:json_annotation/json_annotation.dart';

part 'CustomerDto.g.dart';

@JsonSerializable()
class CustomerDto {
  String? firstName;
  String? lastName;
  String? street;
  String? streetNumber;
  String? zip;
  String? city;

  String? customerNumber;
  String? email;
  String? uuid;
  String? password;

  CustomerDto({
    this.firstName,
    this.lastName,
    this.street,
    this.streetNumber,
    this.zip,
    this.city,

    this.customerNumber,
    this.email,
    this.uuid,
    this.password
  });

  factory CustomerDto.fromJson(Map<String, dynamic> json) =>
      _$CustomerDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerDtoToJson(this);
}
