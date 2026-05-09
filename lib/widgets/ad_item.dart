import 'package:flutter/material.dart';

class AdItem extends StatelessWidget {
  const AdItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              //Imagem
              SizedBox(
                width: 120,
                height: 120,
                child: Container(color: Colors.orange),
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
                        "Console Nintendo 64",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text("R\$ 1.200,80"),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: TextButton(
                  onPressed: () {
                    
                  },
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