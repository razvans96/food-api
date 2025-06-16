import 'package:food_api/domain/entities/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_response_dto.g.dart';

@JsonSerializable()
class ProductResponseDto {
  @JsonKey(name: 'barcode')
  final String? barcode;
  
  @JsonKey(name: 'name')
  final String name;
  
  @JsonKey(name: 'brand')
  final String? brand;
  
  @JsonKey(name: 'quantity')
  final String? quantity;
  
  @JsonKey(name: 'nutriscore_grade')
  final String? nutriscoreGrade;
  
  @JsonKey(name: 'ecoscore_grade')
  final String? ecoscoreGrade;
  
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  
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

  const ProductResponseDto({
    required this.name, required this.nutritionalQuality, required this.ecologicalQuality, required this.isHealthy, required this.isEcological, required this.displayName, this.barcode,
    this.brand,
    this.quantity,
    this.nutriscoreGrade,
    this.ecoscoreGrade,
    this.imageUrl,
    this.novaGroup,
  });

  factory ProductResponseDto.fromDomain(ProductEntity entity) {
    return ProductResponseDto(
      barcode: entity.barcode?.value,
      name: entity.name,
      brand: entity.brand,
      quantity: entity.quantity,
      nutriscoreGrade: entity.nutriscoreGrade,
      ecoscoreGrade: entity.ecoscoreGrade,
      imageUrl: entity.imageUrl,
      novaGroup: entity.novaGroup,
      nutritionalQuality: entity.nutritionalQuality.name,
      ecologicalQuality: entity.ecologicalQuality.name,
      isHealthy: entity.isHealthy(),
      isEcological: entity.isEcological(),
      displayName: entity.displayName,
    );
  }

  factory ProductResponseDto.fromJson(Map<String, dynamic> json) => 
      _$ProductResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseDtoToJson(this);
}
