import 'package:comenta_ai/core/service/auth/auth_service.dart';
import 'package:comenta_ai/utils/app_routes.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          ListTile(
            leading: Icon(
              Icons.my_library_books,
              color: Colors.yellow,
              size: 25,
            ),
            title: Text(
              'Minhas Reviews',
              style: TextStyle(color: Colors.yellow, fontSize: 16),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.MYREVIEWS);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.reviews,
              color: Colors.yellow,
              size: 25,
            ),
            title: Text(
              'Todas Reviews',
              style: TextStyle(color: Colors.yellow, fontSize: 16),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.yellow,
              size: 25,
            ),
            title: Text(
              'Sair do aplicativo',
              style: TextStyle(color: Colors.yellow, fontSize: 16),
            ),
            onTap: auth.logout,
          ),
        ],
      ),
    );
  }
}
