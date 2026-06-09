import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class AddUserPage extends StatefulWidget {
const AddUserPage({super.key});
@override
State<AddUserPage> createState() => _AddUserPageState();
}
class _AddUserPageState extends State<AddUserPage> {
  final username = TextEditingController();
final email = TextEditingController();
final password = TextEditingController();
Future<void> saveUser() async {
final response = await http.post(
Uri.parse(
"http://localhost/flutter_api/user/add_user.php",
),
body: {
"username": username.text,
"email": email.text,
"password": password.text,
},
);
print(response.body);
final data = jsonDecode(response.body);
if (data["status"] == true) {
Navigator.pop(
context,
"Data user berhasil disimpan",
);
} else {
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
backgroundColor: Colors.red,
content: Text(data["message"]),
),
);
}
}
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text("Tambah User"),
backgroundColor: Color(0xff4A43EC),
foregroundColor: Colors.white,
),
body: Padding(
padding: const EdgeInsets.all(20),
child: Column(
children: [
TextField(
controller: username,
decoration: const InputDecoration(
labelText: "Username",
),
),
const SizedBox(height: 10),
TextField(
controller: email,
decoration: const InputDecoration(
labelText: "Email",
),
),
const SizedBox(height: 10),
TextField(
controller: password,
obscureText: true,
decoration: const InputDecoration(
labelText: "Password",
),
),
const SizedBox(height: 20),
SizedBox(
width: double.infinity,
child: ElevatedButton(
style: ElevatedButton.styleFrom(
backgroundColor: const Color(0xff4A43EC),
foregroundColor: Colors.white,
padding: const EdgeInsets.symmetric(
vertical: 15,
),
),
onPressed: saveUser,
child: const Text(
"Simpan",
style: TextStyle(
fontSize: 16,
fontWeight: FontWeight.bold,
),
),
),
)
],
),
),
);
}
}