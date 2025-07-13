import 'package:food_api/domain/entities/product_entity.dart';
import 'package:food_api/domain/failures/domain_failures.dart';
import 'package:food_api/domain/repositories/product_repository.dart';
import 'package:food_api/domain/use_cases/get_product_by_barcode_use_case.dart';
import 'package:food_api/domain/value_objects/barcode.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockProductRepository extends Mock implements ProductRepository {}

class FakeBarcode extends Fake implements Barcode {}

void main() {
  group('GetProductByBarcodeUseCase', () {
    late MockProductRepository mockRepository;
    late GetProductByBarcodeUseCase useCase;

    setUpAll(() {
      registerFallbackValue(FakeBarcode());
    });

    setUp(() {
      mockRepository = MockProductRepository();
      useCase = GetProductByBarcodeUseCase(mockRepository);
      reset(mockRepository);
    });

    ProductEntity createTestProduct({
      String barcodeValue = '12345678',
      String name = 'Test Product',
    }) {
      return ProductEntity(
        barcode: Barcode(barcodeValue),
        name: name,
        createdAt: DateTime(2024, 1, 15),
      );
    }

    group('execute', () {
      test('should return ProductEntity when repository finds product', () async {
        const barcodeValue = '12345678';
        final expectedBarcode = Barcode(barcodeValue);
        final expectedProduct = createTestProduct(barcodeValue: barcodeValue);

        when(() => mockRepository.getProductByBarcode(expectedBarcode))
            .thenAnswer((_) async => expectedProduct);

        final result = await useCase.execute(barcodeValue);

        expect(result, equals(expectedProduct));
        verify(() => mockRepository.getProductByBarcode(expectedBarcode)).called(1);
      });

      test('should return null when repository does not find product', () async {
        const barcodeValue = '12345678';
        final expectedBarcode = Barcode(barcodeValue);

        when(() => mockRepository.getProductByBarcode(expectedBarcode))
            .thenAnswer((_) async => null);

        final result = await useCase.execute(barcodeValue);

        expect(result, isNull);
        verify(() => mockRepository.getProductByBarcode(expectedBarcode)).called(1);
      });

      test('should pass correct Barcode value object to repository', () async {
        const barcodeValue = '87654321';
        final expectedBarcode = Barcode(barcodeValue);

        when(() => mockRepository.getProductByBarcode(expectedBarcode))
            .thenAnswer((_) async => null);

        await useCase.execute(barcodeValue);

        verify(() => mockRepository.getProductByBarcode(expectedBarcode)).called(1);
      });

      test('should handle barcode with whitespace by trimming', () async {
        const barcodeWithSpaces = '  12345678  ';
        const cleanBarcodeValue = '12345678';
        final expectedBarcode = Barcode(cleanBarcodeValue);
        final expectedProduct = createTestProduct(barcodeValue: cleanBarcodeValue);

        when(() => mockRepository.getProductByBarcode(expectedBarcode))
            .thenAnswer((_) async => expectedProduct);

        final result = await useCase.execute(barcodeWithSpaces);

        expect(result, equals(expectedProduct));
        verify(() => mockRepository.getProductByBarcode(expectedBarcode)).called(1);
      });

      test('should throw InvalidBarcodeFailure when barcode is empty', () {
        const emptyBarcode = '';

        expect(
          () => useCase.execute(emptyBarcode),
          throwsA(
            isA<InvalidBarcodeFailure>()
                .having(
                  (e) => e.message,
                  'message',
                  'Código de barras no puede estar vacío',
                ),
          ),
        );
      });

      test('should throw InvalidBarcodeFailure when barcode is too short', () async {
        const shortBarcode = '1234567';

        expect(
          () => useCase.execute(shortBarcode),
          throwsA(
            isA<InvalidBarcodeFailure>()
                .having(
                  (e) => e.message,
                  'message',
                  'Código de barras debe contener entre 8 y 14 dígitos',
                ),
          ),
        );

        verifyNever(() => mockRepository.getProductByBarcode(any()));
      });

      test('should throw InvalidBarcodeFailure when barcode is too long', () async {
        const longBarcode = '123456789012345';

        expect(
          () => useCase.execute(longBarcode),
          throwsA(
            isA<InvalidBarcodeFailure>()
                .having(
                  (e) => e.message,
                  'message',
                  'Código de barras debe contener entre 8 y 14 dígitos',
                ),
          ),
        );

        verifyNever(() => mockRepository.getProductByBarcode(any()));
      });

      test('should throw InvalidBarcodeFailure when barcode contains non-numeric characters', () {
        const invalidBarcode = '1234567A';

        expect(
          () => useCase.execute(invalidBarcode),
          throwsA(
            isA<InvalidBarcodeFailure>()
                .having(
                  (e) => e.message,
                  'message',
                  'Código de barras debe contener entre 8 y 14 dígitos',
                ),
          ),
        );
      });

      test('should propagate repository exceptions', () async {
        const barcodeValue = '12345678';
        final expectedBarcode = Barcode(barcodeValue);
        final repositoryException = Exception('Database connection failed');

        when(() => mockRepository.getProductByBarcode(expectedBarcode))
            .thenThrow(repositoryException);

        await expectLater(
          () => useCase.execute(barcodeValue),
          throwsA(equals(repositoryException)),
        );

        verify(() => mockRepository.getProductByBarcode(expectedBarcode)).called(1);
      });

      test('should work with different valid barcode formats', () async {
        final testCases = [
          '12345678',        
          '123456789',       
          '1234567890',      
          '12345678901',     
          '123456789012',    
          '1234567890123',   
          '12345678901234',  
        ];

        for (final barcodeValue in testCases) {
          final expectedBarcode = Barcode(barcodeValue);
          final expectedProduct = createTestProduct(barcodeValue: barcodeValue);

          when(() => mockRepository.getProductByBarcode(expectedBarcode))
              .thenAnswer((_) async => expectedProduct);

          final result = await useCase.execute(barcodeValue);

          expect(result, equals(expectedProduct));
          verify(() => mockRepository.getProductByBarcode(expectedBarcode)).called(1);

          reset(mockRepository);
        }
      });

      test('should handle repository returning different products correctly', () async {
        const barcodeValue1 = '12345678';
        const barcodeValue2 = '87654321';
        final barcode1 = Barcode(barcodeValue1);
        final barcode2 = Barcode(barcodeValue2);
        final product1 = createTestProduct(barcodeValue: barcodeValue1, name: 'Product 1');
        final product2 = createTestProduct(barcodeValue: barcodeValue2, name: 'Product 2');

        when(() => mockRepository.getProductByBarcode(barcode1))
            .thenAnswer((_) async => product1);
        when(() => mockRepository.getProductByBarcode(barcode2))
            .thenAnswer((_) async => product2);

        final result1 = await useCase.execute(barcodeValue1);
        final result2 = await useCase.execute(barcodeValue2);

        expect(result1, equals(product1));
        expect(result2, equals(product2));
        expect(result1, isNot(equals(result2)));
      });
    });

    group('constructor', () {
      test('should accept ProductRepository dependency', () {
        final repository = MockProductRepository();
        final newUseCase = GetProductByBarcodeUseCase(repository);

        expect(newUseCase, isNotNull);
      });
    });

    group('edge cases', () {
      test('should handle repository that always returns null', () async {
        const barcodeValue = '12345678';
        final expectedBarcode = Barcode(barcodeValue);

        when(() => mockRepository.getProductByBarcode(expectedBarcode))
            .thenAnswer((_) async => null);

        final result = await useCase.execute(barcodeValue);

        expect(result, isNull);
        verify(() => mockRepository.getProductByBarcode(expectedBarcode)).called(1);
      });

      test('should work with barcode containing leading zeros', () async {
        const barcodeValue = '00012345';
        final expectedBarcode = Barcode(barcodeValue);
        final expectedProduct = createTestProduct(barcodeValue: barcodeValue);

        when(() => mockRepository.getProductByBarcode(expectedBarcode))
            .thenAnswer((_) async => expectedProduct);

        final result = await useCase.execute(barcodeValue);

        expect(result, equals(expectedProduct));
        expect(result?.barcode?.value, equals(barcodeValue));
      });

      test('should maintain barcode value integrity through the call chain', () async {
        const originalBarcodeValue = '12345678';
        final capturedBarcodes = <Barcode>[];
        final expectedBarcode = Barcode(originalBarcodeValue);

        when(() => mockRepository.getProductByBarcode(expectedBarcode))
            .thenAnswer((invocation) async {
              final barcode = invocation.positionalArguments[0] as Barcode;
              capturedBarcodes.add(barcode);
              return createTestProduct(barcodeValue: barcode.value);
            });

        await useCase.execute(originalBarcodeValue);

        expect(capturedBarcodes, hasLength(1));
        expect(capturedBarcodes.first.value, equals(originalBarcodeValue));
      });

      test('should handle async repository operations correctly', () async {
        const barcodeValue = '12345678';
        final expectedBarcode = Barcode(barcodeValue);
        final expectedProduct = createTestProduct(barcodeValue: barcodeValue);

        when(() => mockRepository.getProductByBarcode(expectedBarcode))
            .thenAnswer((_) async {
              await Future<void>.delayed(const Duration(milliseconds: 10));
              return expectedProduct;
            });

        final stopwatch = Stopwatch()..start();
        final result = await useCase.execute(barcodeValue);
        stopwatch.stop();

        expect(result, equals(expectedProduct));
        expect(stopwatch.elapsedMilliseconds, greaterThanOrEqualTo(10));
      });
    });
  });
}
