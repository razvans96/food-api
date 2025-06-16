import 'package:food_api/domain/failures/domain_failures.dart';
import 'package:meta/meta.dart';

@immutable
class Barcode {

  factory Barcode(String barcode) {
    if (barcode.isEmpty) {
      throw const InvalidBarcodeFailure('Código de barras no puede estar vacío');
    }
    
    // Validación básica: solo números y longitud típica (8-14 dígitos)
    final cleanBarcode = barcode.trim();
    final numericRegex = RegExp(r'^\d{8,14}$');
    
    if (!numericRegex.hasMatch(cleanBarcode)) {
      throw const InvalidBarcodeFailure(
        'Código de barras debe contener entre 8 y 14 dígitos',
      );
    }
    
    return Barcode._(cleanBarcode);
  }
  final String value;

  const Barcode._(this.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Barcode && runtimeType == other.runtimeType && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}
