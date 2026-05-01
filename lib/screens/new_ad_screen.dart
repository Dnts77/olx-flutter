import 'package:flutter/material.dart';


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
              children: [
                //Imagens
                //Dropdown
                //Caixas de texto
              ],
            ),
          ),
        ),
      ),
    );
  }
}