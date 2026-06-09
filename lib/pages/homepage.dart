import 'package:flutter/material.dart';
import 'UserListPage.dart';
class HomePage extends StatelessWidget {
final String username;

// ignore: prefer_const_constructors_in_immutables

const HomePage({
super.key,
required this.username,
});
@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xffF5F7FB),
body: SafeArea(
child: SingleChildScrollView(
child: Padding(
padding: const EdgeInsets.all(20),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
/// HEADER
Container(
padding: const EdgeInsets.all(20),
decoration: BoxDecoration(
gradient: const LinearGradient(
colors: [
Color(0xff6C63FF),
Color(0xff4A43EC),
],
begin: Alignment.topLeft,
end: Alignment.bottomRight,
),
borderRadius: BorderRadius.circular(25),
boxShadow: [
BoxShadow(
color: Colors.deepPurple.withOpacity(0.3),
blurRadius: 15,
offset: const Offset(0, 8),
)
],
),
child: Row(
children: [
Container(
width: 70,
height: 70,
decoration: BoxDecoration(
color: Colors.white.withOpacity(0.2),
shape: BoxShape.circle,
),
child: const Icon(
Icons.person,
color: Colors.white,
size: 40,
),
),
const SizedBox(width: 20),
Expanded(
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [
Text(
"Selamat Datang",
style: const TextStyle(
color: Colors.white70,
fontSize: 16,
),
),
const SizedBox(height: 5),
Text(
username,
style: const TextStyle(
color: Colors.white,
fontSize: 26,
fontWeight: FontWeight.bold,
),
),
],
),
)
],
),
),
const SizedBox(height: 30),
/// MENU TITLE
const Text(
"Menu Utama",
style: TextStyle(
fontSize: 22,
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 20),
/// GRID MENU
GridView.count(
shrinkWrap: true,
physics:
const NeverScrollableScrollPhysics(),
crossAxisCount: 2,
crossAxisSpacing: 15,
mainAxisSpacing: 15,
children: [
/// DAFTAR USER
GestureDetector(
onTap: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) =>
const UserListPage(),
),
);
},
child: menuCard(
icon: Icons.people,
title: "Daftar User",
color: Colors.blue,
),
),
/// LOGOUT
GestureDetector(
onTap: () {
showDialog(
context: context,
builder: (context) {
return AlertDialog(
title: const Text("Logout"),
content: const Text(
"Yakin ingin logout?",
),
actions: [
TextButton(
onPressed: () {
Navigator.pop(context);
},
child: const Text("Batal"),
),
ElevatedButton(
onPressed: () {
Navigator.pushNamedAndRemoveUntil(
context,
'/',
(route) => false,
);
},
style: ElevatedButton.styleFrom(
backgroundColor: Colors.red,
),
child:
const Text("Logout"),
)
],
);
},
);
},
child: menuCard(
icon: Icons.logout,
title: "Logout",
color: Colors.red,
),
),
],
),
],
),
),
),
),
);
}
Widget menuCard({
required IconData icon,
required String title,
required Color color,
}) {
return Container(
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(20),
boxShadow: [
BoxShadow(
color: Colors.black.withOpacity(0.05),
blurRadius: 10,
offset: const Offset(0, 5),
)
],
),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Container(
padding: const EdgeInsets.all(15),
decoration: BoxDecoration(
color: color.withOpacity(0.1),
shape: BoxShape.circle,
),
child: Icon(
icon,
color: color,
size: 35,
),
),
const SizedBox(height: 15),
Text(
title,
style: const TextStyle(
fontSize: 16,
fontWeight: FontWeight.w600,
),
)
],
),
);
}
}