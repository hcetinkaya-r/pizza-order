import 'dart:convert';

import 'package:dio/dio.dart';

class ApiServices {
  static const String _baseUrl = 'https://www.kvkkolay.com/kiosk';
  Dio dio = Dio();
  JsonCodec codec = JsonCodec();

  Future<dynamic> getResponse(String url) async {
    var res = await dio.get('$_baseUrl/$url');
    return res.data;
  }

  Future<dynamic> postResponse(Map<String, dynamic> data, String url) async {
    var res = await dio.post('$_baseUrl/$url', data: FormData.fromMap(data));

    return res.data;
  }
}
