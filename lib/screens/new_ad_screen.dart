import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:olx_flutter/widgets/customized_button.dart';


class NewAdScreen extends StatefulWidget {
  const NewAdScreen({super.key});

  @override
  State<NewAdScreen> createState() => _NewAdScreenState();
}

class _NewAdScreenState extends State<NewAdScreen> {

  final _formKey = GlobalKey<FormState>();
  final List<File> _imagesList = [];

  Future<void> _selectGalleryImage() async{
    ImagePicker picker = ImagePicker();
    XFile? selectedImage = await picker.pickImage(source: ImageSource.gallery);
    
    if(selectedImage != null){
      setState(() {
        _imagesList.add(File(selectedImage.path));
      });
    }
  }

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
                FormField<List>(
                  initialValue: _imagesList,
                  validator: (images){
                    if(images!.isEmpty){
                      return "Necessário selecionar uma imagem!";
                    }
                    return null;
                  },
                  builder: (field) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _imagesList.length + 1, //0
                            itemBuilder: (context, index){
                              if(index == _imagesList.length){
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: GestureDetector(
                                    onTap: (){
                                      _selectGalleryImage();
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey[400],
                                      radius: 50,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add_a_photo,
                                            size: 40,
                                            color: Colors.grey[100],
                                          ),
                                          Text(
                                            "Adicionar",
                                            style: TextStyle(color: Colors.grey[100]),
                                          )
                                        ],
                                      ), 
                                    ),
                                  ),
                                );
                              }
                              if(_imagesList.isNotEmpty){
                                return Padding(
                                  padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
                                  child: GestureDetector(
                                    onTap: (){
                                      showDialog(
                                        context: context,
                                        builder: (context) => Dialog(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.file(_imagesList[index]),
                                              TextButton(
                                                onPressed: (){
                                                  setState(() {
                                                    _imagesList.removeAt(index);
                                                    Navigator.of(context).pop();
                                                  });
                                                },
                                                child: Text(
                                                  "Excluir",
                                                  style: TextStyle(color: Colors.red),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      );
                                    },
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: FileImage(_imagesList[index]),
                                      child: Container(
                                        color: Color.fromRGBO(255, 255, 255, 0.4),
                                        alignment: Alignment.center,
                                        child: Icon(Icons.delete, color: Colors.red,),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return Container();
                            },
                          ),
                        ),
                        if(field.hasError)
                          Container(
                            padding: EdgeInsets.all(2),
                            child: Text(
                              "${field.errorText}",
                              style: TextStyle(color: Colors.red, fontSize: 14),
                            ),
                          )
                      ],
                    );
                  },
                ),

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