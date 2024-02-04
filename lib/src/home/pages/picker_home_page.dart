import 'package:flutter/material.dart';

import 'package:oiljar/src/login/login.dart' show SignInPage;
import 'package:oiljar/src/services/services.dart'
    show AuthRepository, UserRepository;

class PickerHomePage extends StatefulWidget {
  static const String routeName = '/picker-home';
  const PickerHomePage({super.key});

  @override
  State<PickerHomePage> createState() => _PickerHomePageState();
}

class _PickerHomePageState extends State<PickerHomePage> {
  final user = AuthRepository().getCurrentUser();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Picker Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FutureBuilder(
                future: UserRepository().getAllUsers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            snapshot.data![index].username.toString(),
                          ),
                          subtitle: Text(
                            snapshot.data![index].email.toString(),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Text('Welcome ${user!.email}'),
            ElevatedButton(
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
      ),
    );
  }
}
