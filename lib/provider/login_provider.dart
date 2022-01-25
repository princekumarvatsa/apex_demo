import 'package:apex_demo/model/input_validator.dart';
import 'package:apex_demo/provider/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginProvider with ChangeNotifier {
  InputValidator? _username = InputValidator(input: null, error: null);
  InputValidator? _password = InputValidator(input: null, error: null);
  String _error = "";
  bool _isValid = false;

  bool get isValid => _isValid;
  String get error => _error;

  InputValidator get username => _username!;
  InputValidator get password => _password!;

  void _isValidInput() {
    if (_username != null &&
        _username!.input != null &&
        _username!.input!.length >= 3 &&
        _username!.input!.length <= 11 &&
        _password != null &&
        _password!.input != null &&
        _password!.input!.length >= 3 &&
        _password!.input!.length <= 11) {
      _isValid = true;
    } else {
      _isValid = false;
    }
    _error = "";
  }

  void changeUsername(String input) {
    if (input.length >= 3 && input.length <= 11) {
      _username = InputValidator(input: input, error: null);
    } else if (input.length > 11) {
      _username = InputValidator(input: input, error: "Phone can't be more than 11 digits.");
    } else {
      _username = InputValidator(input: input, error: "Phone can't be less than 3 digits.");
    }
    _isValidInput();
    notifyListeners();
  }

  void changePassword(String input) {
    if (input.length >= 3 && input.length <= 11) {
      _password = InputValidator(input: input, error: null);
    } else if (input.length > 11) {
      _password = InputValidator(input: input, error: "Password can't be more than 11 digits.");
    } else {
      _password = InputValidator(input: input, error: "Password can't be less than 3 digits.");
    }
    _isValidInput();
    notifyListeners();
  }

  void submitForm(BuildContext context) {
    // User 1: 9898989898 / password123
    // User 2: 9876543210 / password123
    if ((_username!.input!.trim() == "9898989898" && _password!.input!.trim() == "password123") ||
        (_username!.input!.trim() == "9876543210" && _password!.input!.trim() == "password123")) {
      context.read<AuthenticationProvider>().loginUser(context);
    } else {
      _error = "Invalid username, password combination.";
      notifyListeners();
    }
  }
}
