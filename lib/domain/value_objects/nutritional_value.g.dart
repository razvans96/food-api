// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutritional_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NutritionalValues _$NutritionalValuesFromJson(Map<String, dynamic> json) =>
    NutritionalValues(
      energy: json['energy'] == null
          ? null
          : EnergyValue.fromJson(json['energy'] as Map<String, dynamic>),
      fat: json['fat'] == null
          ? null
          : NutrientValue.fromJson(json['fat'] as Map<String, dynamic>),
      saturatedFat: json['saturated_fat'] == null
          ? null
          : NutrientValue.fromJson(
              json['saturated_fat'] as Map<String, dynamic>),
      carbohydrates: json['carbohydrates'] == null
          ? null
          : NutrientValue.fromJson(
              json['carbohydrates'] as Map<String, dynamic>),
      sugars: json['sugars'] == null
          ? null
          : NutrientValue.fromJson(json['sugars'] as Map<String, dynamic>),
      fiber: json['fiber'] == null
          ? null
          : NutrientValue.fromJson(json['fiber'] as Map<String, dynamic>),
      proteins: json['proteins'] == null
          ? null
          : NutrientValue.fromJson(json['proteins'] as Map<String, dynamic>),
      salt: json['salt'] == null
          ? null
          : NutrientValue.fromJson(json['salt'] as Map<String, dynamic>),
      sodium: json['sodium'] == null
          ? null
          : NutrientValue.fromJson(json['sodium'] as Map<String, dynamic>),
      calcium: json['calcium'] == null
          ? null
          : NutrientValue.fromJson(json['calcium'] as Map<String, dynamic>),
      iron: json['iron'] == null
          ? null
          : NutrientValue.fromJson(json['iron'] as Map<String, dynamic>),
      vitaminC: json['vitamin_c'] == null
          ? null
          : NutrientValue.fromJson(json['vitamin_c'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NutritionalValuesToJson(NutritionalValues instance) =>
    <String, dynamic>{
      'energy': instance.energy?.toJson(),
      'fat': instance.fat?.toJson(),
      'saturated_fat': instance.saturatedFat?.toJson(),
      'carbohydrates': instance.carbohydrates?.toJson(),
      'sugars': instance.sugars?.toJson(),
      'fiber': instance.fiber?.toJson(),
      'proteins': instance.proteins?.toJson(),
      'salt': instance.salt?.toJson(),
      'sodium': instance.sodium?.toJson(),
      'calcium': instance.calcium?.toJson(),
      'iron': instance.iron?.toJson(),
      'vitamin_c': instance.vitaminC?.toJson(),
    };

EnergyValue _$EnergyValueFromJson(Map<String, dynamic> json) => EnergyValue(
      valueKj: (json['value_kj'] as num).toDouble(),
      valueKcal: (json['value_kcal'] as num).toDouble(),
    );

Map<String, dynamic> _$EnergyValueToJson(EnergyValue instance) =>
    <String, dynamic>{
      'value_kj': instance.valueKj,
      'value_kcal': instance.valueKcal,
    };

NutrientValue _$NutrientValueFromJson(Map<String, dynamic> json) =>
    NutrientValue(
      value: (json['value'] as num).toDouble(),
      unit: json['unit'] as String,
    );

Map<String, dynamic> _$NutrientValueToJson(NutrientValue instance) =>
    <String, dynamic>{
      'value': instance.value,
      'unit': instance.unit,
    };
