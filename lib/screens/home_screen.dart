import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool _signUp = false;

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
                TextField(
                  //controller: ,
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    fontSize: 20
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    hintText: "Email",
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6)
                    )
                  ),
                ),
                TextField(
                  //controller: ,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontSize: 20
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    hintText: "Senha",
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6)
                    )
                  ),
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

                  },
                  child: Text(
                    "Entrar",
                    style: TextStyle(
                      fontSize: 20
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