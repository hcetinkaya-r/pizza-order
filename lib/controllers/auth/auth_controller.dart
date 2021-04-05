import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/service/services.dart';
// import model
import '../../models/user/user_model.dart';

class AuthController {
  AuthController();
  final ApiServices _service = ApiServices();

  Future<bool> init(BuildContext context) async {
    var authModel = Provider.of<UserModel>(context, listen: false);
    if (authModel.userNames.isEmpty) {
      var data = await _service.getResponse('user');
      List<dynamic> userJson = data;
      for (var user in userJson) {
        await authModel.init(user);
      }
    }
    return true;
  }

  List<String> getUserNames(BuildContext context) {
    var authModel = Provider.of<UserModel>(context, listen: false);
    return authModel.userNames;
  }

  List<User> getUsers(BuildContext context) {
    var userModel = Provider.of<UserModel>(context, listen: false);
    return userModel.users;
  }

  Future<bool> login(BuildContext context,
      {Map<String, String> authData}) async {
    var authModel = Provider.of<UserModel>(context, listen: false);

    var type = await authModel.login(
        userName: authData['userName'], password: authData['password']);
    return type;
  }

  void logout(BuildContext context) {
    var authModel = Provider.of<UserModel>(context, listen: false);
    authModel.logout();
  }
}
