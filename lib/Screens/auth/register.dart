import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../Provider/auth/auth_provider.dart';
import '../../Utils/message.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController namaController = TextEditingController();

  File? _profilePhoto;
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
        body: ListView(
      children: [
        Container(
            margin: EdgeInsets.only(top: 50),
            height: 200.0,
            child: Image.asset('assets/images/profil_dilakkkkk.jpg')),
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                "Silahkan Mendaftar",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 10.0)),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: namaController,
                    decoration: InputDecoration(
                      labelText: 'Nama',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.person,
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10.0)),
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
                  Padding(padding: EdgeInsets.only(top: 10.0)),
                  SizedBox(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            final picker = ImagePicker();
                            final pickedFile = await picker.getImage(
                                source: ImageSource.gallery);

                            if (pickedFile != null) {
                              setState(() {
                                _profilePhoto = File(pickedFile.path);
                              });
                            }
                          },
                          child: Text("Upload Foto Profil"),
                        ),
                        if (_profilePhoto != null)
                          SizedBox(
                            child: CircleAvatar(
                              radius:
                                  50, // Ubah nilai radius sesuai kebutuhan Anda
                              backgroundImage: FileImage(
                                _profilePhoto!,
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 10.0)),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        final String name = namaController.text.trim();
                        final String email = emailController.text.trim();
                        final String password = passwordController.text.trim();

                        if (_profilePhoto == null ||
                            email.isEmpty ||
                            password.isEmpty ||
                            name.isEmpty) {
                          errorMessage(context,
                              message:
                                  "Oops !! Mohon Lenkapi Formulir Pendaftaran Anda !!");
                          return;
                        }
                        try {
                          await authProvider.registerUserWithProfile(
                            email: email,
                            password: password,
                            name: name,
                            profilePhoto: _profilePhoto!,
                          );
                        } catch (e) {
                          errorMessage(context,
                              message: "Oops!! Daftar Gagal Mohon Coba Lagi");
                        }
                      },
                      child: Text("Daftar"),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 10.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Sudah Punya Akun ?"),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'login');
                        },
                        child: Text(
                          " Login",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        )
      ],
    ));
  }
}
