import 'package:flutter/material.dart';
import '../model/anuncio.dart';
import '../view/anuncios.dart';
import '../view/detail_announcement.dart';
import '../view/login_page.dart';
import '../view/my_announcement.dart';
import '../view/new_announcement.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => const Anuncios());
      case "/login":
        return MaterialPageRoute(builder: (_) => const Login());
      case "/meus-anuncios":
        return MaterialPageRoute(builder: (_) => const MeusAnuncios());
      case "/novo-anuncio":
        return MaterialPageRoute(builder: (_) => const NovoAnuncio());
      case "/detalhes-anuncio":
        return MaterialPageRoute(
            builder: (_) => DetalhesAnuncio(args as Anuncio));
      default:
        throw Exception("Route not found: ${settings.name}");
    }
  }

}
