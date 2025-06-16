import 'dart:convert';
import 'package:food_api/domain/entities/product_entity.dart';
import 'package:food_api/domain/value_objects/barcode.dart';
import 'package:food_api/domain/value_objects/nutritional_value.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'product_model.g.dart';

@JsonSerializable()
@immutable
class ProductModel {
  @JsonKey(name: 'product_barcode')
  final String? productBarcode;

  @JsonKey(name: 'product_name')
  final String? productName;

  @JsonKey(name: 'product_brand')
  final String? productBrand;

  @JsonKey(name: 'product_quantity')
  final String? productQuantity;

  @JsonKey(name: 'product_nutriscore_grade')
  final String? productNutriscoreGrade;

  @JsonKey(name: 'product_ecoscore_grade')
  final String? productEcoscoreGrade;

  @JsonKey(name: 'product_image_url')
  final String? productImageUrl;

  @JsonKey(name: 'product_nova_group')
  final int? productNovaGroup;

  @JsonKey(name: 'product_created_at')
  final DateTime? productCreatedAt;

  @JsonKey(name: 'product_updated_at')
  final DateTime? productUpdatedAt;

  @JsonKey(name: 'product_nutritional_data')
  final String? productNutritionalData;

  @JsonKey(name: 'product_ingredients')
  final String? productIngredients;

  @JsonKey(name: 'product_allergens')
  final String? productAllergens;

  @JsonKey(name: 'product_additives')
  final String? productAdditives;

  @JsonKey(name: 'product_categories')
  final String? productCategories;

  const ProductModel({
    this.productBarcode,
    this.productName,
    this.productBrand,
    this.productQuantity,
    this.productNutriscoreGrade,
    this.productEcoscoreGrade,
    this.productImageUrl,
    this.productNovaGroup,
    this.productCreatedAt,
    this.productUpdatedAt,
    this.productNutritionalData,
    this.productIngredients,
    this.productAllergens,
    this.productAdditives,
    this.productCategories,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => 
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  factory ProductModel.fromDomain(ProductEntity entity) {
    return ProductModel(
      productBarcode: entity.barcode?.value,
      productName: entity.name,
      productBrand: entity.brand,
      productQuantity: entity.quantity,
      productNutriscoreGrade: entity.nutriscoreGrade,
      productEcoscoreGrade: entity.ecoscoreGrade,
      productImageUrl: entity.imageUrl,
      productNovaGroup: entity.novaGroup,
      productCreatedAt: entity.createdAt,
      productUpdatedAt: entity.updatedAt,
      productNutritionalData: entity.nutritionalValues != null 
          ? json.encode(entity.nutritionalValues!.toStorageJson()) 
          : null,
      productIngredients: entity.ingredients != null 
          ? json.encode(entity.ingredients) 
          : null,
      productAllergens: entity.allergens != null 
          ? json.encode(entity.allergens) 
          : null,
      productAdditives: entity.additives != null 
          ? json.encode(entity.additives) 
          : null,
      productCategories: entity.categories != null 
          ? json.encode(entity.categories) 
          : null,
    );
  }

  ProductEntity toDomain() {
    return ProductEntity(
      barcode: productBarcode != null ? Barcode(productBarcode!) : null,
      name: productName ?? 'Producto sin nombre',
      brand: productBrand,
      quantity: productQuantity,
      nutriscoreGrade: productNutriscoreGrade,
      ecoscoreGrade: productEcoscoreGrade,
      imageUrl: productImageUrl,
      novaGroup: productNovaGroup,
      createdAt: productCreatedAt ?? DateTime.now(),
      updatedAt: productUpdatedAt,
      nutritionalValues: _deserializeNutritionalValues(),
      ingredients: _deserializeStringList(productIngredients),
      allergens: _deserializeStringList(productAllergens),
      additives: _deserializeStringList(productAdditives),
      categories: _deserializeStringList(productCategories),
    );
  }


  NutritionalValues? _deserializeNutritionalValues() {
    if (productNutritionalData?.isNotEmpty != true) return null;
    
    try {
      final data = json.decode(productNutritionalData!) as Map<String, dynamic>;
      return NutritionalValues.fromStorageJson(data);
    } catch (e) {
      return null;
    }
  }

  List<String>? _deserializeStringList(String? jsonString) {
  if (jsonString?.isNotEmpty != true) return null;
  
  try {
    final decoded = json.decode(jsonString!);
  
    if (decoded is List) {
      return decoded
          .where((item) => item != null)
          .map((item) => item.toString())
          .toList();
    }
    
    return null;
  } catch (e) {
    return null;
  }
}

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModel &&
          runtimeType == other.runtimeType &&
          productBarcode == other.productBarcode &&
          productName == other.productName;

  @override
  int get hashCode => Object.hash(productBarcode, productName);

  @override
  String toString() => 
      'ProductModel(barcode: $productBarcode, name: $productName, brand: $productBrand)';
}
