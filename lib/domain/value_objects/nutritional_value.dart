import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'nutritional_value.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class NutritionalValues {
  final EnergyValue? energy;
  final NutrientValue? fat;
  @JsonKey(name: 'saturated_fat')
  final NutrientValue? saturatedFat;
  final NutrientValue? carbohydrates;
  final NutrientValue? sugars;
  final NutrientValue? fiber;
  final NutrientValue? proteins;
  final NutrientValue? salt;
  final NutrientValue? sodium;
  final NutrientValue? calcium;
  final NutrientValue? iron;
  @JsonKey(name: 'vitamin_c')
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

  factory NutritionalValues.fromJson(Map<String, dynamic> json) => 
      _$NutritionalValuesFromJson(json);

  Map<String, dynamic> toJson() => _$NutritionalValuesToJson(this);

  // Método para contexto IA (future release) asumimos unidad siempre en gramos
  // para mantener contexto reducido. De momento Openfood devuelve siempre gramno
  Map<String, dynamic> toAIContext() {
    return {
      'energy_kcal': energy?.valueKcal,
      'energy_kj': energy?.valueKj,
      'macronutrients': {
        if (carbohydrates != null)
          'carbohydrates_${carbohydrates!.unit}': carbohydrates!.value,
        if (proteins != null)
          'proteins_${proteins!.unit}': proteins!.value,
        if (fat != null)
          'fat_${fat!.unit}': fat!.value,
        if (saturatedFat != null)
          'saturated_fat_${saturatedFat!.unit}': saturatedFat!.value,
        if (sugars != null)
          'sugars_${sugars!.unit}': sugars!.value,
        if (fiber != null)
          'fiber_${fiber!.unit}': fiber!.value,
      },
      'minerals': {
        if (sodium != null)
          'sodium_${sodium!.unit}': sodium!.value,
        if (salt != null)
          'salt_${salt!.unit}': salt!.value,
        if (calcium != null)
          'calcium_${calcium!.unit}': calcium!.value,
        if (iron != null)
          'iron_${iron!.unit}': iron!.value,
      },
      'vitamins': {
        if (vitaminC != null)
          'vitamin_c_${vitaminC!.unit}': vitaminC!.value,
      },
    };
  }
}

@JsonSerializable()
@immutable
class EnergyValue {
  @JsonKey(name: 'value_kj')
  final double valueKj;

  @JsonKey(name: 'value_kcal')
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

  factory EnergyValue.fromJson(Map<String, dynamic> json) => 
      _$EnergyValueFromJson(json);

  Map<String, dynamic> toJson() => _$EnergyValueToJson(this);
}

@JsonSerializable()
@immutable
class NutrientValue {
  final double value;
  final String unit;


  const NutrientValue({
    required this.value,
    required this.unit,
  });

  factory NutrientValue.fromJson(Map<String, dynamic> json) => 
      _$NutrientValueFromJson(json);

  Map<String, dynamic> toJson() => _$NutrientValueToJson(this);
}
