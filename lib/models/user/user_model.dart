import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/user/user_controller.dart';

enum UserModelStatus {
  Ended,
  Loading,
  Error,
}

enum UserType {
  Admin,
  Cashier,
}

class User {
  String userId;
  UserType userType;
  String fullName;
  String userName;
  String pass;

  User(
      {@required this.userId,
      @required this.userType,
      @required this.fullName,
      @required this.userName,
      this.pass});

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json['userId'] ?? 0,
        userType:
            json['userType'] == 'Admin' ? UserType.Admin : UserType.Cashier,
        fullName: json['fullName'] ?? 'null',
        userName: json['userName'] ?? 'null',
        pass: json['password'],
      );

  @override
  String toString() => 'UserId: $userId,\n'
      'UserType: $userType, \n'
      'UserName: $userName, \n'
      'Full Name:   $fullName,'
      'Password: $pass';
}

class UserModel extends ChangeNotifier {
  User _currentUser;

  final _users = <User>[];

  UserModelStatus _status;
  String _errorCode;
  String _errorMessage;

  UserController controller;

  String get errorCode => _errorCode;

  String get errorMessage => _errorMessage;

  UserModelStatus get status => _status;

  User get user => _currentUser;

  List<String> get userNames => _users.map((e) => e.userName).toList();

  List<User> get users => _users;

  UserType get userType => _currentUser.userType;

  UserModel.instance() {
    //TODO Add code here
  }

  /// Temp function
  void init(Map<String, dynamic> data) {
    _users.add(User.fromJson(data));
  }

  User findById(String userId) {
    return _users.firstWhere((user) => user.userId == userId);
  }

  Future<void> createNewUser(User newUserData) async {
    _users.add(newUserData);
    notifyListeners();
    print('hello');
  }

  void setStatus(UserModelStatus status) {
    _status = status;
    notifyListeners();
  }

  Future<void> removeUser(String userId) async {
    setStatus(UserModelStatus.Loading);
    _users.removeWhere((user) => user.userId == userId);
    setStatus(UserModelStatus.Ended);
  }

  Future<bool> login({String userName, String password}) async {
    _status = UserModelStatus.Loading;
    notifyListeners();
    var _user = _users.firstWhere((user) => user.userName == userName);

    _user.pass == password
        ? _currentUser = _user
        : throw Exception('Password not matching');
    _status = UserModelStatus.Ended;
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _status = UserModelStatus.Loading;
    notifyListeners();

    _currentUser = null;

    _status = UserModelStatus.Ended;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> updateUser(User _user) async {
    var us = await findById(_user.userId);
    us.fullName = _user.fullName;
    us.pass = _user.pass;
    us.userName = _user.userName;
    us.userType = _user.userType;
    notifyListeners();
  }
}
