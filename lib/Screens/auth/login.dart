import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../Provider/auth/auth_provider.dart';
import '../../Utils/message.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(padding: EdgeInsets.only(top: 30.0)),
          SizedBox(
            height: 200.0,
            child: Image.asset("assets/images/login_dilakkkkk.jpg"),
          ),
          Column(
            children: [
              Text("Silahkan Login"),
              Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.email,
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.key,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                    onPressed: () async {
                      try {
                        await AuthProvider()
                            .signWithEmailAndPassword(
                                emailController.text, passwordController.text)
                            .then((value) {
                          return value.user!.uid;
                        });

                        Navigator.pushNamed(context, 'mainScreen');
                      } catch (error) {
                        print(error);
                        errorMessage(context,
                            message:
                                "Login Error Mohon Cek kembali credential anda");
                      }
                    },
                    child: Text("Masuk")),
              ),
              Padding(padding: EdgeInsets.only(bottom: 10.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Belum Punya Akun ?"),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'register');
                    },
                    child: Text(
                      " Register",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
