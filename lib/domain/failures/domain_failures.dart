abstract class DomainFailure implements Exception {
  final String message;
  const DomainFailure(this.message);
  
  @override
  String toString() => message;
}

class InvalidEmailFailure extends DomainFailure {
  const InvalidEmailFailure(super.message);
}

class InvalidUserIdFailure extends DomainFailure {
  const InvalidUserIdFailure(super.message);
}

class UserNotFoundFailure extends DomainFailure {
  const UserNotFoundFailure([super.message = 'Usuario no encontrado']);
}

class UserAlreadyExistsFailure extends DomainFailure {
  const UserAlreadyExistsFailure([super.message = 'Usuario ya existe']);
}

class InvalidBarcodeFailure extends DomainFailure {
  const InvalidBarcodeFailure(super.message);
}

class ProductNotFoundFailure extends DomainFailure {
  const ProductNotFoundFailure([super.message = 'Producto no encontrado']);
}

class ExternalServiceFailure extends DomainFailure {
  const ExternalServiceFailure(super.message);
}
