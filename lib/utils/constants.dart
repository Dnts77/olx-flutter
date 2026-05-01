import 'package:flutter/material.dart';

class Constants {
  //MÉTODOS STATIC PARA NAVEGAÇÃO
  static Future<void> goToLogin(BuildContext context){
    return Navigator.pushReplacementNamed(context, "/login");
  }
  
  static Future<void> goToAds(BuildContext context){
    return Navigator.pushReplacementNamed(context, "/");
  }
  
  static Future<void> goToMyAds(BuildContext context){
    return Navigator.pushNamed(context, "/my-ads");
  }
  
  static Future<void> goToNewAd(BuildContext context){
    return Navigator.pushNamed(context, "/new-ad");
  }

}