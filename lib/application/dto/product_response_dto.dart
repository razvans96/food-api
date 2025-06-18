import 'package:food_api/domain/entities/product_entity.dart';
import 'package:food_api/domain/value_objects/nutritional_value.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_response_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductResponseDto {
  @JsonKey(name: 'barcode')
  final String? barcode;
  
  @JsonKey(name: 'name')
  final String name;
  
  @JsonKey(name: 'brand')
  final String? brand;
  
  @JsonKey(name: 'quantity')
  final String? quantity;
  
  @JsonKey(name: 'image_url')
  final String? imageUrl;

  @JsonKey(name: 'nutriscore_grade')
  final String? nutriscoreGrade;
  
  @JsonKey(name: 'ecoscore_grade')
  final String? ecoscoreGrade;
  
  @JsonKey(name: 'nova_group')
  final int? novaGroup;
  
  @JsonKey(name: 'nutritional_quality')
  final String nutritionalQuality;
  
  @JsonKey(name: 'ecological_quality')
  final String ecologicalQuality;
  
  @JsonKey(name: 'is_healthy')
  final bool isHealthy;
  
  @JsonKey(name: 'is_ecological')
  final bool isEcological;

  @JsonKey(name: 'display_name')
  final String displayName;
  
  @JsonKey(name: 'nutritional_values')
  final NutritionalValues? nutritionalValues; 

  @JsonKey(name: 'ingredients')
  final List<String>? ingredients;

  @JsonKey(name: 'allergens')
  final List<String>? allergens;

  @JsonKey(name: 'additives')
  final List<String>? additives;

  @JsonKey(name: 'categories')
  final List<String>? categories;

  const ProductResponseDto({
    required this.name, required this.nutritionalQuality, required this.ecologicalQuality, required this.isHealthy, required this.isEcological, required this.displayName, 
    this.barcode,
    this.brand,
    this.quantity,
    this.imageUrl,
    this.nutriscoreGrade,
    this.ecoscoreGrade,
    this.novaGroup,
    this.nutritionalValues,
    this.ingredients,
    this.allergens,
    this.additives,
    this.categories,
  });

  factory ProductResponseDto.fromDomain(ProductEntity entity) {
    return ProductResponseDto(
      barcode: entity.barcode?.value,
      name: entity.name,
      brand: entity.brand,
      quantity: entity.quantity,
      imageUrl: entity.imageUrl,
      nutriscoreGrade: entity.nutriscoreGrade,
      ecoscoreGrade: entity.ecoscoreGrade,
      novaGroup: entity.novaGroup,
      nutritionalQuality: entity.nutritionalQuality.name,
      ecologicalQuality: entity.ecologicalQuality.name,
      isHealthy: entity.isHealthy(),
      isEcological: entity.isEcological(),
      displayName: entity.displayName,
      nutritionalValues: entity.nutritionalValues,
      ingredients: entity.ingredients,
      allergens: entity.allergens,
      additives: entity.additives,
      categories: entity.categories,
    );
  }

  factory ProductResponseDto.fromJson(Map<String, dynamic> json) => 
      _$ProductResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseDtoToJson(this);
}
