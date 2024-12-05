import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:comenta_ai/core/models/app_user.dart';
import 'package:comenta_ai/core/service/auth/auth_service.dart';

class AuthMockService implements AuthService {
  static Map<String, AppUser> _users = {};
  static AppUser? _currentUser;
  static MultiStreamController<AppUser?>? _controller;

  static final _userStream = Stream<AppUser?>.multi(
    (controller) {
      _controller = controller;
      _updateUser(null);
    },
  );

  @override
  AppUser? get currentUser => _currentUser;

  @override
  Stream<AppUser?> get userChanges => _userStream;

  @override
  Future<void> login(String email, String password) async {
    _updateUser(_users[email]);
  }

  @override
  Future<void> logout() async {
    _updateUser(null);
  }

  @override
  Future<void> signup(
      String name, String email, String password, File? image) async {
    final newUser = AppUser(
      id: Random().nextDouble().toString(),
      name: name,
      email: email,
      imageUrl: image?.path ?? '/assests/images/...',
    );

    _users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }

  static void _updateUser(AppUser? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }
}
