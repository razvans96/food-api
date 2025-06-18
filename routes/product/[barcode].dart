import 'package:dart_frog/dart_frog.dart';
import 'package:food_api/application/controllers/product_controller.dart';

Future<Response> onRequest(RequestContext context, String barcode) async {
  if (context.request.method == HttpMethod.get) {
    final controller = context.read<ProductController>();
    return controller.getProductByBarcode(context, barcode);
  }

  return Response(statusCode: 405, body: 'Method not allowed');
}
