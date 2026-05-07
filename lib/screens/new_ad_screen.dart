import 'dart:io';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:olx_flutter/models/advertisement.dart';
import 'package:olx_flutter/widgets/customized_button.dart';
import 'package:olx_flutter/widgets/customized_text_field.dart';
import 'package:validadores/Validador.dart';


class NewAdScreen extends StatefulWidget {
  const NewAdScreen({super.key});

  @override
  State<NewAdScreen> createState() => _NewAdScreenState();
}

class _NewAdScreenState extends State<NewAdScreen> {

  final _formKey = GlobalKey<FormState>();
  final List<File> _imagesList = [];
  final List<DropdownMenuItem<String>> _statesDropList = [];
  final List<DropdownMenuItem<String>> _categoriesDropList = [];

  late Advertisiment _advertisement;

  String? _selectedStateItem;
  String? _selectedCategoryItem;

  Future<void> _selectGalleryImage() async{
    ImagePicker picker = ImagePicker();
    XFile? selectedImage = await picker.pickImage(source: ImageSource.gallery);
    
    if(selectedImage != null){
      setState(() {
        _imagesList.add(File(selectedImage.path));
      });
    }
  }

  void _loadDropdownItens(){
    //Estados
    for(var state in Estados.listaEstadosSigla){
      _statesDropList.add(
        DropdownMenuItem(
          value: state,
          child: Text(state),
        )
      );
    }

    //Categorias
    _categoriesDropList.add(
      DropdownMenuItem(
        value: "auto",
        child: Text("Automóvel"),
      )
    );
    _categoriesDropList.add(
      DropdownMenuItem(
        value: "imovel",
        child: Text("Imóvel"),
      )
    );
    _categoriesDropList.add(
      DropdownMenuItem(
        value: "eletro",
        child: Text("Eletrônicos"),
      )
    );
    _categoriesDropList.add(
      DropdownMenuItem(
        value: "moda",
        child: Text("Moda"),
      )
    );
    _categoriesDropList.add(
      DropdownMenuItem(
        value: "esportes",
        child: Text("Esportes"),
      )
    );
  }


  //Método para salvar anúncio
  Future<void> _saveAd() async{
    //Upload imagens
    await _uploadImages();
  }

  Future<void> _uploadImages() async{
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference root = storage.ref();

    for(var image in _imagesList){
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      
      Reference file = root.child("meus_anuncios").child(_advertisement.id).child(imageName);
      UploadTask uploadTask = file.putFile(image);
      
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete((){});
      
      String url = await taskSnapshot.ref.getDownloadURL();
      _advertisement.fotos.add(url);


    }
  }

  @override
  void initState() {
    super.initState();
    _loadDropdownItens();
    _advertisement = Advertisiment();

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
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: DropdownButtonFormField(
                          initialValue: _selectedStateItem,
                          hint: Text("Estados"),
                          onSaved: (estado) {
                            _advertisement.estado = estado!;
                          },
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20
                          ),
                          items: _statesDropList,
                          validator: (value){
                            return Validador().add(Validar.OBRIGATORIO, msg: "Campo obrigatório").valido(value);
                          },
                          onChanged: (value){
                            setState(() {
                              _selectedStateItem = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: DropdownButtonFormField(
                          initialValue: _selectedCategoryItem,
                          hint: Text("Categorias"),
                          onSaved: (categoria) {
                            _advertisement.categoria = categoria!;
                          },
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20
                          ),
                          items: _categoriesDropList,
                          validator: (value){
                            return Validador().add(Validar.OBRIGATORIO, msg: "Campo obrigatório").valido(value);
                          },
                          onChanged: (value){
                            setState(() {
                              _selectedCategoryItem = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                
                //Caixas de texto
                Padding(
                  padding: EdgeInsets.only(bottom: 15, top: 15),
                  child:  CustomizedTextField(
                    hint: "Título",
                    onSaved: (titulo){
                      _advertisement.titulo = titulo!;
                    },
                    validator: (value) {
                      return Validador().add(Validar.OBRIGATORIO, msg: "Campo obrigatório").valido(value);
                    }, 
                  ),
                ),
                
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child:  CustomizedTextField(
                    hint: "Preço",
                    onSaved: (preco) {
                      _advertisement.preco = preco!;
                    },
                    type: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      RealInputFormatter(moeda: true)
                    ],
                    validator: (value) {
                      return Validador().add(Validar.OBRIGATORIO, msg: "Campo obrigatório").valido(value);
                    },   
                  ),
                ),
                
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child:  CustomizedTextField(
                    hint: "Telefone",
                    type: TextInputType.phone,
                    onSaved: (telefone) {
                      _advertisement.telefone = telefone!;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter()
                    ],
                    validator: (value) {
                      return Validador().add(Validar.OBRIGATORIO, msg: "Campo obrigatório").valido(value);
                    }, 
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child:  CustomizedTextField(
                    hint: "Descrição (200 caracteres)",
                    onSaved: (descricao) {
                      _advertisement.descricao = descricao!;
                    },
                    maxLines: null,
                    validator: (value) {
                      return Validador().add(Validar.OBRIGATORIO, msg: "Campo obrigatório").maxLength(200, msg: "Máximo de 200 caracteres").valido(value);
                    }, 
                  ),
                ),
                
                
                CustomizedButton(
                  text: "Cadastrar Anúncio",
                  onPressed: () {
                    if( _formKey.currentState!.validate() ){
                      //salvando campos
                      _formKey.currentState!.save();
                      //salvando anúncio
                      _saveAd();
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