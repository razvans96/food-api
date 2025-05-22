import 'package:dart_frog/dart_frog.dart';
// import product controller
import 'package:food_api/controllers/simple_product_controller.dart';

Future<Response> onRequest(RequestContext context) {
  return searchProduct(context);
}
