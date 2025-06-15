import 'package:json_annotation/json_annotation.dart';

part 'api_response_dto.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;
  final String? error;

  const ApiResponse({
    required this.success,
    required this.message,
    this.data,
    this.error,
  });

  factory ApiResponse.success(String message, [T? data]) {
    return ApiResponse<T>(
      success: true,
      message: message,
      data: data,
    );
  }

  factory ApiResponse.error(String error) {
    return ApiResponse<T>(
      success: false,
      message: 'Error',
      error: error,
    );
  }

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ApiResponseFromJson<T>(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ApiResponseToJson<T>(this, toJsonT);
  
  Map<String, dynamic> toJsonWithoutData() => {
    'success': success,
    'message': message,
    'data': data,
    'error': error,
  };

  @override
  String toString() => 'ApiResponse(success: $success, message: $message)';
}
