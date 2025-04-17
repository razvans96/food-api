import 'package:dart_frog/dart_frog.dart';
import 'package:food_api/services/product_service.dart';


/// Controlador para buscar productos por nombre
Future<Response> searchProduct(RequestContext context) async {
  final queryParams = context.request.uri.queryParameters;
  final productName = queryParams['name'];

  if (productName == null || productName.isEmpty) {
    return Response.json(
      statusCode: 400,
      body: {'error': 'Falta el parámetro "name" en la consulta.'},
    );
  }

  final products = await ProductService.searchProductByName(productName);

  // Convertir la lista de productos a JSON
  return Response.json(
    body: {'products': products.map((product) => product.toJson()).toList()},
  );
}

/// Controlador para buscar un producto por código de barras
Future<Response> getProductByBarcode(RequestContext context, String barcode) async {
  if (barcode.isEmpty) {
    return Response.json(
      statusCode: 400,
      body: {'error': 'El parámetro "barcode" es obligatorio.'},
    );
  }

  try {
    final product = await ProductService.searchProductByBarcode(barcode);

    // Convertir el producto a JSON
    return Response.json(body: product.toJson());
  } catch (e) {
    return Response.json(
      statusCode: 500,
      body: {'error': 'Error al buscar el producto: $e'},
    );
  }
}






