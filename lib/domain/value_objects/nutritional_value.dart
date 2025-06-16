import 'package:meta/meta.dart';

@immutable
class NutritionalValues {
  final EnergyValue? energy;
  final NutrientValue? fat;
  final NutrientValue? saturatedFat;
  final NutrientValue? carbohydrates;
  final NutrientValue? sugars;
  final NutrientValue? fiber;
  final NutrientValue? proteins;
  final NutrientValue? salt;
  final NutrientValue? sodium;
  final NutrientValue? calcium;
  final NutrientValue? iron;
  final NutrientValue? vitaminC;

  const NutritionalValues({
    this.energy,
    this.fat,
    this.saturatedFat,
    this.carbohydrates,
    this.sugars,
    this.fiber,
    this.proteins,
    this.salt,
    this.sodium,
    this.calcium,
    this.iron,
    this.vitaminC,
  });

    Map<String, dynamic> toStorageJson() {
    return {
      'energy': energy != null ? {
        'value_kj': energy!.valueKj,
        'value_kcal': energy!.valueKcal,
      } : null,
      'fat': fat != null ? {
        'value': fat!.value,
        'unit': fat!.unit,
        'per_100g': fat!.per100g,
        'per_serving': fat!.perServing,
      } : null,
      'saturated_fat': saturatedFat != null ? {
        'value': saturatedFat!.value,
        'unit': saturatedFat!.unit,
        'per_100g': saturatedFat!.per100g,
        'per_serving': saturatedFat!.perServing,
      } : null,
      'carbohydrates': carbohydrates != null ? {
        'value': carbohydrates!.value,
        'unit': carbohydrates!.unit,
        'per_100g': carbohydrates!.per100g,
        'per_serving': carbohydrates!.perServing,
      } : null,
      'sugars': sugars != null ? {
        'value': sugars!.value,
        'unit': sugars!.unit,
        'per_100g': sugars!.per100g,
        'per_serving': sugars!.perServing,
      } : null,
      'fiber': fiber != null ? {
        'value': fiber!.value,
        'unit': fiber!.unit,
        'per_100g': fiber!.per100g,
        'per_serving': fiber!.perServing,
      } : null,
      'proteins': proteins != null ? {
        'value': proteins!.value,
        'unit': proteins!.unit,
        'per_100g': proteins!.per100g,
        'per_serving': proteins!.perServing,
      } : null,
      'salt': salt != null ? {
        'value': salt!.value,
        'unit': salt!.unit,
        'per_100g': salt!.per100g,
        'per_serving': salt!.perServing,
      } : null,
      'sodium': sodium != null ? {
        'value': sodium!.value,
        'unit': sodium!.unit,
        'per_100g': sodium!.per100g,
        'per_serving': sodium!.perServing,
      } : null,
      'calcium': calcium != null ? {
        'value': calcium!.value,
        'unit': calcium!.unit,
        'per_100g': calcium!.per100g,
        'per_serving': calcium!.perServing,
      } : null,
      'iron': iron != null ? {
        'value': iron!.value,
        'unit': iron!.unit,
        'per_100g': iron!.per100g,
        'per_serving': iron!.perServing,
      } : null,
      'vitamin_c': vitaminC != null ? {
        'value': vitaminC!.value,
        'unit': vitaminC!.unit,
        'per_100g': vitaminC!.per100g,
        'per_serving': vitaminC!.perServing,
      } : null,
    };
  }

  factory NutritionalValues.fromStorageJson(Map<String, dynamic> json) {
  return NutritionalValues(
    energy: _extractEnergy(json['energy']),
    fat: _extractNutrient(json['fat']),
    saturatedFat: _extractNutrient(json['saturated_fat']),
    carbohydrates: _extractNutrient(json['carbohydrates']),
    sugars: _extractNutrient(json['sugars']),
    fiber: _extractNutrient(json['fiber']),
    proteins: _extractNutrient(json['proteins']),
    salt: _extractNutrient(json['salt']),
    sodium: _extractNutrient(json['sodium']),
    calcium: _extractNutrient(json['calcium']),
    iron: _extractNutrient(json['iron']),
    vitaminC: _extractNutrient(json['vitamin_c']),
  );
}

static EnergyValue? _extractEnergy(dynamic energyData) {
  if (energyData == null) return null;
  
  try {
    final data = energyData as Map<String, dynamic>;
    return EnergyValue(
      valueKj: _safeDouble(data['value_kj']) ?? 0.0,
      valueKcal: _safeDouble(data['value_kcal']) ?? 0.0,
    );
  } catch (e) {
    return null;
  }
}

static NutrientValue? _extractNutrient(dynamic nutrientData) {
  if (nutrientData == null) return null;
  
  try {
    final data = nutrientData as Map<String, dynamic>;
    return NutrientValue(
      value: _safeDouble(data['value']) ?? 0.0,
      unit: data['unit']?.toString() ?? 'g',
      per100g: _safeDouble(data['per_100g']),
      perServing: _safeDouble(data['per_serving']),
    );
  } catch (e) {
    return null;
  }
}

static double? _safeDouble(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}


  // Método para contexto IA (future release)
  Map<String, dynamic> toAIContext() {
    return {
      'energy_kcal': energy?.valueKcal,
      'energy_kj': energy?.valueKj,
      'macronutrients': {
        'carbohydrates_g': carbohydrates?.per100g,
        'proteins_g': proteins?.per100g,
        'fat_g': fat?.per100g,
        'saturated_fat_g': saturatedFat?.per100g,
        'sugars_g': sugars?.per100g,
        'fiber_g': fiber?.per100g,
      },
      'minerals': {
        'sodium_mg': sodium?.per100g,
        'salt_g': salt?.per100g,
        'calcium_mg': calcium?.per100g,
        'iron_mg': iron?.per100g,
      },
      'vitamins': {
        'vitamin_c_mg': vitaminC?.per100g,
      },
    };
  }
}

@immutable
class EnergyValue {
  final double valueKj;
  final double valueKcal;

  const EnergyValue({required this.valueKj, required this.valueKcal});

  factory EnergyValue.fromKj(double kj) {
    return EnergyValue(
      valueKj: kj,
      valueKcal: kj * 0.23900573614,
    );
  }

  factory EnergyValue.fromKcal(double kcal) {
    return EnergyValue(
      valueKj: kcal / 0.23900573614,
      valueKcal: kcal,
    );
  }
}

@immutable
class NutrientValue {
  final double value;
  final String unit;
  final double? per100g;
  final double? perServing;

  const NutrientValue({
    required this.value,
    required this.unit,
    this.per100g,
    this.perServing,
  });
}
