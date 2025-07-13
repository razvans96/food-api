import 'package:food_api/domain/failures/domain_failures.dart';
import 'package:food_api/domain/value_objects/barcode.dart';
import 'package:test/test.dart';

void main() {
  group('Barcode Value Object', () {
    group('Constructor factory', () {
      test('should create valid Barcode with 8 digits', () {
        const validBarcode = '12345678';
        
        final barcode = Barcode(validBarcode);
        
        expect(barcode.value, equals(validBarcode));
      });

      test('should create valid Barcode with 14 digits', () {
        const validBarcode = '12345678901234';
        
        final barcode = Barcode(validBarcode);
        
        expect(barcode.value, equals(validBarcode));
      });

      test('should create valid Barcode with intermediate length (10 digits)', () {
        const validBarcode = '1234567890';
        
        final barcode = Barcode(validBarcode);
        
        expect(barcode.value, equals(validBarcode));
      });

      test('should trim whitespace from valid barcode', () {
        const barcodeWithSpaces = '  12345678  ';
        const expectedCleanBarcode = '12345678';
        
        final barcode = Barcode(barcodeWithSpaces);
        
        expect(barcode.value, equals(expectedCleanBarcode));
      });
    });

    group('Validation failures', () {
      test('should throw InvalidBarcodeFailure when barcode is empty', () {
        const emptyBarcode = '';
        
        expect(
          () => Barcode(emptyBarcode),
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

      test('should throw InvalidBarcodeFailure when barcode has only whitespace', () {
        const whitespaceBarcode = '   ';
        
        expect(
          () => Barcode(whitespaceBarcode),
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

      test('should throw InvalidBarcodeFailure when barcode is too short (7 digits)', () {
        const shortBarcode = '1234567';
        
        expect(
          () => Barcode(shortBarcode),
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

      test('should throw InvalidBarcodeFailure when barcode is too long (15 digits)', () {
        const longBarcode = '123456789012345';
        
        expect(
          () => Barcode(longBarcode),
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

      test('should throw InvalidBarcodeFailure when barcode contains letters', () {
        const barcodeWithLetters = '1234567A';
        
        expect(
          () => Barcode(barcodeWithLetters),
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

      test('should throw InvalidBarcodeFailure when barcode contains special characters', () {
        const barcodeWithSpecialChars = '12345-678';
        
        expect(
          () => Barcode(barcodeWithSpecialChars),
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

      test('should throw InvalidBarcodeFailure when barcode contains mixed alphanumeric', () {
        const mixedBarcode = '123ABC789';
        
        expect(
          () => Barcode(mixedBarcode),
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
    });

    group('Equality and identity', () {
      test('should be equal when values are the same', () {
        const barcodeValue = '12345678';
        final barcode1 = Barcode(barcodeValue);
        final barcode2 = Barcode(barcodeValue);
        
        expect(barcode1, equals(barcode2));
        expect(barcode1.hashCode, equals(barcode2.hashCode));
      });

      test('should not be equal when values are different', () {
        final barcode1 = Barcode('12345678');
        final barcode2 = Barcode('87654321');
        
        expect(barcode1, isNot(equals(barcode2)));
        expect(barcode1.hashCode, isNot(equals(barcode2.hashCode)));
      });

      test('should be equal even when created from strings with different whitespace', () {
        final barcode1 = Barcode('12345678');
        final barcode2 = Barcode('  12345678  ');
        
        expect(barcode1, equals(barcode2));
        expect(barcode1.hashCode, equals(barcode2.hashCode));
      });
    });

    group('String representation', () {
      test('should return the barcode value when converted to string', () {
        const barcodeValue = '12345678';
        final barcode = Barcode(barcodeValue);
        
        final stringRepresentation = barcode.toString();
        
        expect(stringRepresentation, equals(barcodeValue));
      });

      test('should return trimmed value in string representation', () {
        const barcodeWithSpaces = '  12345678  ';
        const expectedValue = '12345678';
        final barcode = Barcode(barcodeWithSpaces);
        
        final stringRepresentation = barcode.toString();
        
        expect(stringRepresentation, equals(expectedValue));
      });
    });

    group('Real-world barcode formats', () {
      test('should accept common EAN-8 format', () {
        const ean8Barcode = '96385074';
        
        final barcode = Barcode(ean8Barcode);
        
        expect(barcode.value, equals(ean8Barcode));
      });

      test('should accept common EAN-13 format', () {
        const ean13Barcode = '4006381333931';
        
        final barcode = Barcode(ean13Barcode);
        
        expect(barcode.value, equals(ean13Barcode));
      });

      test('should accept UPC-A format (12 digits)', () {
        const upcABarcode = '123456789012';
        
        final barcode = Barcode(upcABarcode);
        
        expect(barcode.value, equals(upcABarcode));
      });

      test('should accept ITF-14 format (14 digits)', () {
        const itf14Barcode = '01234567890123';
        
        final barcode = Barcode(itf14Barcode);
        
        expect(barcode.value, equals(itf14Barcode));
      });
    });

    group('Edge cases', () {
      test('should handle barcode with leading zeros', () {
        const barcodeWithLeadingZeros = '00012345';
        
        final barcode = Barcode(barcodeWithLeadingZeros);
        
        expect(barcode.value, equals(barcodeWithLeadingZeros));
      });

      test('should handle all zeros barcode', () {
        const allZerosBarcode = '00000000';
        
        final barcode = Barcode(allZerosBarcode);
        
        expect(barcode.value, equals(allZerosBarcode));
      });

      test('should handle all nines barcode', () {
        const allNinesBarcode = '99999999';
        
        final barcode = Barcode(allNinesBarcode);
        
        expect(barcode.value, equals(allNinesBarcode));
      });
    });
  });
}
