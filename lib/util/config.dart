import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';

class Configuracoes {
  static List<DropdownMenuItem<String>> getEstados() {
    List<DropdownMenuItem<String>> listaItensDropEstados = [];

    //Categorias
    listaItensDropEstados.add(const DropdownMenuItem(
      value: null,
      child: Text(
        "Região",
        style: TextStyle(color: Color(0xff9c27b0)),
      ),
    ));

    for (var estado in Estados.listaEstadosSigla) {
      listaItensDropEstados.add(DropdownMenuItem(
        value: estado,
        child: Text(estado),
      ));
    }

    return listaItensDropEstados;
  }

  static List<DropdownMenuItem<String>> getCategorias() {
    List<DropdownMenuItem<String>> itensDropCategorias = [];

    //Categorias
    itensDropCategorias.add(const DropdownMenuItem(
      value: null,
      child: Text(
        "Categoria",
        style: TextStyle(color: Color(0xff9c27b0)),
      ),
    ));

    itensDropCategorias.add(const DropdownMenuItem(
      value: "auto",
      child: Text("Automóvel"),
    ));

    itensDropCategorias.add(const DropdownMenuItem(
      value: "imovel",
      child: Text("Imóvel"),
    ));

    itensDropCategorias.add(const DropdownMenuItem(
      value: "eletro",
      child: Text("Eletrônicos"),
    ));

    itensDropCategorias.add(const DropdownMenuItem(
      value: "moda",
      child: Text("Moda"),
    ));

    itensDropCategorias.add(const DropdownMenuItem(
      value: "esportes",
      child: Text("Esportes"),
    ));

    return itensDropCategorias;
  }
}
