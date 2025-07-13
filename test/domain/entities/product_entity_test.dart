import 'package:food_api/domain/entities/product_entity.dart';
import 'package:food_api/domain/value_objects/barcode.dart';
import 'package:test/test.dart';

void main() {
  group('ProductEntity', () {
    late DateTime testCreatedAt;
    late DateTime testUpdatedAt;

    setUp(() {
      testCreatedAt = DateTime(2024, 1, 15);
      testUpdatedAt = DateTime(2024, 1, 20);
    });

    ProductEntity createTestProduct({
      Barcode? barcode,
      String name = 'Test Product',
      String? brand,
      String? nutriscoreGrade,
      String? ecoscoreGrade,
      int? novaGroup,
      DateTime? createdAt,
    }) {
      return ProductEntity(
        barcode: barcode,
        name: name,
        brand: brand,
        nutriscoreGrade: nutriscoreGrade,
        ecoscoreGrade: ecoscoreGrade,
        novaGroup: novaGroup,
        createdAt: createdAt ?? testCreatedAt,
      );
    }

    group('Constructor', () {
      test('should create ProductEntity with required fields only', () {
        final product = ProductEntity(
          name: 'Test Product',
          createdAt: testCreatedAt,
        );

        expect(product.name, equals('Test Product'));
        expect(product.createdAt, equals(testCreatedAt));
        expect(product.barcode, isNull);
        expect(product.brand, isNull);
        expect(product.nutriscoreGrade, isNull);
      });

      test('should create ProductEntity with all fields', () {
        final barcode = Barcode('12345678');
        final product = ProductEntity(
          barcode: barcode,
          name: 'Complete Product',
          brand: 'Test Brand',
          quantity: '100g',
          nutriscoreGrade: 'A',
          ecoscoreGrade: 'B',
          imageUrl: 'https://example.com/image.jpg',
          novaGroup: 1,
          createdAt: testCreatedAt,
          updatedAt: testUpdatedAt,
          ingredients: const ['Water', 'Sugar'],
          allergens: const ['Gluten'],
          additives: const ['E100'],
          categories: const ['Beverages'],
        );

        expect(product.barcode, equals(barcode));
        expect(product.name, equals('Complete Product'));
        expect(product.brand, equals('Test Brand'));
        expect(product.quantity, equals('100g'));
        expect(product.nutriscoreGrade, equals('A'));
        expect(product.ecoscoreGrade, equals('B'));
        expect(product.novaGroup, equals(1));
        expect(product.ingredients, equals(['Water', 'Sugar']));
        expect(product.allergens, equals(['Gluten']));
      });
    });

    group('hasNutritionalInfo', () {
      test('should return true when nutriscoreGrade is present', () {
        final product = createTestProduct(nutriscoreGrade: 'A');

        expect(product.hasNutritionalInfo(), isTrue);
      });

      test('should return true when novaGroup is present', () {
        final product = createTestProduct(novaGroup: 1);

        expect(product.hasNutritionalInfo(), isTrue);
      });

      test('should return true when both nutriscoreGrade and novaGroup are present', () {
        final product = createTestProduct(
          nutriscoreGrade: 'A',
          novaGroup: 1,
        );

        expect(product.hasNutritionalInfo(), isTrue);
      });

      test('should return false when neither nutriscoreGrade nor novaGroup are present', () {
        final product = createTestProduct();

        expect(product.hasNutritionalInfo(), isFalse);
      });
    });

    group('hasEcologicalInfo', () {
      test('should return true when ecoscoreGrade is present', () {
        final product = createTestProduct(ecoscoreGrade: 'A');

        expect(product.hasEcologicalInfo(), isTrue);
      });

      test('should return false when ecoscoreGrade is null', () {
        final product = createTestProduct();

        expect(product.hasEcologicalInfo(), isFalse);
      });
    });

    group('isHealthy', () {
      test('should return true for nutriscore A', () {
        final product = createTestProduct(nutriscoreGrade: 'A');

        expect(product.isHealthy(), isTrue);
      });

      test('should return true for nutriscore B', () {
        final product = createTestProduct(nutriscoreGrade: 'B');

        expect(product.isHealthy(), isTrue);
      });

      test('should return true for nutriscore a (lowercase)', () {
        final product = createTestProduct(nutriscoreGrade: 'a');

        expect(product.isHealthy(), isTrue);
      });

      test('should return false for nutriscore C', () {
        final product = createTestProduct(nutriscoreGrade: 'C');

        expect(product.isHealthy(), isFalse);
      });

      test('should return false for nutriscore D', () {
        final product = createTestProduct(nutriscoreGrade: 'D');

        expect(product.isHealthy(), isFalse);
      });

      test('should return false for nutriscore E', () {
        final product = createTestProduct(nutriscoreGrade: 'E');

        expect(product.isHealthy(), isFalse);
      });

      test('should return true for nova group 1', () {
        final product = createTestProduct(novaGroup: 1);

        expect(product.isHealthy(), isTrue);
      });

      test('should return true for nova group 2', () {
        final product = createTestProduct(novaGroup: 2);

        expect(product.isHealthy(), isTrue);
      });

      test('should return false for nova group 3', () {
        final product = createTestProduct(novaGroup: 3);

        expect(product.isHealthy(), isFalse);
      });

      test('should return false for nova group 4', () {
        final product = createTestProduct(novaGroup: 4);

        expect(product.isHealthy(), isFalse);
      });

      test('should prioritize nutriscore over nova group when both present', () {
        final product = createTestProduct(
          nutriscoreGrade: 'D',
          novaGroup: 1,
        );

        expect(product.isHealthy(), isFalse);
      });

      test('should return false when no nutritional info available', () {
        final product = createTestProduct();

        expect(product.isHealthy(), isFalse);
      });
    });

    group('isEcological', () {
      test('should return true for ecoscore A', () {
        final product = createTestProduct(ecoscoreGrade: 'A');

        expect(product.isEcological(), isTrue);
      });

      test('should return true for ecoscore B', () {
        final product = createTestProduct(ecoscoreGrade: 'B');

        expect(product.isEcological(), isTrue);
      });

      test('should return true for ecoscore a (lowercase)', () {
        final product = createTestProduct(ecoscoreGrade: 'a');

        expect(product.isEcological(), isTrue);
      });

      test('should return false for ecoscore C', () {
        final product = createTestProduct(ecoscoreGrade: 'C');

        expect(product.isEcological(), isFalse);
      });

      test('should return false for ecoscore D', () {
        final product = createTestProduct(ecoscoreGrade: 'D');

        expect(product.isEcological(), isFalse);
      });

      test('should return false for ecoscore E', () {
        final product = createTestProduct(ecoscoreGrade: 'E');

        expect(product.isEcological(), isFalse);
      });

      test('should return false when ecoscore is null', () {
        final product = createTestProduct();

        expect(product.isEcological(), isFalse);
      });
    });

    group('nutritionalQuality getter', () {
      test('should return unknown when no nutritional info available', () {
        final product = createTestProduct();

        expect(product.nutritionalQuality, equals(NutritionalQuality.unknown));
      });

      test('should return good when product is healthy', () {
        final product = createTestProduct(nutriscoreGrade: 'A');

        expect(product.nutritionalQuality, equals(NutritionalQuality.good));
      });

      test('should return poor when product is not healthy but has nutritional info', () {
        final product = createTestProduct(nutriscoreGrade: 'D');

        expect(product.nutritionalQuality, equals(NutritionalQuality.poor));
      });

      test('should return good when only nova group indicates healthy', () {
        final product = createTestProduct(novaGroup: 1);

        expect(product.nutritionalQuality, equals(NutritionalQuality.good));
      });
    });

    group('ecologicalQuality getter', () {
      test('should return unknown when no ecological info available', () {
        final product = createTestProduct();

        expect(product.ecologicalQuality, equals(EcologicalQuality.unknown));
      });

      test('should return good when product is ecological', () {
        final product = createTestProduct(ecoscoreGrade: 'A');

        expect(product.ecologicalQuality, equals(EcologicalQuality.good));
      });

      test('should return poor when product is not ecological', () {
        final product = createTestProduct(ecoscoreGrade: 'D');

        expect(product.ecologicalQuality, equals(EcologicalQuality.poor));
      });
    });

    group('displayName getter', () {
      test('should return name when brand is null', () {
        final product = createTestProduct(name: 'Simple Product');

        expect(product.displayName, equals('Simple Product'));
      });

      test('should return name with brand in parentheses when brand is present', () {
        final product = createTestProduct(
          name: 'Product Name',
          brand: 'Brand Name',
        );

        expect(product.displayName, equals('Product Name (Brand Name)'));
      });

      test('should return default message when name is empty', () {
        final product = createTestProduct(name: '');

        expect(product.displayName, equals('Producto sin nombre'));
      });

      test('should return default message with brand when name is empty but brand is present', () {
        final product = createTestProduct(
          name: '',
          brand: 'Brand Name',
        );

        expect(product.displayName, equals('Producto sin nombre (Brand Name)'));
      });
    });

    group('copyWith', () {
      test('should create copy with updated name', () {
        final original = createTestProduct(name: 'Original Name');
        
        final updated = original.copyWith(name: 'Updated Name');

        expect(updated.name, equals('Updated Name'));
        expect(updated.createdAt, equals(original.createdAt));
        expect(updated.barcode, equals(original.barcode));
      });

      test('should create copy with updated nutriscore', () {
        final original = createTestProduct(nutriscoreGrade: 'A');
        
        final updated = original.copyWith(nutriscoreGrade: 'B');

        expect(updated.nutriscoreGrade, equals('B'));
        expect(updated.name, equals(original.name));
      });

      test('should create copy with multiple updated fields', () {
        final original = createTestProduct();
        final newBarcode = Barcode('87654321');
        
        final updated = original.copyWith(
          barcode: newBarcode,
          name: 'New Name',
          brand: 'New Brand',
          nutriscoreGrade: 'C',
        );

        expect(updated.barcode, equals(newBarcode));
        expect(updated.name, equals('New Name'));
        expect(updated.brand, equals('New Brand'));
        expect(updated.nutriscoreGrade, equals('C'));
        expect(updated.createdAt, equals(original.createdAt));
      });

      test('should preserve original values when no updates provided', () {
        final barcode = Barcode('12345678');
        final original = createTestProduct(
          barcode: barcode,
          name: 'Original',
          brand: 'Original Brand',
        );
        
        final copy = original.copyWith();

        expect(copy.barcode, equals(original.barcode));
        expect(copy.name, equals(original.name));
        expect(copy.brand, equals(original.brand));
        expect(copy.createdAt, equals(original.createdAt));
      });
    });

    group('equality and hashCode', () {
      test('should be equal when barcode and name are the same', () {
        final barcode = Barcode('12345678');
        final product1 = createTestProduct(
          barcode: barcode,
        );
        final product2 = createTestProduct(
          barcode: barcode,
        );

        expect(product1, equals(product2));
        expect(product1.hashCode, equals(product2.hashCode));
      });

      test('should not be equal when barcodes are different', () {
        final product1 = createTestProduct(barcode: Barcode('12345678'));
        final product2 = createTestProduct(barcode: Barcode('87654321'));

        expect(product1, isNot(equals(product2)));
      });

      test('should not be equal when names are different', () {
        final barcode = Barcode('12345678');
        final product1 = createTestProduct(
          barcode: barcode,
          name: 'Product 1',
        );
        final product2 = createTestProduct(
          barcode: barcode,
          name: 'Product 2',
        );

        expect(product1, isNot(equals(product2)));
      });

      test('should be equal when both have null barcode but same name', () {
        final product1 = createTestProduct();
        final product2 = createTestProduct();

        expect(product1, equals(product2));
        expect(product1.hashCode, equals(product2.hashCode));
      });
    });

    group('toString', () {
      test('should return formatted string with name, brand and barcode', () {
        final barcode = Barcode('12345678');
        final product = createTestProduct(
          barcode: barcode,
          brand: 'Test Brand',
        );

        final result = product.toString();

        expect(result, equals('ProductEntity(name: Test Product, brand: Test Brand, barcode: 12345678)'));
      });

      test('should handle null brand in string representation', () {
        final barcode = Barcode('12345678');
        final product = createTestProduct(
          barcode: barcode,
        );

        final result = product.toString();

        expect(result, equals('ProductEntity(name: Test Product, brand: null, barcode: 12345678)'));
      });

      test('should handle null barcode in string representation', () {
        final product = createTestProduct(
          brand: 'Test Brand',
        );

        final result = product.toString();

        expect(result, equals('ProductEntity(name: Test Product, brand: Test Brand, barcode: null)'));
      });
    });
  });
}
