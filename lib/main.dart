import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lookalike/prediction.dart';
import 'package:lookalike/routes.dart';
import 'home.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
        debugShowCheckedModeBanner: false,
        routes: {
          predictionRoute: (context) => Prediction(),
        },
      ),
    ),
  );
}
