import 'dart:io';

import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import 'Components.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final formKey = GlobalKey<FormState>();
  final String emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  final String passwordPattern = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  inputField("Adresse email", "me@example.com", Icons.email,
                      emailController,
                      inputType: TextInputType.emailAddress,
                      typePass: false,
                      msgVide: "veuillez saisir votre adresse email",
                      validateur: emailPattern,
                      msgValide: "veuillez saisir une adresse email valide."),
                  inputField(
                      "Mot de passe", "****", Icons.lock, passwordController,
                      typePass: true,
                      msgVide: "veuillez saisir votre mot de passe",
                      validateur: passwordPattern,
                      msgValide:
                          "Minimum huit caractères, au moins une lettre et un chiffre"),
                  ElevatedButton(
                    child: Text("login"),
                    onPressed: () {
                      final snackBar;
                      formKey.currentState!.validate()
                          ? {
                              snackBar = snackbar(
                                  'success',
                                  'vos coordonnées sont correctes',
                                  ContentType.success),
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar),
                            }
                          : {
                              snackBar = snackbar(
                                  'erreur',
                                  'vos coordonées sont erronés',
                                  ContentType.failure),
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar)
                            };
                    },
                  ),
                ],
              ),
            )));
  }
}
