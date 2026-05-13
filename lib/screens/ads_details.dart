import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:olx_flutter/models/advertisement.dart';
import 'package:url_launcher/url_launcher.dart';

class AdsDetails extends StatefulWidget {
  const AdsDetails({this.advertisement, super.key});

  final Advertisement? advertisement;

  @override
  State<AdsDetails> createState() => _AdsDetailsState();
}

class _AdsDetailsState extends State<AdsDetails> {

  late Advertisement _advertisiment;

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

  //Ligando ao telefone
  Future<void> _callPhone(String phoneNumber) async{
    if(await canLaunchUrl(Uri.parse("tel:$phoneNumber"))){
      await launchUrl(Uri.parse("tel:$phoneNumber"));
    }else{
      print("Não foi possível fazer a ligação");
    }
  }

  @override
  void initState() {
    super.initState();
    _advertisiment = widget.advertisement!;
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
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _advertisiment.preco,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff9c27b0)
                      ),
                    ),
                    
                    Text(
                      _advertisiment.titulo,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(),
                    ),
                    
                    Text(
                      "Descrição",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    
                    Text(
                      _advertisiment.descricao,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(),
                    ),
                    
                    Text(
                      "Contato",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    
                    Padding(
                      padding: EdgeInsets.only(bottom: 66),
                      child: Text(
                        _advertisiment.telefone,
                        style: TextStyle(fontSize: 18),
                      ),
                    )




                  ],
                ),
              )
            ],
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 50,
            child: GestureDetector(
              onTap: () {
                _callPhone(_advertisiment.telefone);
              },
              child: Container(
                padding: EdgeInsets.all(16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xff9c27b0),
                  borderRadius: BorderRadius.circular(30)
                ),
                child: Text(
                  "Ligar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}