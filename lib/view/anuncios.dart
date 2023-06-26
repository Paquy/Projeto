import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../main.dart';
import '../model/anuncio.dart';
import '../util/config.dart';
import '../widgets/item_announcement.dart';

class Anuncios extends StatefulWidget {
  const Anuncios({Key? key}) : super(key: key);

  @override
  _AnunciosState createState() => _AnunciosState();
}

class _AnunciosState extends State<Anuncios> {
  List<String> itensMenu = [];
  late List<DropdownMenuItem<String>> _listaItensDropCategorias;
  late List<DropdownMenuItem<String>> _listaItensDropEstados;

  final _controller = StreamController<QuerySnapshot>.broadcast();

  late String _itemSelecionadoEstado = "";
  late String _itemSelecionadoCategoria;

  void _escolhaMenuItem(String itemEscolhido) {
    switch (itemEscolhido) {
      case "Meus anúncios":
        Navigator.pushNamed(context, "/meus-anuncios");
        break;
      case "Entrar / Cadastrar":
        Navigator.pushNamed(context, "/login");
        break;
      case "Deslogar":
        _deslogarUsuario();
        break;
    }
  }

  Future<void> _deslogarUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushNamed(context, "/login");
  }

  Future<void> _verificarUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? usuarioLogado = auth.currentUser;

    if (usuarioLogado == null) {
      setState(() {
        itensMenu = ["Entrar / Cadastrar"];
      });
    } else {
      setState(() {
        itensMenu = ["Meus anúncios", "Deslogar"];
      });
    }
  }

  void _carregarItensDropdown() {
    _listaItensDropCategorias = Configuracoes.getCategorias();
    _listaItensDropEstados = Configuracoes.getEstados();
  }

  Future<Stream<QuerySnapshot>> _adicionarListenerAnuncios() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    Stream<QuerySnapshot> stream = db.collection("anuncios").snapshots();
    stream.listen((dados) {
      _controller.add(dados);
    });

    return stream;
  }

  Future<Stream<QuerySnapshot>> _filtrarAnuncios() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    Query query = db.collection("anuncios");
    query = query.where("estado", isEqualTo: _itemSelecionadoEstado);
    query = query.where("categoria", isEqualTo: _itemSelecionadoCategoria);

    Stream<QuerySnapshot> stream = query.snapshots();
    stream.listen((dados) {
      _controller.add(dados);
    });

    return stream;
  }

  @override
  void initState() {
    super.initState();

    _carregarItensDropdown();
    _verificarUsuarioLogado();
    _adicionarListenerAnuncios();
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var carregandoDados = const Center(
      child: Column(
        children: <Widget>[
          Text("Carregando anúncios"),
          CircularProgressIndicator(),
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("OLX"),
        elevation: 0,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _escolhaMenuItem,
            itemBuilder: (context) {
              return itensMenu.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: Center(
                    child: DropdownButton(
                      iconEnabledColor: temaPadrao.primaryColor,
                      value: _itemSelecionadoEstado,
                      items: _listaItensDropEstados,
                      style: const TextStyle(fontSize: 22, color: Colors.black),
                      onChanged: (estado) {
                        setState(() {
                          _itemSelecionadoEstado = estado!;
                          _filtrarAnuncios();
                        });
                      },
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.grey[200],
                width: 2,
                height: 60,
              ),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: Center(
                    child: DropdownButton(
                      iconEnabledColor: const Color(0xff9c27b0),
                      value: _itemSelecionadoCategoria,
                      items: _listaItensDropCategorias,
                      style: const TextStyle(fontSize: 22, color: Colors.black),
                      onChanged: (categoria) {
                        setState(() {
                          _itemSelecionadoCategoria = categoria!;
                          _filtrarAnuncios();
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          StreamBuilder(
            stream: _controller.stream,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return carregandoDados;
                case ConnectionState.active:
                case ConnectionState.done:
                  QuerySnapshot? querySnapshot =
                      snapshot.data as QuerySnapshot?;

                  if (querySnapshot != null && querySnapshot.docs.isEmpty) {
                    return Container(
                      padding: const EdgeInsets.all(25),
                      child: const Text(
                        "Nenhum anúncio! :( ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: querySnapshot!.docs.length,
                      itemBuilder: (_, indice) {
                        List<DocumentSnapshot> anuncios =
                            querySnapshot.docs.toList();
                        DocumentSnapshot documentSnapshot = anuncios[indice];
                        Anuncio anuncio =
                            Anuncio.fromDocumentSnapshot(documentSnapshot);

                        return ItemAnuncio(
                          anuncio: anuncio,
                          onTapItem: () {
                            Navigator.pushNamed(context, "/detalhes-anuncio",
                                arguments: anuncio);
                          },
                          onPressedRemover: () {},
                        );
                      },
                    ),
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}
