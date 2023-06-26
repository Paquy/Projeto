import 'package:cloud_firestore/cloud_firestore.dart';

class Anuncio {
  late String id;
  late String estado;
  late String categoria;
  late String titulo;
  late String preco;
  late String telefone;
  late String descricao;
  late List<String> fotos;

  Anuncio.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    estado = documentSnapshot["estado"];
    categoria = documentSnapshot["categoria"];
    titulo = documentSnapshot["titulo"];
    preco = documentSnapshot["preco"];
    telefone = documentSnapshot["telefone"];
    descricao = documentSnapshot["descricao"];
    fotos = List<String>.from(documentSnapshot["fotos"]);
  }

  Anuncio.gerarId() {
    final db = FirebaseFirestore.instance;
    final anuncios = db.collection("meus_anuncios");
    id = anuncios.doc().id;
    categoria = ""; // Add the initialization of categoria here

    fotos = [];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "estado": estado,
      "categoria": categoria,
      "titulo": titulo,
      "preco": preco,
      "telefone": telefone,
      "descricao": descricao,
      "fotos": fotos,
    };
  }
}
