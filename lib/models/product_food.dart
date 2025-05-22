import 'package:json_annotation/json_annotation.dart';

part 'product_food.g.dart';

@JsonSerializable()
class ProductFood {
  final String? name;
  final String? brand;
  final String? quantity;
  final String? nutriscoreGrade;
  final String? ecoscoreGrade;
  final String? imageUrl;
  final int? novaGroup;

  ProductFood({
    this.name,
    this.brand,
    this.quantity,
    this.nutriscoreGrade,
    this.ecoscoreGrade,
    this.imageUrl,
    this.novaGroup,
  });

  factory ProductFood.fromJson(Map<String, dynamic> json) => _$ProductFoodFromJson(json);

  Map<String, dynamic> toJson() => _$ProductFoodToJson(this);
}
