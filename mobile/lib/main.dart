import 'package:flutter/material.dart';
import 'package:mobile/authentication/login.dart';
import 'package:mobile/design/button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Login(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var usernamecon = TextEditingController();
  var emailcon = TextEditingController();
  var passwordcon = TextEditingController();
  var phonenumbercon = TextEditingController();
  var addresscon = TextEditingController();
  var profilecon = TextEditingController();
  var role_con = TextEditingController();
  String responsemsg = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("FoodTest"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink, Colors.purpleAccent, Colors.blueGrey],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                Text(
                  "Welcome For The Taste",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 50),
                Card(
                  elevation: 3,
                  child: Center(
                    child: Column(
                      children: [
                        FieldDesign(conname: usernamecon, hint: "username"),
                        FieldDesign(conname: emailcon, hint: "email"),
                        FieldDesign(conname: passwordcon, hint: "password"),
                        FieldDesign(conname: role_con, hint: "role"),
                        FieldDesign(
                          conname: phonenumbercon,
                          hint: "phonenumber",
                        ),
                        FieldDesign(conname: addresscon, hint: "address"),
                        FieldDesign(conname: profilecon, hint: "profile_photo"),
                        ElevatedButton(
                          onPressed: () {
                            // final username = usernamecon.text.toString();
                            // final email = emailcon.text.toString();
                            // final password = passwordcon.text.toString();
                            // final phonenumber = phonenumbercon.text.toString();
                            // final address = addresscon.text.toString();
                            // final profile = profilecon.text.toString();

                            senddata();
                          },
                          child: Text("Sign Up"),
                        ),

                        Text(
                          responsemsg,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> senddata() async {
    const url = "http://10.0.2.2:8000/api/signup/";
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": usernamecon.text,
        "email": emailcon.text,
        "password": passwordcon.text,
        "role": role_con.text,
        "phonenumber": phonenumbercon.text,
        "address": addresscon.text,
        "profile_image": profilecon.text,
      }),
    );
    final data = jsonDecode(response.body);
    setState(() {
      responsemsg = data["message"];
    });
  }
}
