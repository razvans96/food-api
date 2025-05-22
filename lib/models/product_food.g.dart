// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_food.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductFood _$ProductFoodFromJson(Map<String, dynamic> json) => ProductFood(
      name: json['name'] as String?,
      brand: json['brand'] as String?,
      quantity: json['quantity'] as String?,
      nutriscoreGrade: json['nutriscoreGrade'] as String?,
      ecoscoreGrade: json['ecoscoreGrade'] as String?,
      imageUrl: json['imageUrl'] as String?,
      novaGroup: (json['novaGroup'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductFoodToJson(ProductFood instance) =>
    <String, dynamic>{
      'name': instance.name,
      'brand': instance.brand,
      'quantity': instance.quantity,
      'nutriscoreGrade': instance.nutriscoreGrade,
      'ecoscoreGrade': instance.ecoscoreGrade,
      'imageUrl': instance.imageUrl,
      'novaGroup': instance.novaGroup,
    };
