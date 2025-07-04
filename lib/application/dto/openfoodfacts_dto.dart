import 'package:food_api/domain/entities/product_entity.dart';
import 'package:food_api/domain/value_objects/barcode.dart';
import 'package:food_api/domain/value_objects/nutritional_value.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

part 'openfoodfacts_dto.g.dart';

@JsonSerializable()
class OpenFoodFactsProductDto {

  @JsonKey(name: 'code')
  final String? barcode;

  @JsonKey(name: 'product_name')
  final String? productName;

  @JsonKey(name: 'brands')
  final String? brands;

  @JsonKey(name: 'image_front_small_url')
  final String? imageFrontSmallUrl;

  @JsonKey(name: 'quantity')
  final String? quantity;

  @JsonKey(name: 'nutriscore_grade')
  final String? nutriscoreGrade;

  @JsonKey(name: 'ecoscore_grade')
  final String? ecoscoreGrade;

  @JsonKey(name: 'nova_group')
  final int? novaGroup;

  @JsonKey(name: 'nutriments')
  final Map<String, dynamic>? nutriments;

  @JsonKey(name: 'ingredients_tags')
  final List<String>? ingredientsTags;

  @JsonKey(name: 'allergens_tags')
  final List<String>? allergensTags;

  @JsonKey(name: 'additives_tags')
  final List<String>? additivesTags;

  @JsonKey(name: 'categories_tags')
  final List<String>? categoriesTags;

  const OpenFoodFactsProductDto({
    this.productName,
    this.brands,
    this.quantity,
    this.nutriscoreGrade,
    this.ecoscoreGrade,
    this.imageFrontSmallUrl,
    this.novaGroup,
    this.barcode,
    this.nutriments,
    this.ingredientsTags,
    this.allergensTags,
    this.additivesTags,
    this.categoriesTags,
  });

  // Conversión desde el SDK de OpenFoodFacts
  factory OpenFoodFactsProductDto.fromOpenFoodFactsSDK(Product openFoodProduct) {
    return OpenFoodFactsProductDto(
      barcode: openFoodProduct.barcode,
      productName: openFoodProduct.productName,
      brands: openFoodProduct.brands,
      imageFrontSmallUrl: openFoodProduct.imageFrontSmallUrl,
      quantity: openFoodProduct.quantity,
      nutriscoreGrade: openFoodProduct.nutriscore,
      ecoscoreGrade: openFoodProduct.ecoscoreGrade,
      novaGroup: openFoodProduct.novaGroup,
      nutriments: openFoodProduct.nutriments?.toJson(),
      ingredientsTags: openFoodProduct.ingredientsTagsInLanguages?.values.first,
      allergensTags: openFoodProduct.allergensTagsInLanguages?.values.first,
      additivesTags: openFoodProduct.additivesTagsInLanguages?.values.first,
      categoriesTags: openFoodProduct.categoriesTagsInLanguages?.values.first,
    );
  }

  factory OpenFoodFactsProductDto.fromJson(Map<String, dynamic> json) =>
      _$OpenFoodFactsProductDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OpenFoodFactsProductDtoToJson(this);

  ProductEntity toDomain() {
    return ProductEntity(
      name: productName ?? 'Producto sin nombre',
      barcode: barcode != null ? Barcode(barcode!) : null,
      brand: brands,
      quantity: quantity,
      nutriscoreGrade: _sanitizeScore(nutriscoreGrade),
      ecoscoreGrade: _sanitizeScore(ecoscoreGrade),
      imageUrl: imageFrontSmallUrl,
      novaGroup: novaGroup,
      createdAt: DateTime.now(),
      nutritionalValues: _createNutritionalValues(),
      ingredients: ingredientsTags,
      allergens: allergensTags,
      additives: additivesTags,
      categories: categoriesTags,
    );
  }

  NutritionalValues? _createNutritionalValues() {
    if (nutriments == null || nutriments!.isEmpty) return null;
    
    return NutritionalValues(
      energy: _extractEnergy(),
      fat: _extractNutrient('fat'),
      saturatedFat: _extractNutrient('saturated-fat'),
      carbohydrates: _extractNutrient('carbohydrates'),
      sugars: _extractNutrient('sugars'),
      fiber: _extractNutrient('fiber'),
      proteins: _extractNutrient('proteins'),
      salt: _extractNutrient('salt'),
      sodium: _extractNutrient('sodium'),
      calcium: _extractNutrient('calcium'),
      iron: _extractNutrient('iron'),
      vitaminC: _extractNutrient('vitamin-c'),
    );
  }

  // Helpers
  EnergyValue? _extractEnergy() {
    final energyKj = nutriments?['energy-kj_100g'];
    if (energyKj != null && energyKj is num) {
      return EnergyValue.fromKj(energyKj.toDouble());
    }
    
    final energyKcal = nutriments?['energy-kcal_100g'];
    if (energyKcal != null && energyKcal is num) {
      return EnergyValue.fromKcal(energyKcal.toDouble());
    }
    
    return null;
  }

  NutrientValue? _extractNutrient(String nutrientName) {
    // La consulta a Openfood siempre da valores por 100g en gramos
    final value = nutriments?['${nutrientName}_100g'];
    const unit = 'g';


    if (value != null && value is num) {
      return NutrientValue(
        value: value.toDouble(),
        unit: unit,
      );
    }
    
    return null;
  }

  String? _sanitizeScore(String? score) {
    if (score == null || score.isEmpty) return null;
    
    final cleanScore = score.toLowerCase().trim();
    
    if (['a', 'b', 'c', 'd', 'e'].contains(cleanScore)) {
      return cleanScore;
    }
    
    return null;
  }

  @override
  String toString() =>
      'OpenFoodFactsProductDto(name: $productName, barcode: $barcode)';
}

@JsonSerializable()
class OpenFoodFactsSearchResultDto {
  @JsonKey(name: 'products')
  final List<OpenFoodFactsProductDto> products;

  @JsonKey(name: 'count')
  final int? count;

  @JsonKey(name: 'page')
  final int? page;

  const OpenFoodFactsSearchResultDto({
    required this.products,
    this.count,
    this.page,
  });

  factory OpenFoodFactsSearchResultDto.fromJson(Map<String, dynamic> json) =>
      _$OpenFoodFactsSearchResultDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OpenFoodFactsSearchResultDtoToJson(this);
}
