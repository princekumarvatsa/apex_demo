import 'package:apex_demo/model/user.dart';
import 'package:apex_demo/provider/tournaments_provider.dart';
import 'package:apex_demo/services/http_service.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  final HttpService _httpService = HttpService();
  HasError httpError = HasError(false, "");
  UserData? _userData;
  bool _isLoading = false;

  UserData? get userData => _userData;
  bool get isLoading => _isLoading;

  void setUserData(UserData? data) {
    _userData = data!;
    notifyListeners();
  }

  Future<void> getUser() async {
    _isLoading = true;
    await getUserFromServer();
    _isLoading = false;
  }

  Future<void> getUserFromServer() async {
    try {
      User? response = await _httpService.getUserData();
      if (response != null && response.success == true) {
        setUserData(response.data);
      }
    } catch (e) {
      httpError = HasError(true, e.toString().replaceFirst("Exception", "Error"));
      notifyListeners();
    }
  }
}
