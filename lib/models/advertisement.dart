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


  Advertisiment();

  Advertisiment.generateId(){
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference ads = db.collection("meus_anuncios");
    id = ads.doc().id;

    fotos = [];
  }

  Advertisiment.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    id = documentSnapshot.id;
    estado = documentSnapshot["estado"];
    categoria = documentSnapshot["categoria"];
    titulo = documentSnapshot["titulo"];
    preco = documentSnapshot["preco"];
    telefone = documentSnapshot["telefone"];
    descricao = documentSnapshot["descricao"];
    fotos = List<String>.from(documentSnapshot["fotos"]);
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "id" : id,
      "estado" : estado,
      "categoria" : categoria,
      "titulo" : titulo,
      "preco" : preco,
      "telefone" : telefone,
      "descricao" : descricao,
      "fotos" : fotos,
    };
    return map;
  }


}