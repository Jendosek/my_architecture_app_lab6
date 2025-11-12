import 'package:flutter/material.dart';
import '../../di/injection_container.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/entities/user.dart';

class AuthProvider extends ChangeNotifier {
  
  final LoginUseCase _loginUseCase = sl<LoginUseCase>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  User? _user;
  User? get user => _user;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners(); 

    try {
      final user = await _loginUseCase.call(email, password);
      _user = user;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
}