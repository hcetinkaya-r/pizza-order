import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/service/services.dart';
// import model
import '../../models/user/user_model.dart';

class UserController {
  final ApiServices _services = ApiServices();

  UserController();

  User getUser(BuildContext context, String userId) {
    var userModel = Provider.of<UserModel>(context, listen: false);
    return userModel.findById(userId);
  }

  Future<bool> removeUser(BuildContext context, String userId) async {
    try {
      var userModel = Provider.of<UserModel>(context, listen: false);
      var res = await _services.postResponse({'userId': userId}, 'user/delete');
      if (res['status'] == 200) {
        await userModel.removeUser(userId);
      }
      return true;
    } on DioError catch (e) {
      print(e.response);
      return false;
    }
  }

  Future<void> updateUser(
    BuildContext context,
    String userName,
    String userId,
    String password,
    String fullName,
    String userType,
  ) async {
    var userModel = Provider.of<UserModel>(context, listen: false);

    var data = {
      'userId': userId,
      'userName': userName,
      'userType': userType,
      'fullName': fullName,
      'password': password,
    };

    print(data);

    var res = await _services.postResponse(data, 'user/update');
    print(res);
    if (res['status'] == 200) {
      // ignore: unused_local_variable
      await userModel.updateUser(User(
        userId: userId,
        userType: userType == 'Admin' ? UserType.Admin : UserType.Cashier,
        fullName: fullName,
        userName: userName,
        pass: password,
      ));
    }
    print(res);
  }

  Future<bool> createUser(
    BuildContext context,
    String userName,
    String password,
    String fullName,
    String userType,
  ) async {
    var userModel = Provider.of<UserModel>(context, listen: false);

    var data = {
      'userName': userName,
      'userType': userType,
      'fullName': fullName,
      'password': password,
    };

    var res = await _services.postResponse(data, 'user/add');

    if (res['status'] == 200) {
      var user = User(
        userId: res['id'].toString(),
        userType: userType == 'Admin' ? UserType.Admin : UserType.Cashier,
        fullName: fullName,
        userName: userName,
        pass: password,
      );
      await userModel.createNewUser(user);
    }
    return true;
  }
}
