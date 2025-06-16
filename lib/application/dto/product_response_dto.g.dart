// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductResponseDto _$ProductResponseDtoFromJson(Map<String, dynamic> json) =>
    ProductResponseDto(
      name: json['name'] as String,
      nutritionalQuality: json['nutritional_quality'] as String,
      ecologicalQuality: json['ecological_quality'] as String,
      isHealthy: json['is_healthy'] as bool,
      isEcological: json['is_ecological'] as bool,
      displayName: json['display_name'] as String,
      barcode: json['barcode'] as String?,
      brand: json['brand'] as String?,
      quantity: json['quantity'] as String?,
      nutriscoreGrade: json['nutriscore_grade'] as String?,
      ecoscoreGrade: json['ecoscore_grade'] as String?,
      imageUrl: json['image_url'] as String?,
      novaGroup: (json['nova_group'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductResponseDtoToJson(ProductResponseDto instance) =>
    <String, dynamic>{
      'barcode': instance.barcode,
      'name': instance.name,
      'brand': instance.brand,
      'quantity': instance.quantity,
      'nutriscore_grade': instance.nutriscoreGrade,
      'ecoscore_grade': instance.ecoscoreGrade,
      'image_url': instance.imageUrl,
      'nova_group': instance.novaGroup,
      'nutritional_quality': instance.nutritionalQuality,
      'ecological_quality': instance.ecologicalQuality,
      'is_healthy': instance.isHealthy,
      'is_ecological': instance.isEcological,
      'display_name': instance.displayName,
    };
