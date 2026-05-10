import 'package:flutter/material.dart';
import 'package:olx_flutter/models/advertisement.dart';

class AdItem extends StatelessWidget {
  const AdItem({required this.advertisiment, this.onTapItem, this.onPressedDelete, super.key});

  final Advertisiment advertisiment;
  final VoidCallback? onTapItem;
  final VoidCallback? onPressedDelete;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapItem,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              //Imagem
              SizedBox(
                width: 120,
                height: 120,
                child: Container(
                  color: Colors.grey[500], 
                  child: Center(
                    child: Text(
                      "Imagem", 
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  ),
                ) //Image.network(advertisiment.fotos[0], fit: BoxFit.cover),
              ),
              //Título e preço
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        advertisiment.titulo,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text("R\$ ${advertisiment.preco}"),
                    ],
                  ),
                ),
              ),
              if(onPressedDelete != null) Expanded(
                flex: 1,
                child: TextButton(
                  onPressed: onPressedDelete,
                  style: ButtonStyle(
                    padding: WidgetStatePropertyAll(
                      EdgeInsets.all(10)
                    ),
                    backgroundColor: WidgetStatePropertyAll(Colors.red)
                  ),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
              )

            ],
          ),
        ),
      )
    );
  }
}