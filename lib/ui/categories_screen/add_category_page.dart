import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/category/category_controller.dart';
import '../../core/components/buttons/elevated_button.dart';
import '../../core/components/widgets/adding_item.dart';
import '../../core/components/widgets/filter.dart';
import '../../core/components/widgets/header/header.dart';
import '../../core/components/widgets/pop_up_widget/pop_up_widget.dart';
import '../../core/components/widgets/text_field_item.dart';
import '../../core/util/size_config.dart';
import '../../main/widgets/background_image.dart';
import '../../main/widgets/main_nav_bar.dart';
import '../../models/category/category_model.dart';
import '../../models/product/product_model.dart';
import 'categories_page.dart';

class AddCategoryPage extends StatefulWidget {
  static const routeName = '/add-category';
  final Category category;

  AddCategoryPage({this.category});

  @override
  _AddCategoryPageState createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final controller = CategoryController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          BackgroundImage(),
          Filter(),
          MainNavBar(),
          Positioned(
            left: SizeConfig.widthMultiplier * 25,
            child: Container(
              height: SizeConfig.heightMultiplier * 95,
              margin: EdgeInsets.only(top: SizeConfig.heightMultiplier * 2),
              child: Consumer<ProductModel>(builder: (ctx, prod, child) {
                return Container(
                  height: SizeConfig.heightMultiplier * 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Header(
                          title: widget.category != null
                              ? 'EDIT CATEGORY'
                              : 'ADD CATEGORY',
                          type: widget.category != null ? 'edit' : '',
                          action: () {
                            return PopUpDialog(
                                // ignore: lines_longer_than_80_chars
                                content: Text(
                                  'Are you sure you want to remove the '
                                  'category?',
                                ),
                                leftButtonText: 'Cancel',
                                title: 'Are you sure?',
                                rightButtonText: 'Delete',
                                rightAction: () {
                                  controller.removeCategory(context,
                                      categoryId: widget.category.categoryId);

                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      CategoriesPage.routeName,
                                      (route) => false);
                                }).show(context);
                          }),
                      CategorySection(widget: widget),
                      ProductsSection(prod: prod),
                      Buttons(
                        prod: prod,
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  const Buttons({this.prod});

  final ProductModel prod;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.widthMultiplier * 72,
      height: SizeConfig.heightMultiplier * 13,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          AppElevatedButton(
            fontSize: SizeConfig.textMultiplier * 5,
            buttonColor: Theme.of(context).accentColor,
            width: SizeConfig.widthMultiplier * 20,
            height: SizeConfig.heightMultiplier * 10,
            inColor: Theme.of(context).canvasColor,
            radius: SizeConfig.imagesSizeMultiplier * 2,
            function: () {
              prod.addEditingListItem(Product(
                  productId: null,
                  productCategory: null,
                  subProductIds: null,
                  productName: '',
                  productImgUrl: null));
            },
            child: Text('Add'),
          ),
          Container(
            height: SizeConfig.heightMultiplier * 25,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AppElevatedButton(
                  fontSize: SizeConfig.textMultiplier * 5,
                  buttonColor: Theme.of(context).primaryColor,
                  width: SizeConfig.widthMultiplier * 30,
                  height: SizeConfig.heightMultiplier * 12,
                  inColor: Theme.of(context).canvasColor,
                  radius: SizeConfig.imagesSizeMultiplier * 2,
                  function: () {},
                  child: Text('Save'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CategorySection extends StatefulWidget {
  const CategorySection({@required this.widget});

  final AddCategoryPage widget;

  @override
  _CategorySectionState createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  File _image;

  void pickFile() async {
    var result = await FilePicker.platform.pickFiles(type: FileType.any);

    if (result != null) {
      var image = File(result.files.single.path);
      var file = result.files.first;

      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      print(file.path);
    } else {
      // User canceled the picker
    }

    /* setState(() {
      _image = image;
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.widthMultiplier * 72,
      height: SizeConfig.heightMultiplier * 25,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Category Picture',
                style: TextStyle(fontSize: SizeConfig.textMultiplier * 3),
              ),
              AddingItem(
                width: SizeConfig.widthMultiplier * 9.5,
                height: SizeConfig.heightMultiplier * 17.5,
                title: Text(''),
                imgUrl: widget.widget.category == null
                    ? null
                    : widget.widget.category.categoryImgUrl,
                function: pickFile,
              ),
            ],
          ),
          SizedBox(width: SizeConfig.widthMultiplier * 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Category Name',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: SizeConfig.textMultiplier * 3,
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 3,
              ),
              TextFieldItem(
                initialValue: widget.widget.category == null
                    ? TextEditingController.fromValue(
                        TextEditingValue(text: ''))
                    : TextEditingController.fromValue(TextEditingValue(
                        text: widget.widget.category.categoryName)),
                width: SizeConfig.widthMultiplier * 30,
                height: SizeConfig.heightMultiplier * 11.6,
                radius: SizeConfig.imagesSizeMultiplier * 2,
                vPadding: SizeConfig.heightMultiplier * 4,
                hPadding: SizeConfig.heightMultiplier * 2,
                fontSize: SizeConfig.textMultiplier * 4,
                bottomMargin: SizeConfig.heightMultiplier * 1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProductsSection extends StatelessWidget {
  final ProductModel prod;

  ProductsSection({this.prod});

  @override
  Widget build(BuildContext context) {
    var controller = List<TextEditingController>.generate(
        prod.editingProducts.length,
        (index) => TextEditingController.fromValue(
            TextEditingValue(text: prod.editingProducts[index].productName)));
    return Column(
      children: [
        Container(
          width: SizeConfig.widthMultiplier * 72,
          child: Text(
            'Add Product',
            style: TextStyle(
              fontSize: SizeConfig.textMultiplier * 4,
            ),
          ),
        ),
        Container(
          height: SizeConfig.heightMultiplier * 27,
          width: SizeConfig.widthMultiplier * 72,
          child: prod.status == ProductModelStatus.Ended
              ? ListView.builder(
                  itemCount: prod.editingProducts.length,
                  itemBuilder: (ctxn, index) {
                    return Container(
                      width: SizeConfig.widthMultiplier * 72,
                      height: SizeConfig.heightMultiplier * 27,
                      alignment: Alignment.center,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: SizeConfig.heightMultiplier * 2),
                                child: Text(
                                  'Product Picture',
                                  style: TextStyle(
                                      fontSize: SizeConfig.textMultiplier * 3),
                                ),
                              ),
                              AddingItem(
                                imgUrl:
                                    prod.editingProducts[index].productImgUrl,
                                width: SizeConfig.widthMultiplier * 9.5,
                                height: SizeConfig.heightMultiplier * 17.5,
                                title: Text(''),
                                function: () {},
                              ),
                            ],
                          ),
                          SizedBox(width: SizeConfig.widthMultiplier * 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: SizeConfig.heightMultiplier * 2),
                                child: Text(
                                  'Product Name',
                                  style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 3,
                                  ),
                                ),
                              ),
                              TextFieldItem(
                                initialValue: controller[index],
                                width: SizeConfig.widthMultiplier * 30,
                                height: SizeConfig.heightMultiplier * 11.6,
                                radius: SizeConfig.imagesSizeMultiplier * 2,
                                vPadding: SizeConfig.heightMultiplier * 4,
                                hPadding: SizeConfig.heightMultiplier * 2,
                                fontSize: SizeConfig.textMultiplier * 4,
                                bottomMargin: SizeConfig.heightMultiplier * 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  })
              : Center(
                  child: CircularProgressIndicator(),
                ),
        )
      ],
    );
  }
}
