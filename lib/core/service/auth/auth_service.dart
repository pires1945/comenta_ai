import 'dart:io';
import 'package:comenta_ai/core/models/app_user.dart';
import 'package:comenta_ai/core/service/auth/auth_firebase_service.dart';

abstract class AuthService {
  AppUser? get currentUser;

  Stream<AppUser?> get userChanges;

  Future<void> signup(
    String name,
    String email,
    String password,
    File? image,
  );

  Future<void> login(
    String email,
    String password,
  );

  Future<void> logout();

  factory AuthService() {
    //return AuthMockService();
    return AuthFirebaseService();
  }
}
