import 'package:flutter/material.dart';

class BotaoCustomizado extends StatelessWidget {
  final String texto;
  final Color corTexto;
  final VoidCallback onPressed;

  BotaoCustomizado({
    required this.texto,
    this.corTexto = Colors.white,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
        primary: Color(0xff9c27b0),
      ),
      onPressed: onPressed,
      child: Text(
        texto,
        style: TextStyle(
          color: corTexto,
          fontSize: 20,
        ),
      ),
    );
  }
}
