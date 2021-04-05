import 'package:flutter/material.dart';

enum DimensionModelStatus {
  Ended,
  Loading,
  Error,
}

class Dimension {
  String dimensionId;
  String size;
  double price;

  Dimension({this.dimensionId, this.size, this.price});

  factory Dimension.fromJson(Map<String, dynamic> json) => Dimension(
        dimensionId: json['id'] ?? 0,
        size: json['size'] ?? 'null',
        price: double.parse(json['price']) ?? 0.0,
      );

  Map<String, dynamic> toJson() =>
      {'id': dimensionId, 'size': size, 'price': price.toString()};

  @override
  String toString() {
    return toJson().toString();
  }
}

class DimensionModel extends ChangeNotifier {
  final List<Dimension> _dimensions = [];

  Dimension _selectedDimension;
  DimensionModelStatus _status;
  String _errorCode;
  String _errorMessage;

  List<Dimension> get dimensions => [..._dimensions];

  Dimension get selectedIngredient => _selectedDimension;

  String get errorCode => _errorCode;

  String get errorMessage => _errorMessage;

  DimensionModelStatus get status => _status;

  DimensionModel.instance() {
    ;
  }

  Dimension findById(String id) {
    return _dimensions.firstWhere((dim) => dim.dimensionId == id);
  }

  void setStatus(DimensionModelStatus status) {
    _status = status;
    notifyListeners();
  }

  void addDimension(Dimension dimension) {
    setStatus(DimensionModelStatus.Loading);

    _dimensions.add(dimension);

    setStatus(DimensionModelStatus.Ended);
  }

  void addDimensionFromJson(Map<String, dynamic> data) {
    setStatus(DimensionModelStatus.Loading);

    _dimensions.add(Dimension.fromJson(data));
    setStatus(DimensionModelStatus.Ended);
  }

  void editDimension(Dimension dimension) {
    var _dimension = findById(dimension.dimensionId);

    _dimension.size = dimension.size ?? _dimension.size;
    _dimension.price = dimension.price ?? _dimension.price;
  }

  void removeDimension(String dimensionId) {
    setStatus(DimensionModelStatus.Loading);
    _dimensions.removeWhere((dim) => dim.dimensionId == dimensionId);
    setStatus(DimensionModelStatus.Ended);
  }
}
