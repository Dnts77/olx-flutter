import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:olx_flutter/models/advertisement.dart';

class AdsDetails extends StatefulWidget {
  const AdsDetails({this.advertisiment, super.key});

  final Advertisiment? advertisiment;

  @override
  State<AdsDetails> createState() => _AdsDetailsState();
}

class _AdsDetailsState extends State<AdsDetails> {

  late Advertisiment _advertisiment;

  List<Widget> _getImagesList(){
    List<String> urlImagesList = _advertisiment.fotos;
    return urlImagesList.map((url){
      return Container(
        height: 250,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.fitWidth
          )
        ),
      );
    }).toList() ;
  }

  @override
  void initState() {
    super.initState();
    _advertisiment = widget.advertisiment!;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anúncio"),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              SizedBox(
                height: 250,
                child: CarouselSlider(
                  items: _getImagesList(),
                  options: CarouselOptions(
                    autoPlay: false,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}