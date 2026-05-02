import 'package:flutter/material.dart';
import 'package:olx_flutter/widgets/customized_button.dart';


class NewAdScreen extends StatefulWidget {
  const NewAdScreen({super.key});

  @override
  State<NewAdScreen> createState() => _NewAdScreenState();
}

class _NewAdScreenState extends State<NewAdScreen> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novo anúncio"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //Imagens
                /*FormField(
                  builder: (field) {
                    throw '';
                  },
                ),*/

                //Dropdown
                Row(
                  children: [
                    Text("Estado"),
                    Text("Categoria"),
                  ],
                ),
                
                //Caixas de texto
                Text("Caixas de texto"),
                CustomizedButton(
                  text: "Cadastrar Anúncio",
                  onPressed: () {
                    if( _formKey.currentState!.validate() ){
                      
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}