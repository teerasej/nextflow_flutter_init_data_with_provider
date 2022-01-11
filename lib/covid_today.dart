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

          return CircularProgressIndicator();
        },
      ),
    );
  }
}
