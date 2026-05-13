import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:olx_flutter/models/advertisement.dart';
import 'package:olx_flutter/utils/configs.dart';
import 'package:olx_flutter/utils/constants.dart';
import 'package:olx_flutter/widgets/ad_item.dart';

class AdsScreen extends StatefulWidget {
  const AdsScreen({super.key});

  @override
  State<AdsScreen> createState() => _AdsScreenState();
}

class _AdsScreenState extends State<AdsScreen> {

  List<String> _menuItens = [];
  String? _stateSelectedItem;
  String? _categorySelectedItem;

  final _streamController = StreamController<QuerySnapshot>.broadcast();

  List<DropdownMenuItem<String>> _statesDropList = [];
  List<DropdownMenuItem<String>> _categoriesDropList = [];


  //Escolha dos itens
  Future <void> _menuItemSelection(String selectedItem) async{
    switch(selectedItem){
      case "Meus anúncios":
        return await Constants.goToMyAds(context);
      case "Entrar / Cadastrar":
        return await Constants.goToLogin(context);
      case "Deslogar":
        return _userSignOut();
    }
  }

  //Deslogando usuário
  Future<void> _userSignOut() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signOut();
    Constants.goToLogin(context);
  }

  //Verificando usuário logado
  Future<void> _checkLoggedUser() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? loggedUser = auth.currentUser;

    if(loggedUser == null){
      _menuItens = [
        "Entrar / Cadastrar"
      ];
    }
    else{
      _menuItens = [
        "Meus anúncios",
        "Deslogar"
      ];
    }
  }

  void _loadDropdownItens(){
    //Estados
    _statesDropList = Configs.getStates();

    //Categorias
    _categoriesDropList = Configs.getCategories();
  }

  Future<Stream<QuerySnapshot>> _addAdvertisementListener() async{
    FirebaseFirestore db = FirebaseFirestore.instance;
    Stream<QuerySnapshot> stream = db.collection("anuncios").snapshots();

    stream.listen((dados){
      _streamController.add(dados);
    });
    return stream;
  }
  
  Future<Stream<QuerySnapshot>> _filterAds() async{
    FirebaseFirestore db = FirebaseFirestore.instance;
    Query query = db.collection("anuncios");
    

    if(_stateSelectedItem != null){
      query.where("estado", isEqualTo: _stateSelectedItem);
    }
    if(_categorySelectedItem != null){
      query.where("categoria", isEqualTo: _categorySelectedItem);
    }
    
    Stream<QuerySnapshot> stream = query.snapshots();

    stream.listen((dados){
      _streamController.add(dados);
    });
    return stream;
  }

  @override
  void initState() {
    super.initState();
    _loadDropdownItens();
    _checkLoggedUser();
    _addAdvertisementListener();
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
        title: Text("OLX"),
        elevation: 3,
        actions: [
          PopupMenuButton<String>(
            onSelected: _menuItemSelection,
            itemBuilder: (context){
              return _menuItens.map((String item){
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(2),
        child: Column(
          children: [
            //Filtros
            Row(
              children: [
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: Center(
                      child: DropdownButton(
                        items: _statesDropList,
                        iconEnabledColor: Color(0xff9c27b0),
                        value: _stateSelectedItem,
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black
                        ),
                        onChanged: (state) {
                          setState(() {
                            _stateSelectedItem = state;
                            _filterAds();
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
                        items: _categoriesDropList,
                        iconEnabledColor: Color(0xff9c27b0),
                        value: _categorySelectedItem,
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black
                        ),
                        onChanged: (category) {
                          setState(() {
                            _categorySelectedItem = category;
                            _filterAds();
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            StreamBuilder(
              stream: _streamController.stream,
              builder: (context, snapshot) {
                switch(snapshot.connectionState){
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return loadingData;
                  case ConnectionState.active:
                  case ConnectionState.done:
                    QuerySnapshot? querySnapshot = snapshot.data;
                    if(querySnapshot == null){
                      return Container();
                    }
                    if(querySnapshot.docs.isEmpty){
                      return Container(
                        padding: EdgeInsets.all(25),
                        child: Text("Nenhum anúncio", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      );
                    }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: querySnapshot.docs.length,
                      itemBuilder: (context, index) {
                        List<DocumentSnapshot> ads = querySnapshot.docs.toList();
                        DocumentSnapshot documentSnapshot = ads[index];
                        Advertisement advertisiment = Advertisement.fromDocumentSnapshot(documentSnapshot);

                        return AdItem(
                          advertisiment: advertisiment,
                          onTapItem: () {
                            Constants.goAdsDetails(context, advertisiment);
                          },
                        );
                      },
                    ),
                  );
                }
                
              },
            )
          ],
        ),
      ),
      
    );
  }
}