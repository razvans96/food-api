import 'package:dart_frog/dart_frog.dart';
import 'package:food_api/application/dto/api_response_dto.dart';
import 'package:food_api/application/dto/user_request_dto.dart';
import 'package:food_api/application/dto/user_response_dto.dart';
import 'package:food_api/domain/entities/user_entity.dart';
import 'package:food_api/domain/failures/domain_failures.dart';
import 'package:food_api/domain/repositories/user_repository.dart';
import 'package:food_api/domain/value_objects/email.dart';
import 'package:food_api/domain/value_objects/user_id.dart';

class UserController {
  final UserRepository _userRepository;

  const UserController(this._userRepository);

  Future<Response> registerUser(RequestContext context) async {
    try {
      final json = await context.request.json() as Map<String, dynamic>;
      final requestDto = CreateUserRequestDto.fromJson(json);

      final userId = UserId(requestDto.userUid);
      final email = Email(requestDto.userEmail);

      final existingUser = await _userRepository.existsById(userId);
      if (existingUser) {
        return Response.json(
          statusCode: 409, // Conflict
          body: ApiResponse<UserResponseDto>.error(
            'Usuario ya existe con este ID',
          ).toJsonWithoutData(),
        );
      }

      final userEntity = UserEntity(
        id: userId,
        email: email,
        name: requestDto.userName,
        surname: requestDto.userSurname,
        phone: requestDto.userPhone,
        dateOfBirth: requestDto.userDob != null 
            ? DateTime.tryParse(requestDto.userDob!) 
            : null,
        createdAt: DateTime.now(),
      );

      await _userRepository.saveUser(userEntity);

      final responseDto = UserResponseDto.fromDomain(userEntity);

      return Response.json(
        statusCode: 201, // Created
        body: ApiResponse<UserResponseDto>.success(
          'Usuario registrado correctamente',
          responseDto,
        ).toJson((user) => user.toJson()),
      );

    } on DomainFailure catch (e) {

      // Errores de dominio (validaciones)
      return Response.json(
        statusCode: 400,
        body: ApiResponse<UserResponseDto>.error(e.message)
            .toJsonWithoutData(),
      );
    } on FormatException catch (e) {
      // Error de JSON malformado
      return Response.json(
        statusCode: 400,
        body: ApiResponse<UserResponseDto>.error(
          'Formato JSON inválido: ${e.message}',
        ).toJsonWithoutData(),
      );
    } catch (e) {
      // Errores técnicos
      return Response.json(
        statusCode: 500, // Internal Server Error
        body: ApiResponse<UserResponseDto>.error(
          'Error interno del servidor',
        ).toJsonWithoutData(),
      );
    }
  }

  Future<Response> getUserByUid(RequestContext context, String uid) async {
    try {
      
      final userId = UserId(uid);

      final userEntity = await _userRepository.getUserById(userId);

      if (userEntity == null) {
        return Response.json(
          statusCode: 404, // Not Found
          body: ApiResponse<UserResponseDto>.error(
            'Usuario no encontrado',
          ).toJsonWithoutData(),
        );
      }

      final responseDto = UserResponseDto.fromDomain(userEntity);

      return Response.json(
        body: ApiResponse<UserResponseDto>.success(
          'Usuario encontrado correctamente',
          responseDto,
        ).toJson((user) => user.toJson()),
      );

    } on DomainFailure catch (e) {
      return Response.json(
        statusCode: 400,
        body: ApiResponse<UserResponseDto>.error(e.message)
            .toJsonWithoutData(),
      );
    } catch (e) {
      return Response.json(
        statusCode: 500,
        body: ApiResponse<UserResponseDto>.error(
          'Error interno del servidor',
        ).toJsonWithoutData(),
      );
    }
  }
}
