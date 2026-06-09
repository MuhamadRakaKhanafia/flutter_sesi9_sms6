import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'AddUserPage.dart';
class UserListPage extends StatefulWidget {
const UserListPage({super.key});
@override
State<UserListPage> createState() => _UserListPageState();
}
class _UserListPageState extends State<UserListPage> {
List users = [];
bool isLoading = true;
@override
void initState() {
super.initState();
getUsers();
}
Future<void> getUsers() async {
setState(() {
isLoading = true;
});
try {
final response = await http.get(
Uri.parse(
"http://localhost/flutter_api/user/get_user.php",
),
);
if (response.statusCode == 200) {
final result = jsonDecode(response.body);
setState(() {
users = result["data"] ?? [];
isLoading = false;
});
}
} catch (e) {
print(e);
setState(() {
isLoading = false;
});
}
}
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text("Daftar User"),
backgroundColor: Color(0xff4A43EC),
foregroundColor: Colors.white,
),
floatingActionButton: FloatingActionButton(
backgroundColor: Color(0xff4A43EC),
foregroundColor: Colors.white,
child: const Icon(Icons.add,size: 30),
onPressed: () async {
final result = await Navigator.push(
context,
MaterialPageRoute(
builder: (context) => const AddUserPage(),
),
);
if (result != null) {
await getUsers();
setState(() {});
if (!mounted) return;
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
backgroundColor: Colors.green,
behavior: SnackBarBehavior.floating,
duration: const Duration(seconds: 2),
content: Row(
children: [
const Icon(
Icons.check_circle,
color: Colors.white,
),
const SizedBox(width: 10),
Expanded(
child: Text(result),
),
],
),
),
);
}
},
),
body: isLoading
? const Center(
child: CircularProgressIndicator(),
)
: users.isEmpty
? const Center(
child: Text("Data user tidak ditemukan"),
)
: ListView.builder(
itemCount: users.length,
itemBuilder: (context, index) {
return Card(
margin: const EdgeInsets.symmetric(
horizontal: 12,
vertical: 6,
),
child: ListTile(
leading: CircleAvatar(
backgroundColor: Color(0xff4A43EC),
child: Text(
users[index]["username"][0]
.toUpperCase(),
style: const TextStyle(
color: Colors.white,
),
),
),
title: Text(
users[index]["username"],
),
subtitle: Text(
users[index]["email"],
),
),
);
},
),
);
}
}