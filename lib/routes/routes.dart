import 'package:flutter/material.dart';
import 'package:olx_flutter/models/advertisement.dart';
import 'package:olx_flutter/screens/ads_details.dart';
import 'package:olx_flutter/screens/ads_screen.dart';
import 'package:olx_flutter/screens/login_screen.dart';
import 'package:olx_flutter/screens/my_ads_screen.dart';
import 'package:olx_flutter/screens/new_ad_screen.dart';

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
      case "/my-ads":
        return MaterialPageRoute(
          builder: (_) => MyAdsScreen()
        );
      case "/new-ad":
        return MaterialPageRoute(
          builder: (_) => NewAdScreen()
        );
      case "/ad-detail":
        return MaterialPageRoute(
          builder: (_) => AdsDetails(advertisiment: args as Advertisiment?)
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