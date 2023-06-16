Exception throwRemoteException(String statusCode) {
  if (statusCode == "1001") {
    throw UserNotFoundException();
  } else if (statusCode == "1002") {
    throw PasswordNotMatchException();
  } else if (statusCode == "2001") {
    throw CategoryAlreadyExistException();
  } else if (statusCode == "500") {
    throw SomethingWentWrongException();
  }
  throw SomethingWentWrongException();
}

class SomethingWentWrongException implements Exception {}

class UserNotFoundException implements Exception {}

class UserNotLoggedInException implements Exception {}

class PasswordNotMatchException implements Exception {}

class CategoryAlreadyExistException implements Exception {}

class AddUserAlreadyExist implements Exception {
  String message;
  AddUserAlreadyExist({required this.message});
}

class ApiRequestMessageException implements Exception {
  String message;

  ApiRequestMessageException({required this.message});
}
