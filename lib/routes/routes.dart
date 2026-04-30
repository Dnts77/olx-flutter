import 'package:flutter/material.dart';
import 'package:olx_flutter/screens/ads_screen.dart';
import 'package:olx_flutter/screens/login_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;
    
    switch(settings.name){
      case "/":
        return MaterialPageRoute(
          builder: (_) => AdsScreen()
        );
      case "/login":
        return MaterialPageRoute(
          builder: (_) => LoginScreen()
        );
      default: 
        return _routeError();
    }
  }
  static Route<dynamic> _routeError(){
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text("Tela não encontrada"),
        ),
        body: Center(
          child: Text("Tela não encontrada"),
        ),
      )
    );
  }
}