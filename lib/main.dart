import 'package:flutter/material.dart';
import 'routes/route_generator.dart';
import 'view/anuncios.dart';

final temaPadrao = ThemeData(
  primaryColor: const Color(0xff9c27b0),
  hintColor: const Color(0xff7b1fa2)
);

void main() => runApp(MaterialApp(
  title: "OLX",
  home: const Anuncios(),
  theme: temaPadrao,
  initialRoute: "/",
  onGenerateRoute: RouteGenerator.generateRoute,
  debugShowCheckedModeBanner: false,
));

