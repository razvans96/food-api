import 'package:dart_frog/dart_frog.dart';
import 'package:food_api/application/dto/api_response_dto.dart';
import 'package:food_api/application/dto/user_request_dto.dart';
import 'package:food_api/application/dto/user_response_dto.dart';
import 'package:food_api/domain/failures/domain_failures.dart';
import 'package:food_api/domain/use_cases/create_user_use_case.dart';
import 'package:food_api/domain/use_cases/get_user_by_id_use_case.dart';
import 'package:food_api/domain/use_cases/update_user_use_case.dart';

class UserController {
  final GetUserByIdUseCase _getUserByIdUseCase;
  final CreateUserUseCase _createUserUseCase;
  final UpdateUserUseCase _updateUserUseCase;

  UserController(
    this._getUserByIdUseCase,
    this._createUserUseCase,
    this._updateUserUseCase,
  );

  Future<Response> registerUser(RequestContext context) async {
    try {
      final json = await context.request.json() as Map<String, dynamic>;
      final requestDto = CreateUserRequestDto.fromJson(json);

      final userEntity = await _createUserUseCase.execute(
        uid: requestDto.userUid,
        email: requestDto.userEmail,
        name: requestDto.userName,
        surname: requestDto.userSurname,
        dateOfBirth: requestDto.userDob,
        phone: requestDto.userPhone,
        dietaryRestrictions: requestDto.userDietaryRestrictions,
      );

      final responseDto = UserResponseDto.fromDomain(userEntity);

      return Response.json(
        statusCode: 201,
        body: ApiResponse<UserResponseDto>.success(
          'Usuario registrado correctamente',
          responseDto,
        ).toJson((user) => user.toJson()),
      );
    } on DomainFailure catch (e) {
      return Response.json(
        statusCode: 400,
        body: ApiResponse<UserResponseDto>.error(e.message).toJsonWithoutData(),
      );
    } on FormatException catch (e) {
      return Response.json(
        statusCode: 400,
        body: ApiResponse<UserResponseDto>.error(
          'Formato JSON inválido: ${e.message}',
        ).toJsonWithoutData(),
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

  Future<Response> getUserByUid(RequestContext context, String uid) async {
    try {
      final userEntity = await _getUserByIdUseCase.execute(uid);
      if (userEntity == null) {
        return Response.json(
          statusCode: 404,
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
        body: ApiResponse<UserResponseDto>.error(e.message).toJsonWithoutData(),
      );
    } catch (e) {
      print(e);
      return Response.json(
        statusCode: 500,
        body: ApiResponse<UserResponseDto>.error(
          'Error interno del servidor',
        ).toJsonWithoutData(),
      );
    }
  }
}
