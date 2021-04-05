import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/service/services.dart';
import '../../models/ingredient/ingredient_model.dart';
// import model

class IngredientController {
  IngredientController();

  final ApiServices _services = ApiServices();

  Future<bool> init(BuildContext context) async {
    var ingredientModel = Provider.of<IngredientModel>(context, listen: false);
    if (ingredientModel.ingredients.isEmpty) {
      var data = await _services.getResponse('ingredients');
      List<dynamic> ingredientsJson = data;
      for (var ingredient in ingredientsJson) {
        try {
          ingredientModel.addIngredientFromJson(ingredient);
          // ignore: avoid_catches_without_on_clauses
        } catch (e) {
          print(e);
        }
      }
    }

    return true;
  }

  List<Ingredient> ingredients(BuildContext context) {
    var productModel = Provider.of<IngredientModel>(context, listen: false);
    return productModel.ingredients;
  }

  List<String> getIngredientNames(BuildContext context) {
    var ingredientModel = Provider.of<IngredientModel>(context, listen: false);
    return ingredientModel.ingredientNames;
  }

  String getSelectedIngName(BuildContext context) {
    var ingredientModel = Provider.of<IngredientModel>(context, listen: false);
    return ingredientModel.selectedIngredient?.ingredientName ?? '';
  }

  Future<void> addIngredients(
    BuildContext context, {
    String ingredientImg,
    String ingredientName,
    double price,
  }) async {
    var productModel = Provider.of<IngredientModel>(context, listen: false);
    var imageData = {'image': ''};
    var resImage = await _services.postResponse(imageData, 'files/do_upload');
    var data = {
      'ingredientName': ingredientName,
      'ingredientImgUrl': resImage['upload_data']['full_path'],
      'price': price,
    };
    var res = await _services.postResponse(data, 'ingredients/add');
    var ingredient = Ingredient(
        ingredientId: res['id'],
        ingredientImgUrl: resImage['upload_data']['full_path'],
        ingredientName: ingredientName,
        price: price);
    productModel.addIngredient(ingredient);
  }

  Future<void> editIngredient(BuildContext context,
      {@required String ingredientId,
      String ingredientImgUrl,
      String ingredientName,
      double price,
      bool editedImage}) async {
    var productModel = Provider.of<IngredientModel>(context, listen: false);
    var resImage;
    if (editedImage) {
      var imageData = {'image': ''};
      resImage = await _services.postResponse(imageData, 'files/do_upload');
    }
    var data = {
      'ingredientName': ingredientName,
      'ingredientImgUrl':
          editedImage ? resImage['upload_data']['full_path'] : ingredientImgUrl,
      'price': price,
    };
    var res = await _services.postResponse(data, 'ingredients/update');
    var ingredient = Ingredient(
        ingredientId: res['id'],
        ingredientImgUrl: editedImage
            ? resImage['upload_data']['full_path']
            : ingredientImgUrl,
        ingredientName: ingredientName,
        price: price);
    productModel.editIngredient(ingredient);
  }

  Ingredient getIngredient(BuildContext context, String index) {
    var productModel = Provider.of<IngredientModel>(context, listen: false);

    return productModel.findById(index);
  }

  Future<void> removeIngredient(
    BuildContext context, {
    @required String ingredientId,
  }) async {
    var ingredientModel = Provider.of<IngredientModel>(context, listen: false);
    var res = await _services
        .postResponse({'ingredients_id': ingredientId}, 'ingredients/delete');

    if (res['status'] == 200) {
      ingredientModel.removeIngredient(ingredientId);
    }
  }
}
