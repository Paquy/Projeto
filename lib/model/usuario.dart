class Usuario {
  late String email;
  late int idUsuario;
  late String nome;
  late String senha;

  Usuario();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "idUsuario": idUsuario,
      "nome": nome,
      "email": email,
    };

    return map;
  }
}
