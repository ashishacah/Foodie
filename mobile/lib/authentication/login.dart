import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/Dashboard/Client.dart';
import 'package:mobile/Dashboard/customer.dart';
import 'package:mobile/Dashboard/delivery_client.dart';
import 'package:mobile/authentication/tokenstorage.dart';
import 'package:mobile/design/button.dart';
import 'package:mobile/design/decoration.dart';
import 'dart:convert';

import 'package:mobile/main.dart';
import 'package:mobile/Dashboard/Admin.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var emailcon = TextEditingController();

  var passcon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "login..",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          decoration: containerDecoration(),
          height: 1200,
          width: 500,
          child: Padding(
            padding: const EdgeInsets.only(top: 200, left: 20),
            child: Column(
              spacing: 80,
              children: [
                Text(
                  "Welcome For Login",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: const Color.fromARGB(255, 192, 232, 31),
                  ),
                ),
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        FieldDesign(
                          conname: emailcon,
                          hint: "email",
                          icon: Icon(Icons.email),
                        ),
                        SizedBox(height: 30),
                        FieldDesign(
                          conname: passcon,
                          hint: "password",
                          icon: Icon(Icons.password),
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () async {
                            await senddata();
                          },
                          child: Text("Login"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
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
    final url = "http://10.0.2.2:8000/api/login/";
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": emailcon.text, "password": passcon.text}),
    );
    print("LOGIN RESPONSE:");
    print(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String role = data["role"];
      await Tokenstorage.saveTokens(
        access: data["access"],
        refresh: data['refresh'],
      );
      if (role == "Admin") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminDashboard()),
        );
      } else if (role == "Client") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ClientDashboard()),
        );
      } else if (role == "Delivery_Partner") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Delivery_Patner()),
        );
      } else if (role == "Customer") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CustomerDashboard()),
        );
      }
    } else {
      setState(() {
        final data = jsonDecode(response.body);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar((SnackBar(content: Text(data["message"]))));
      });
    }
  }
}
