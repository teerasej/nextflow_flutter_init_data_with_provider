import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  // This future property will hold the async process
  // This future was planned to hold Dio's async request, so we defined its type as Dio's Response class
  Future<Response>? loader;

  // this will hold the data from process, don't forget that this data will live forever until the app gone.
  dynamic data;

  // constructor will start the data initialize.
  DataProvider() {
    _prepareData();
  }

  _prepareData() async {
    try {
      // you can copy and paste this url on browser to see JSON's structure
      loader =
          Dio().get('https://covid19.ddc.moph.go.th/api/Cases/today-cases-all');

      // Future, it can be compared with JavaScript's promise so you can expect '.then'
      loader?.then((response) {
        print(response.statusCode);
        // Keep data inside provider for future use
        data = response.data[0];
      });
    } on Exception catch (_, e) {}
  }
}
