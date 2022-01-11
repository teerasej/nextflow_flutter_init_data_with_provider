import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  Future<Response>? loader;
  String hello = 'Hello';

  DataProvider() {
    _prepareData();
  }

  _prepareData() async {
    try {
      loader =
          Dio().get('https://covid19.ddc.moph.go.th/api/Cases/today-cases-all');

      loader?.then((response) {
        print(response.statusCode);
      });
    } on Exception catch (_, e) {}
  }
}
