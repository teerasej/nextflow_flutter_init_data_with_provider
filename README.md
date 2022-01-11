# nextflow_flutter_init_data_with_provider

A new Flutter project.

## The Provider, with some async data load

```dart
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

```

## Using in Widget

There're many way to work with future, for example the below code use `FutureBuilder` to determine UI that will be displayed, according to Future's status.

```dart
import 'package:flutter/material.dart';
import 'package:nextflow_flutter_init_data_with_provider/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

class CovidTodayView extends StatelessWidget {
  const CovidTodayView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Covid Today'),
      ),
      body: FutureBuilder(
        // We used FutureBuilder to determine which UI should be displayed
        future: context.read<DataProvider>().loader,
        builder:
            (BuildContext context, AsyncSnapshot<Response<dynamic>> snapshot) {
          // if the Future's state is done. So we expected the data is ready to be use.
          if (snapshot.connectionState == ConnectionState.done) {
            return Text(
                'New case: ${context.read<DataProvider>().data['new_case']}');
          }

          // if Future is still in work, don't display UI that use that future's data.
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

```