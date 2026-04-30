import 'package:flutter/material.dart';
import 'package:olx_flutter/models/user_model.dart';
import 'package:olx_flutter/utils/constants.dart';
import 'package:olx_flutter/widgets/customized_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _signUp = false;
  String _errorMessage = "";
  String _buttonText = "Entrar";

  //Cadastrar
  void _signUpUser(UserModel user){
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.createUserWithEmailAndPassword(
      email: user.email,
      password: user.senha
    ).then((firebaseUser){
      if(mounted){
        Constants.goToAds(context);
      }
    });
  }

  //Logar
  void _logInUser(UserModel user){
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signInWithEmailAndPassword(
      email: user.email,
      password: user.senha
    ).then((firebaseUser){
      if(mounted){
        Constants.goToAds(context);
      }
    });
  }

  //Validando os campos
  void _validateFields(){
    String email = _emailController.text;
    String password = _passwordController.text;
    if(email.isEmpty || password.isEmpty){
      setState(() {
        _errorMessage = "Preencha todos os campos!";
      });
    }
    else if(email.isNotEmpty && email.contains("@")){
      if(password.isNotEmpty && password.length > 6){

        UserModel user = UserModel();
        user.email = email;
        user.senha = password;

        if(_signUp){
          _signUpUser(user);
        }else{
          _logInUser(user);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                    "assets/imgs/logo.png",
                    width: 200,
                    height: 150,
                  ),
                ),
                CustomizedTextField(
                  controller: _emailController,
                  hint: "Email",
                  autofocus: true,
                  type: TextInputType.emailAddress,
                ),
                CustomizedTextField(
                  controller: _passwordController,
                  hint: "Senha",
                  type: TextInputType.text,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Logar"),
                    Switch(
                      value: _signUp,
                      onChanged: (bool value){
                        setState(() {
                          _signUp = value;
                          _buttonText = "Entrar";
                          if(_signUp){
                            _buttonText = "Cadastrar";
                          }
                        });
                      },
                    ),
                    Text("Cadastrar"),
                  ],
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                    backgroundColor: WidgetStatePropertyAll(Color(0xff9c27b0)),
                    padding: WidgetStatePropertyAll(
                      EdgeInsets.fromLTRB(32, 16, 32, 16)
                    )
                  ),
                  onPressed: (){
                    _validateFields();
                  },
                  child: Text(
                    _buttonText,
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.only(top: 20),
                  child: Text(
                    _errorMessage,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}