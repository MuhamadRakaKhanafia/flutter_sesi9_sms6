import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'AddUserPage.dart';
import 'EditUserPage.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});
  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List users = [];
  List filteredUsers = [];
  bool isLoading = true;

  TextEditingController searchController = TextEditingController();

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
          filteredUsers = users;
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('$e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      final response = await http.post(
        Uri.parse(
          "http://localhost/flutter_api/user/delete_user.php",
        ),
        body: {
          "id": id,
        },
      );
      final result = jsonDecode(response.body);
      if (!mounted) return;
      if (result["status"] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "User berhasil dihapus",
            ),
          ),
        );
        getUsers();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result["message"],
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  void searchUser(String keyword) {
    if (keyword.isEmpty) {
      setState(() {
        filteredUsers = users;
      });
      return;
    }

    final results = users.where((user) {
      final username = user["username"].toString().toLowerCase();
      final email = user["email"].toString().toLowerCase();
      return username.contains(keyword.toLowerCase()) ||
          email.contains(keyword.toLowerCase());
    }).toList();

    setState(() {
      filteredUsers = results;
    });
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
        child: const Icon(Icons.add, size: 30),
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
            if (!context.mounted) return;
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
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    controller: searchController,
                    onChanged: searchUser,
                    decoration: InputDecoration(
                      hintText: "Cari username atau email",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: filteredUsers.isEmpty
                      ? const Center(
                          child: Text(
                            "Data user tidak ditemukan",
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredUsers.length,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: const Color(0xff4A43EC),
                                  child: Text(
                                    filteredUsers[index]["username"][0]
                                        .toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                title: Text(filteredUsers[index]["username"]),
                                subtitle: Text(filteredUsers[index]["email"]),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Tombol Edit
                                    IconButton(
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.orange,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => EditUserPage(
                                              id: filteredUsers[index]["id"],
                                              username: filteredUsers[index]
                                                  ["username"],
                                              email: filteredUsers[index]
                                                  ["email"],
                                            ),
                                          ),
                                        ).then((value) {
                                          getUsers();
                                        });
                                      },
                                    ),
                                    // Tombol Delete
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text("Konfirmasi"),
                                            content: const Text(
                                              "Yakin ingin menghapus user ini?",
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Batal"),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                  await deleteUser(
                                                    filteredUsers[index]["id"],
                                                  );
                                                },
                                                child: const Text("Hapus"),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}
