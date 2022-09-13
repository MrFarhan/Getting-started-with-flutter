import 'package:myapp/services/auth/auth_exception.dart';
import 'package:myapp/services/auth/auth_provider.dart';
import 'package:myapp/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main() {
  group('Mock Authentication', () {
    final provider = MockAuthProvider();
    test('Should not be initialized at begning', () {
      expect(provider.isInitialized, false);
    });
    test('Can not logout if not initialized', () {
      expect(
          provider.logOut(),
          throwsA(
            TypeMatcher<NotInitializedException>(),
          ));
      test('Should be able to initialized', () async {
        await provider.initialize();
        expect(provider.isInitialized, true);
      });
      test('User should be null', () {
        expect(provider.currentUser, null);
      });
      test('should be able to initialize in 1 minute', () async {
        await provider.initialize();
        expect(provider.isInitialized, true);
      });
      Timeout(Duration(seconds: 2));
    });
    test('Create user to with login func ', () async {
      final badEmailUser = provider.createUser(
        email: 'foo@bar.com',
        password: 'foobarbaz',
      );
      expect(badEmailUser, throwsA(TypeMatcher<UserNotFoundAuthException>()));
      final badPasswordUser = provider.createUser(
        email: 'hello@bar.com',
        password: 'foobar',
      );
      expect(
          badPasswordUser, throwsA(TypeMatcher<WrongPasswordAuthException>()));

      final user = await provider.createUser(
        email: 'foo',
        password: 'bar',
      );
      expect(provider.currentUser, user);
      expect(user.isEmailVerified, false);
    });
    test('loggedin user should be able to get verified', () async {
      await provider.sendEmailVerification();
      final user = provider.currentUser;
      expect(user, isNotNull);
      expect(user!.isEmailVerified, true);
    });
    test('should be able to logout and login again', () async {
      await provider.logOut();
      await provider.logIn(email: 'email', password: ' password');
    });
    final user = provider.currentUser;
    expect(user, isNotNull);
  });
}

class NotInitializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isInitialized = false;
  bool get isInitialized => _isInitialized;

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (!isInitialized) throw NotInitializedException();
    await Future.delayed(const Duration(seconds: 1));
    return logIn(
      email: email,
      password: password,
    );
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
    throw UnimplementedError();
  }

  @override
  Future<AuthUser> logIn({required String email, required String password}) {
    if (!isInitialized) throw NotInitializedException();
    if (email == "foo@bar.com") throw UserNotFoundAuthException();
    if (password == "foobarbaz") throw WrongPasswordAuthException();
    const user = AuthUser(isEmailVerified: false);
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    if (!isInitialized) throw NotInitializedException();
    if (_user == null) throw UserNotFoundAuthException();
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialized) throw NotInitializedException();
    final user = _user;
    if (user == null) throw UserNotFoundAuthException();
    const newUser = AuthUser(isEmailVerified: true);
    _user = newUser;
  }
}
