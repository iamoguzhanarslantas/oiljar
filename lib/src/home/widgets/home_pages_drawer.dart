import 'package:flutter/material.dart';

import 'package:oiljar/src/login/login.dart' show SignInPage;
import 'package:oiljar/src/services/services.dart' show AuthRepository;
import 'package:oiljar/src/widgets/widgets.dart' show CustomElevatedButton;

class HomePagesDrawer extends StatefulWidget {
  const HomePagesDrawer({
    super.key,
  });

  @override
  State<HomePagesDrawer> createState() => _HomePagesDrawerState();
}

class _HomePagesDrawerState extends State<HomePagesDrawer> {
  final user = AuthRepository().getCurrentUser();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            // ignore: prefer_const_constructors
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.amber,
                    child: Icon(Icons.person),
                  ),
                  title: user!.email != null
                      ? Text('Welcome ${user!.email!.split('@').first}')
                      : const Text('Guest'),
                  subtitle: user!.email != null
                      ? Text(
                          user!.email!,
                          style: const TextStyle(
                            color: Colors.amber,
                          ),
                        )
                      : const Text('Guest'),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          CustomElevatedButton(
            child: const Text('Sign Out'),
            onPressed: () {
              AuthRepository().signOut().then(
                    (value) => Navigator.pushNamedAndRemoveUntil(
                      context,
                      SignInPage.routeName,
                      (route) => false,
                    ),
                  );
            },
          ),
        ],
      ),
    );
  }
}
