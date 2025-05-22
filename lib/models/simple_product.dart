import 'package:json_annotation/json_annotation.dart';

part 'simple_product.g.dart';

@JsonSerializable()
class SimpleProduct {
  final String? name;
  final String? brands;

  SimpleProduct({this.name, this.brands});

  /// Generado automáticamente por json_serializable
  factory SimpleProduct.fromJson(Map<String, dynamic> json) => _$SimpleProductFromJson(json);

  /// Generado automáticamente por json_serializable
  Map<String, dynamic> toJson() => _$SimpleProductToJson(this);
}
