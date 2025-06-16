// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'openfoodfacts_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenFoodFactsProductDto _$OpenFoodFactsProductDtoFromJson(
        Map<String, dynamic> json) =>
    OpenFoodFactsProductDto(
      productName: json['product_name'] as String?,
      brands: json['brands'] as String?,
      quantity: json['quantity'] as String?,
      nutriscoreGrade: json['nutriscore_grade'] as String?,
      ecoscoreGrade: json['ecoscore_grade'] as String?,
      imageFrontSmallUrl: json['image_front_small_url'] as String?,
      novaGroup: (json['nova_group'] as num?)?.toInt(),
      barcode: json['code'] as String?,
      nutriments: json['nutriments'] as Map<String, dynamic>?,
      ingredientsTags: (json['ingredients_tags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      allergensTags: (json['allergens_tags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      additivesTags: (json['additives_tags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      categoriesTags: (json['categories_tags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$OpenFoodFactsProductDtoToJson(
        OpenFoodFactsProductDto instance) =>
    <String, dynamic>{
      'code': instance.barcode,
      'product_name': instance.productName,
      'brands': instance.brands,
      'image_front_small_url': instance.imageFrontSmallUrl,
      'quantity': instance.quantity,
      'nutriscore_grade': instance.nutriscoreGrade,
      'ecoscore_grade': instance.ecoscoreGrade,
      'nova_group': instance.novaGroup,
      'nutriments': instance.nutriments,
      'ingredients_tags': instance.ingredientsTags,
      'allergens_tags': instance.allergensTags,
      'additives_tags': instance.additivesTags,
      'categories_tags': instance.categoriesTags,
    };

OpenFoodFactsSearchResultDto _$OpenFoodFactsSearchResultDtoFromJson(
        Map<String, dynamic> json) =>
    OpenFoodFactsSearchResultDto(
      products: (json['products'] as List<dynamic>)
          .map((e) =>
              OpenFoodFactsProductDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      count: (json['count'] as num?)?.toInt(),
      page: (json['page'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OpenFoodFactsSearchResultDtoToJson(
        OpenFoodFactsSearchResultDto instance) =>
    <String, dynamic>{
      'products': instance.products,
      'count': instance.count,
      'page': instance.page,
    };
