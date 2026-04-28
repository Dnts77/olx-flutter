class UserModel {
  late String _idUsuario;
  late String nome;
  late String email;
  late String senha;

  UserModel();

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "idUsuario" : _idUsuario,
      "nome" : nome,
      "email" : email,
      "senha" : senha,
    };
    return map;
  }
}