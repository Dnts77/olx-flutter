import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:olx_flutter/models/advertisement.dart';
import 'package:olx_flutter/utils/constants.dart';
import 'package:olx_flutter/widgets/ad_item.dart';


class MyAdsScreen extends StatefulWidget {
  const MyAdsScreen({super.key});

  @override
  State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {


  final _controller = StreamController<QuerySnapshot>.broadcast();
  late final String _loggedUserId;

  Future<void> _recoverLoggedUser() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User loggedUser = auth.currentUser!;
    _loggedUserId = loggedUser.uid;
  }


  Future<Stream<QuerySnapshot>> _addAdsListener() async{
    await _recoverLoggedUser();
    FirebaseFirestore db = FirebaseFirestore.instance;
    Stream<QuerySnapshot> stream = db.collection("meus_anuncios").doc(_loggedUserId).collection("anuncios").snapshots();
    stream.listen((dados){
      _controller.add(dados);
    });
    return stream;
  }

  Future<void> _removeAdd(String adId) async{
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("meus_anuncios").doc(_loggedUserId).collection("anuncios").doc(adId).delete().then((_){
      db.collection("anuncios").doc(adId).delete();
    });
  }

  @override
  void initState() {
    super.initState();
    _addAdsListener();
  }



  @override
  Widget build(BuildContext context) {

    var loadingData = Center(
      child: Column(
        children: [
          Text("Carregando anúncios..."),
          CircularProgressIndicator()
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Meus anúncios"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Constants.goToNewAd(context);
        },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: _controller.stream,
        builder:(context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.none:

            case ConnectionState.waiting:
              return loadingData;
            case ConnectionState.active:
            case ConnectionState.done:
              //Mensagem de erro
              if(snapshot.hasError){
                return Text("Erro ao carregar anúncios");
              }
              QuerySnapshot querySnapshot = snapshot.data!;
              return ListView.builder(
                itemCount: querySnapshot.docs.length,
                itemBuilder: (context, index) {
                  List<DocumentSnapshot> ads = querySnapshot.docs.toList();
                  DocumentSnapshot documentSnapshot = ads[index];
                  Advertisiment advertisiment = Advertisiment.fromDocumentSnapshot(documentSnapshot);
                  return AdItem(
                    advertisiment: advertisiment,
                    onPressedDelete: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Confirmar"),
                            content: Text("Deseja realmente excluir o anúncio?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop,
                                child: Text(
                                  "Cancelar",
                                  style: TextStyle(
                                    color: Colors.white
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  _removeAdd(advertisiment.id);
                                  Navigator.of(context).pop;
                                },
                                child: Text(
                                  "Remover",
                                  style: TextStyle(
                                    color: Colors.red
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              );

          }
          
        },
      ),
    );
  }
}