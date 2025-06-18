import 'package:dart_frog/dart_frog.dart';
import 'package:food_api/application/dto/api_response_dto.dart';
import 'package:food_api/application/dto/product_response_dto.dart';
import 'package:food_api/domain/failures/domain_failures.dart';
import 'package:food_api/domain/use_cases/get_product_by_barcode_use_case.dart';
import 'package:food_api/domain/use_cases/save_product_use_case.dart';
import 'package:food_api/domain/use_cases/search_products_use_case.dart';

class ProductController {
  final GetProductByBarcodeUseCase _getProductByBarcodeUseCase;
  final SearchProductsUseCase _searchProductsUseCase;
  final SaveProductUseCase _saveProductUseCase;

  const ProductController(
    this._getProductByBarcodeUseCase,
    this._searchProductsUseCase,
    this._saveProductUseCase,
  );

  Future<Response> getProductByBarcode(RequestContext context, String barcode) async {
    try {
      if (barcode.trim().isEmpty) {
        return Response.json(
          statusCode: 400,
          body: ApiResponse<ProductResponseDto>.error(
            'El código de barras es obligatorio',
          ).toJsonWithoutData(),
        );
      }

      final product = await _getProductByBarcodeUseCase.execute(barcode.trim());

      if (product == null) {
        return Response.json(
          statusCode: 404,
          body: ApiResponse<ProductResponseDto>.error(
            'Producto no encontrado',
          ).toJsonWithoutData(),
        );
      }

      final responseDto = ProductResponseDto.fromDomain(product);

      return Response.json(
        body: ApiResponse<ProductResponseDto>.success(
          'Producto encontrado correctamente',
          responseDto,
        ).toJson((product) => product.toJson()),
      );

    } on DomainFailure catch (e) {
      return Response.json(
        statusCode: 400,
        body: ApiResponse<ProductResponseDto>.error(e.message)
            .toJsonWithoutData(),
      );
    } on FormatException catch (e) {
      return Response.json(
        statusCode: 400,
        body: ApiResponse<ProductResponseDto>.error(
          'Formato de código de barras inválido: ${e.message}',
        ).toJsonWithoutData(),
      );
    } catch (e) {
      return Response.json(
        statusCode: 500,
        body: ApiResponse<ProductResponseDto>.error(
          'Error interno del servidor',
        ).toJsonWithoutData(),
      );
    }
  }

  Future<Response> searchProducts(RequestContext context) async {
    try {
      final queryParams = context.request.uri.queryParameters;
      final searchTerm = queryParams['q'] ?? queryParams['name'];

      if (searchTerm?.trim().isEmpty ?? true) {
        return Response.json(
          statusCode: 400,
          body: ApiResponse<List<ProductResponseDto>>.error(
            'El parámetro de búsqueda "q" o "name" es obligatorio',
          ).toJsonWithoutData(),
        );
      }

      final products = await _searchProductsUseCase.execute(searchTerm!.trim());
      
      final responseDtos = products
          .map(ProductResponseDto.fromDomain)
          .toList();

      return Response.json(
        body: ApiResponse<List<ProductResponseDto>>.success(
          'Búsqueda completada - ${responseDtos.length} productos encontrados',
          responseDtos,
        ).toJson((products) => products.map((p) => p.toJson()).toList()),
      );

    } on DomainFailure catch (e) {
      return Response.json(
        statusCode: 400,
        body: ApiResponse<List<ProductResponseDto>>.error(e.message)
            .toJsonWithoutData(),
      );
    } on FormatException catch (e) {
      return Response.json(
        statusCode: 400,
        body: ApiResponse<List<ProductResponseDto>>.error(
          'Formato de búsqueda inválido: ${e.message}',
        ).toJsonWithoutData(),
      );
    } catch (e) {
      return Response.json(
        statusCode: 500,
        body: ApiResponse<List<ProductResponseDto>>.error(
          'Error interno del servidor',
        ).toJsonWithoutData(),
      );
    }
  }


  Future<Response> saveProduct(RequestContext context) async {
    try {
      final json = await context.request.json() as Map<String, dynamic>;
      final barcode = json['barcode'] as String?;

      if (barcode?.trim().isEmpty ?? true) {
        return Response.json(
          statusCode: 400,
          body: ApiResponse<Map<String, dynamic>>.error(
            'El código de barras es obligatorio',
          ).toJsonWithoutData(),
        );
      }


      final product = await _getProductByBarcodeUseCase.execute(barcode!.trim());
      
      if (product == null) {
        return Response.json(
          statusCode: 404,
          body: ApiResponse<Map<String, dynamic>>.error(
            'Producto no encontrado para guardar',
          ).toJsonWithoutData(),
        );
      }

      final success = await _saveProductUseCase.execute(product);

      if (success) {
        // Para no devolver el objeto completo, solo devolvemos los datos necesarios
        final responseData = {
          'barcode': product.barcode?.value,
          'name': product.name,
          'saved': true,
          'saved_at': DateTime.now().toIso8601String(),
        };

        return Response.json(
          statusCode: 201, // Created
          body: ApiResponse<Map<String, dynamic>>.success(
            'Producto guardado correctamente',
            responseData,
          ).toJson((data) => data),
        );
      } else {
        return Response.json(
          statusCode: 500,
          body: ApiResponse<Map<String, dynamic>>.error(
            'Error guardando el producto',
          ).toJsonWithoutData(),
        );
      }

    } on DomainFailure catch (e) {
      return Response.json(
        statusCode: 400,
        body: ApiResponse<Map<String, dynamic>>.error(e.message)
            .toJsonWithoutData(),
      );
    } on FormatException catch (e) {
      return Response.json(
        statusCode: 400,
        body: ApiResponse<Map<String, dynamic>>.error(
          'Formato JSON inválido: ${e.message}',
        ).toJsonWithoutData(),
      );
    } catch (e) {
      return Response.json(
        statusCode: 500,
        body: ApiResponse<Map<String, dynamic>>.error(
          'Error interno del servidor',
        ).toJsonWithoutData(),
      );
    }
  }
}
