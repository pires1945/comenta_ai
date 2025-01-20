import 'package:comenta_ai/core/service/auth/auth_service.dart';
import 'package:comenta_ai/utils/app_routes.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();
    return Drawer(
      elevation: 15,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(auth.currentUser!.imageUrl),
            ),
            title: Text(
              auth.currentUser!.name,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary, fontSize: 20),
            ),
            subtitle: Text(
              auth.currentUser!.email,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary, fontSize: 16),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          ListTile(
            leading: const Icon(
              Icons.my_library_books,
              color: Colors.white,
              size: 25,
            ),
            title: const Text(
              'Minhas Reviews',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.MYREVIEWS);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.reviews,
              color: Colors.white,
              size: 25,
            ),
            title: const Text(
              'Todas Reviews',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.ALLREVIEWS);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              color: Colors.white,
              size: 25,
            ),
            title: const Text(
              'Configurações',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
              size: 25,
            ),
            title: const Text(
              'Sair do aplicativo',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onTap: auth.logout,
          ),
        ],
      ),
    );
  }
}
