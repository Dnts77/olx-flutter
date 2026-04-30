import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:olx_flutter/utils/constants.dart';

class AdsScreen extends StatefulWidget {
  const AdsScreen({super.key});

  @override
  State<AdsScreen> createState() => _AdsScreenState();
}

class _AdsScreenState extends State<AdsScreen> {

  List<String> _menuItens = [];


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

  @override
  void initState() {
    super.initState();
    _checkLoggedUser();
  }


  @override
  Widget build(BuildContext context) {
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
        child: Text("Anúncios"),
      ),
      
    );
  }
}