import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';

class Configs {
  static List<DropdownMenuItem<String>> getCategories(){
    List<DropdownMenuItem<String>> categoriesDropItens = [];
    
    categoriesDropItens.add(
      DropdownMenuItem(
        value: null,
        child: Text("Categoria", style: TextStyle(color: Color(0xff9c27b0)),),
      )
    );
    categoriesDropItens.add(
      DropdownMenuItem(
        value: "auto",
        child: Text("Automóvel"),
      )
    );
    categoriesDropItens.add(
      DropdownMenuItem(
        value: "imovel",
        child: Text("Imóvel"),
      )
    );
    categoriesDropItens.add(
      DropdownMenuItem(
        value: "eletro",
        child: Text("Eletrônicos"),
      )
    );
    categoriesDropItens.add(
      DropdownMenuItem(
        value: "moda",
        child: Text("Moda"),
      )
    );
    categoriesDropItens.add(
      DropdownMenuItem(
        value: "esportes",
        child: Text("Esportes"),
      )
    );
    return categoriesDropItens;
  }
  
  static List<DropdownMenuItem<String>> getStates(){
    List<DropdownMenuItem<String>> statesDropList = [];
    
    statesDropList.add(
      DropdownMenuItem(
        value: null,
        child: Text("Região", style: TextStyle(color: Color(0xff9c27b0)),),
      )
    );
    for(var state in Estados.listaEstadosSigla){
      statesDropList.add(
        DropdownMenuItem(
          value: state,
          child: Text(state),
        )
      );
    }
    
    return statesDropList;
  }
}
