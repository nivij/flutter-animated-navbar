import 'package:flutter/material.dart';

import '../model class/usermodel/user_model.dart';
import '../services/api/api_services.dart';


class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late Future<List<User>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = ApiService().fetchUsers(); // Fetch data when the screen loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users")),
      body: FutureBuilder<List<User>>(
        future: futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No users found"));
          } else {
            List<User> users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                User user = users[index];
                return ListTile(
                  leading: user.profilePic != null
                      ? CircleAvatar(backgroundImage: NetworkImage(user.profilePic!))
                      : CircleAvatar(child: Icon(Icons.person)),
                  title: Text(user.name),
                  subtitle: Text(user.email),
                );
              },
            );
          }
        },
      ),
    );
  }
}
