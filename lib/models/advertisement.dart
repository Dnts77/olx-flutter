import 'package:cloud_firestore/cloud_firestore.dart';

class Advertisiment {
  late String id;
  late String estado;
  late String categoria;
  late String titulo;
  late String preco;
  late String telefone;
  late String descricao;
  late List<String> fotos;

  Advertisiment(){
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference ads = db.collection("meus_anuncios");
    id = ads.doc().id;

    fotos = [];
  }


}