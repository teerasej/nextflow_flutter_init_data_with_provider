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
        future: context.read<DataProvider>().loader,
        builder:
            (BuildContext context, AsyncSnapshot<Response<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Text('ok');
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }
}
