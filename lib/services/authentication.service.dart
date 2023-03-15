import 'package:flex_year_tablet/data_models/user.data.dart';

abstract class AuthenticationService {
  UserData? get user;

  /// Checks if users is loggedin or not
  Future<bool> isLoggedIn();

  /// Authenticate user by username and password
  Future<void> authByUsername({
    required String username,
    required String password,
  });

  /// Authenticate user by login pin
  Future<void> authByPin({
    required String pin,
  });

  /// Returns the reponse of request.
  Future<String> requestResetPassword(
      {required String email, required int company_id});

  /// Get saved username
  Future<String?> getSavedUsername();

  // Get saved password
  Future<String?> getSavedPassword();

  /// Update user
  Future<void> updateUser(Map<String, dynamic> data);

  /// Returns [true] if the logged in user is a normal user.
  bool get isNormalUser;

  /// Save username on remember me
  Future<void> saveUsername(String username);

  /// save password on remember me
  Future<void> savePassword(String password);

  /// Logout user and clear all data
  Future<void> logout();
}
