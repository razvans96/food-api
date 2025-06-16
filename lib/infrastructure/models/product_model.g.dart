// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      productBarcode: json['product_barcode'] as String?,
      productName: json['product_name'] as String?,
      productBrand: json['product_brand'] as String?,
      productQuantity: json['product_quantity'] as String?,
      productNutriscoreGrade: json['product_nutriscore_grade'] as String?,
      productEcoscoreGrade: json['product_ecoscore_grade'] as String?,
      productImageUrl: json['product_image_url'] as String?,
      productNovaGroup: (json['product_nova_group'] as num?)?.toInt(),
      productCreatedAt: json['product_created_at'] == null
          ? null
          : DateTime.parse(json['product_created_at'] as String),
      productUpdatedAt: json['product_updated_at'] == null
          ? null
          : DateTime.parse(json['product_updated_at'] as String),
      productNutritionalData: json['product_nutritional_data'] as String?,
      productIngredients: json['product_ingredients'] as String?,
      productAllergens: json['product_allergens'] as String?,
      productAdditives: json['product_additives'] as String?,
      productCategories: json['product_categories'] as String?,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'product_barcode': instance.productBarcode,
      'product_name': instance.productName,
      'product_brand': instance.productBrand,
      'product_quantity': instance.productQuantity,
      'product_nutriscore_grade': instance.productNutriscoreGrade,
      'product_ecoscore_grade': instance.productEcoscoreGrade,
      'product_image_url': instance.productImageUrl,
      'product_nova_group': instance.productNovaGroup,
      'product_created_at': instance.productCreatedAt?.toIso8601String(),
      'product_updated_at': instance.productUpdatedAt?.toIso8601String(),
      'product_nutritional_data': instance.productNutritionalData,
      'product_ingredients': instance.productIngredients,
      'product_allergens': instance.productAllergens,
      'product_additives': instance.productAdditives,
      'product_categories': instance.productCategories,
    };
