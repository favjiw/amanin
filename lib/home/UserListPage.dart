import 'package:flutter/material.dart';
import 'package:mobile_flutter3/Model/User.dart';
import 'package:mobile_flutter3/services/user_services.dart';

class Userlistpage extends StatelessWidget {

  final UserServices userServices = UserServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Pengguna"),
      ),
      body: FutureBuilder<List<User>>(
        future: userServices.fetchUserWithoutToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No users found.'));
          } else {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  // trailing: Text(user.role),
                  onTap: () {
                    // Action when a user is tapped, you can navigate to a detail page if needed
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

