import 'package:dart_frog/dart_frog.dart';
import 'package:food_api/controllers/product_controller.dart';

Future<Response> onRequest(RequestContext context, String barcode) {
  return getProductByBarcode(context, barcode);
}
