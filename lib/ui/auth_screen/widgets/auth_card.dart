import 'package:flutter/material.dart';

import '../../../controllers/auth/auth_controller.dart';
import '../../../core/components/buttons/elevated_button.dart';
import '../../../core/util/size_config.dart';
import '../../menu_screen/menu_page.dart';

enum AuthMode { SignUp, Login }

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Map<String, String> _authData = {
    'userName': '',
    'password': '',
  };

  AuthController controller = AuthController();
  var _isLoading = false;
  var _errorMessage = '';
  final _passwordController = TextEditingController();
  String _currentSelectedValue;
  Future<bool> _myData;

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      _authData['userName'] =
          _currentSelectedValue ?? controller.getUserNames(context)[0];
      _authData['password'] = _passwordController.text;
      await controller.login(context, authData: _authData);
      await Navigator.pushNamed(context, MenuPage.routeName);
    } on Exception {
      _errorMessage = 'Username or Password is not valid';
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _myData = controller.init(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _myData,
        builder: (context, snapshot) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(SizeConfig.imagesSizeMultiplier * 3),
            ),
            color: Color.fromRGBO(200, 204, 207, 0.8),
            child: Container(
              width: SizeConfig.widthMultiplier * 33,
              height: SizeConfig.heightMultiplier * 33,
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(
                vertical: SizeConfig.heightMultiplier * 4,
                horizontal: SizeConfig.widthMultiplier * 4,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image(
                    image: AssetImage('assets/logo/logo.png'),
                  ),
                  snapshot.hasData
                      ? Container(
                          height: SizeConfig.heightMultiplier * 60,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              SizeConfig.heightMultiplier * 2),
                                      child: DropdownButtonFormField<String>(
                                        iconSize:
                                            SizeConfig.imagesSizeMultiplier * 2,
                                        iconDisabledColor: Colors.grey.shade400,
                                        value: _currentSelectedValue ??
                                            controller.getUserNames(context)[0],
                                        isDense: true,
                                        items: controller
                                            .getUserNames(context)
                                            .map((val) => DropdownMenuItem(
                                                  value: val,
                                                  child: Text(val),
                                                ))
                                            .toList(),
                                        onChanged: (value) => setState(() =>
                                            _currentSelectedValue = value),
                                      ),
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'Password',
                                        prefixIcon: Icon(
                                          Icons.lock_open,
                                        ),
                                        filled: true,
                                        fillColor: Colors.grey.shade500,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              SizeConfig.imagesSizeMultiplier *
                                                  1),
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              style: BorderStyle.none),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              SizeConfig.imagesSizeMultiplier *
                                                  1),
                                          borderSide: BorderSide(
                                              style: BorderStyle.none),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              SizeConfig.imagesSizeMultiplier *
                                                  1),
                                          borderSide: BorderSide(
                                              style: BorderStyle.none),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              SizeConfig.imagesSizeMultiplier *
                                                  1),
                                          borderSide: BorderSide(
                                              style: BorderStyle.none),
                                        ),
                                      ),
                                      obscureText: true,
                                      controller: _passwordController,
                                      validator: (value) {
                                        if (value.isEmpty || value.length < 5) {
                                          return 'Password is too short!';
                                        }
                                        return null;
                                      },
                                      onEditingComplete: () {
                                        _authData['password'] =
                                            _passwordController.text;
                                        _submit();
                                      },
                                      onSaved: (value) {
                                        _authData['password'] = value;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                  height: SizeConfig.heightMultiplier * 0.5),
                              if (_errorMessage != '')
                                Text(
                                  _errorMessage,
                                  style: TextStyle(
                                      color: Theme.of(context).errorColor),
                                ),
                              SizedBox(
                                  height: SizeConfig.heightMultiplier * 0.5),
                              if (_isLoading)
                                CircularProgressIndicator()
                              else
                                AppElevatedButton(
                                  fontSize: SizeConfig.textMultiplier * 4,
                                  buttonColor: Theme.of(context).primaryColor,
                                  width: SizeConfig.widthMultiplier * 18,
                                  height: SizeConfig.heightMultiplier * 10,
                                  inColor: Theme.of(context).canvasColor,
                                  radius: SizeConfig.imagesSizeMultiplier * 2,
                                  function: _submit,
                                  child: Text('Login'),
                                ),
                            ],
                          ),
                        )
                      : snapshot.hasError
                          ? Center(
                              child: Text(snapshot.error),
                            )
                          : Center(
                              child: CircularProgressIndicator(),
                            ),
                ],
              ),
            ),
          );
        });
  }
}
