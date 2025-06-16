import 'package:food_api/domain/value_objects/barcode.dart';
import 'package:food_api/domain/value_objects/nutritional_value.dart';
import 'package:meta/meta.dart';

@immutable
class ProductEntity {
  final Barcode? barcode;
  final String name;
  final String? brand;
  final String? quantity;
  final String? nutriscoreGrade;
  final String? ecoscoreGrade;
  final String? imageUrl;
  final int? novaGroup;
  final DateTime createdAt;
  final DateTime? updatedAt;

  final NutritionalValues? nutritionalValues;
  final List<String>? ingredients;    
  final List<String>? allergens;                
  final List<String>? additives;                  
  final List<String>? categories;

  const ProductEntity({
    required this.name, required this.createdAt, this.barcode,
    this.brand,
    this.quantity,
    this.nutriscoreGrade,
    this.ecoscoreGrade,
    this.imageUrl,
    this.novaGroup,
    this.updatedAt,
    this.nutritionalValues,
    this.ingredients,
    this.allergens,
    this.additives,
    this.categories,
  });

  // Métodos de dominio (lógica de negocio)
  bool hasNutritionalInfo() {
    return nutriscoreGrade != null || 
           novaGroup != null;
  }

  bool hasEcologicalInfo() {
    return ecoscoreGrade != null;
  }

  bool isHealthy() {

    final nutriScore = nutriscoreGrade?.toLowerCase();
    final nova = novaGroup;
    
    if (nutriScore == 'a' || nutriScore == 'b') return true;
    if (nutriScore == 'd' || nutriScore == 'e') return false;
    
    if (nova != null) {
      return nova <= 2;
    }
    
    return false;
  }

  bool isEcological() {

    final ecoScore = ecoscoreGrade?.toLowerCase();
    
    if (ecoScore == 'a' || ecoScore == 'b') return true;
    if (ecoScore == 'c' || ecoScore == 'd' || ecoScore == 'e') return false;
    
    return false;
  }

  NutritionalQuality get nutritionalQuality {
    if (!hasNutritionalInfo()) return NutritionalQuality.unknown;
    if (isHealthy()) return NutritionalQuality.good;
    return NutritionalQuality.poor;
  }

  EcologicalQuality get ecologicalQuality {
    if (!hasEcologicalInfo()) return EcologicalQuality.unknown;
    if (isEcological()) return EcologicalQuality.good;
    return EcologicalQuality.poor;
  }

  String get displayName {
    final baseName = name.isEmpty ? 'Producto sin nombre' : name;
    return brand != null ? '$baseName ($brand)' : baseName;
  }

  // Método para crear copia con cambios y así mantener la inmutabilidad
  ProductEntity copyWith({
    Barcode? barcode,
    String? name,
    String? brand,
    String? quantity,
    String? nutriscoreGrade,
    String? ecoscoreGrade,
    String? imageUrl,
    int? novaGroup,
    DateTime? createdAt,
    DateTime? updatedAt,
    NutritionalValues? nutritionalValues,
    List<String>? ingredients,
    List<String>? allergens,
    List<String>? additives,
    List<String>? categories,
  }) {
    return ProductEntity(
      barcode: barcode ?? this.barcode,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      quantity: quantity ?? this.quantity,
      nutriscoreGrade: nutriscoreGrade ?? this.nutriscoreGrade,
      ecoscoreGrade: ecoscoreGrade ?? this.ecoscoreGrade,
      imageUrl: imageUrl ?? this.imageUrl,
      novaGroup: novaGroup ?? this.novaGroup,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      nutritionalValues: nutritionalValues ?? this.nutritionalValues,
      ingredients: ingredients ?? this.ingredients,
      allergens: allergens ?? this.allergens,
      additives: additives ?? this.additives,
      categories: categories ?? this.categories,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductEntity &&
          runtimeType == other.runtimeType &&
          barcode == other.barcode &&
          name == other.name;

  @override
  int get hashCode => Object.hash(barcode, name);

  @override
  String toString() => 'ProductEntity(name: $name, brand: $brand, barcode: $barcode)';
}

enum NutritionalQuality {
  good,
  poor,
  unknown,
}

enum EcologicalQuality {
  good,
  poor,
  unknown,
}
