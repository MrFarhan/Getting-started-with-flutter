// Login exceptions
class UserNotFoundAuthException implements Exception{}
class WrongPasswordAuthException implements Exception{}

// Signup exceptions
class WeakPasswordAuthException implements Exception{}
class EmailAlreadyInUseAuthException implements Exception{}
class InValidEmailAuthException implements Exception{}

// generic exceptions
class GenerucAuthException implements Exception{}
class UserNotLoggedinAuthException implements Exception{}
