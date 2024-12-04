import 'dart:io';

import 'package:comenta_ai/core/models/movie_user.dart';

abstract class AuthService {
  MovieUser? get currentUser;

  Stream<MovieUser?> get userChanges;

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
}
