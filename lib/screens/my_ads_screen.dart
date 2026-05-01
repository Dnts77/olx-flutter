import 'package:flutter/material.dart';
import 'package:olx_flutter/utils/constants.dart';


class MyAdsScreen extends StatefulWidget {
  const MyAdsScreen({super.key});

  @override
  State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  @override
  Widget build(BuildContext context) {
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
      body: Container(),
    );
  }
}