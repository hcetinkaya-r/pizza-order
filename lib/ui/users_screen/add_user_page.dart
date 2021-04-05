import 'package:flutter/material.dart';

import '../../controllers/user/user_controller.dart';
import '../../core/components/buttons/elevated_button.dart';
import '../../core/components/widgets/filter.dart';
import '../../core/components/widgets/header/header.dart';
import '../../core/components/widgets/pop_up_widget/pop_up_widget.dart';
import '../../core/components/widgets/text_field_item.dart';
import '../../core/util/size_config.dart';
import '../../main/widgets/background_image.dart';
import '../../main/widgets/main_nav_bar.dart';
import '../../models/user/user_model.dart';
import 'user_page.dart';

class AddUserPage extends StatefulWidget {
  static const routeName = '/add-user';
  final User user;

  const AddUserPage({this.user});

  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final userController = UserController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  String _currentSelectedValue = '';

  Future<void> onSave() async {
    try {
      widget.user != null
          ? await userController.updateUser(
              context,
              userNameController.text,
              widget.user.userId,
              passwordController.text,
              nameController.text,
              _currentSelectedValue,
            )
          : await userController.createUser(
              context,
              userNameController.text,
              passwordController.text,
              nameController.text,
              _currentSelectedValue,
            );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Done'),
        duration: const Duration(seconds: 1),
      ));
      Navigator.pop(context);
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('We got a problem, Please try again later!'),
        duration: const Duration(seconds: 1),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    _currentSelectedValue = widget.user?.userType == null
        ? 'Cashier'
        : widget.user.userType.toString().split('.')[1];
  }

  @override
  Widget build(BuildContext context) {
    var size = TextStyle(fontSize: SizeConfig.textMultiplier * 3.5);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          BackgroundImage(),
          Filter(),
          MainNavBar(),
          Positioned(
            left: SizeConfig.widthMultiplier * 24,
            child: Container(
              height: SizeConfig.heightMultiplier * 95,
              width: SizeConfig.widthMultiplier * 74,
              margin: EdgeInsets.symmetric(
                  vertical: SizeConfig.heightMultiplier * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Header(
                        title: widget.user != null
                            ? widget.user.userType.toString().split('.').last
                            : 'ADD USER',
                        type: widget.user != null ? 'edit' : '',
                        action: () {
                          return PopUpDialog(
                              // ignore: lines_longer_than_80_chars
                              content: Text(
                                'Are you sure you want to remove the '
                                'user?',
                              ),
                              leftButtonText: 'Cancel',
                              title: 'Are you sure?',
                              rightButtonText: 'Delete',
                              rightAction: () async {
                                await userController.removeUser(
                                    context, widget.user.userId);
                                await Navigator.of(context)
                                    .pushNamedAndRemoveUntil(
                                        UserPage.routeName, (route) => false);
                              }).show(context);
                        }),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 1),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Full Name',
                              style: size,
                            ),
                            SizedBox(height: SizeConfig.heightMultiplier * 2),
                            TextFieldItem(
                              initialValue: widget.user == null
                                  ? nameController =
                                      TextEditingController.fromValue(
                                          TextEditingValue(text: ''))
                                  : nameController =
                                      TextEditingController.fromValue(
                                          TextEditingValue(
                                              text: widget.user.fullName)),
                              width: SizeConfig.widthMultiplier * 27,
                              height: SizeConfig.heightMultiplier * 10,
                              radius: SizeConfig.imagesSizeMultiplier * 2,
                              vPadding: SizeConfig.heightMultiplier * 4,
                              hPadding: SizeConfig.heightMultiplier * 2,
                              fontSize: SizeConfig.textMultiplier * 4,
                              bottomMargin: SizeConfig.heightMultiplier * 2,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'User Name',
                              style: size,
                            ),
                            SizedBox(height: SizeConfig.heightMultiplier * 2),
                            TextFieldItem(
                              initialValue: widget.user == null
                                  ? userNameController =
                                      TextEditingController.fromValue(
                                          TextEditingValue(text: ''))
                                  : userNameController =
                                      TextEditingController.fromValue(
                                          TextEditingValue(
                                              text: widget.user.userName)),
                              width: SizeConfig.widthMultiplier * 27,
                              height: SizeConfig.heightMultiplier * 10,
                              radius: SizeConfig.imagesSizeMultiplier * 2,
                              vPadding: SizeConfig.heightMultiplier * 4,
                              hPadding: SizeConfig.heightMultiplier * 2,
                              fontSize: SizeConfig.textMultiplier * 4,
                              bottomMargin: SizeConfig.heightMultiplier * 2,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Password',
                              style: size,
                            ),
                            SizedBox(height: SizeConfig.heightMultiplier * 2),
                            TextFieldItem(
                              initialValue: widget.user == null
                                  ? passwordController =
                                      TextEditingController.fromValue(
                                          TextEditingValue(text: ''))
                                  : passwordController =
                                      TextEditingController.fromValue(
                                          TextEditingValue(
                                              text: widget.user.pass)),
                              width: SizeConfig.widthMultiplier * 27,
                              height: SizeConfig.heightMultiplier * 10,
                              radius: SizeConfig.imagesSizeMultiplier * 2,
                              vPadding: SizeConfig.heightMultiplier * 4,
                              hPadding: SizeConfig.heightMultiplier * 2,
                              fontSize: SizeConfig.textMultiplier * 4,
                              bottomMargin: SizeConfig.heightMultiplier * 2,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'User Type',
                              style: size,
                            ),
                            SizedBox(height: SizeConfig.heightMultiplier * 2),
                            Card(
                              color: Theme.of(context)
                                  .canvasColor
                                  .withOpacity(0.8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    SizeConfig.imagesSizeMultiplier * 2),
                              ),
                              elevation: 2,
                              shadowColor: Colors.black38,
                              child: Container(
                                alignment: Alignment.center,
                                width: SizeConfig.widthMultiplier * 27,
                                height: SizeConfig.heightMultiplier * 10,
                                padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.widthMultiplier * 3),
                                color: Colors.transparent,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    iconSize:
                                        SizeConfig.imagesSizeMultiplier * 2,
                                    iconDisabledColor: Colors.grey.shade400,
                                    value: _currentSelectedValue,
                                    isDense: true,
                                    items: [
                                      DropdownMenuItem(
                                        value: 'Admin',
                                        child: Text('Admin'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Cashier',
                                        child: Text('Cashier'),
                                      ),
                                    ],
                                    onChanged: (value) => setState(
                                      () => _currentSelectedValue = value,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: SizeConfig.heightMultiplier * 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AppElevatedButton(
                          fontSize: SizeConfig.textMultiplier * 5,
                          buttonColor: Theme.of(context).primaryColor,
                          width: SizeConfig.widthMultiplier * 25,
                          height: SizeConfig.heightMultiplier * 10,
                          inColor: Theme.of(context).canvasColor,
                          radius: SizeConfig.imagesSizeMultiplier * 1.5,
                          function: onSave,
                          child: Text('Save'),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
