import 'package:flutter/material.dart';

import 'package:oiljar/src/login/login.dart' show SignInPage;
import 'package:oiljar/src/services/services.dart'
    show AuthRepository, UserRepository;
import 'package:oiljar/src/widgets/custom_alert_dialog_with_text_button.dart'
    show CustomAlertDialogWithTextButton;
import 'package:oiljar/src/widgets/qr_scanner.dart' show QRScanner;

class PickerHomePage extends StatefulWidget {
  static const String routeName = '/picker-home';
  const PickerHomePage({super.key});

  @override
  State<PickerHomePage> createState() => _PickerHomePageState();
}

class _PickerHomePageState extends State<PickerHomePage> {
  final user = AuthRepository().getCurrentUser();
  TextEditingController pointsController = TextEditingController();

  @override
  void dispose() {
    pointsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Picker Home Page'),
        automaticallyImplyLeading: false,
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
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return CustomAlertDialogWithTextButton(
                                  title:
                                      'Add Point to ${snapshot.data![index].email.toString()}',
                                  content: Row(
                                    children: [
                                      const Text('Points: '),
                                      Expanded(
                                        child: TextField(
                                          controller: pointsController,
                                          keyboardType: TextInputType.number,
                                          maxLength: 3,
                                        ),
                                      ),
                                    ],
                                  ),
                                  buttonTitle: 'Add Points',
                                  onPressed: () async {
                                    await Navigator.pushNamed(
                                        context, QRScanner.routeName,
                                        arguments: {
                                          'id': snapshot.data![index].id
                                              .toString(),
                                          'points':
                                              pointsController.text.toString(),
                                        });
                                  },
                                );
                              },
                            );
                          },
                          child: ListTile(
                            title: Text(
                              snapshot.data![index].username.toString(),
                            ),
                            subtitle: Text(
                              snapshot.data![index].email.toString(),
                            ),
                            trailing: Text(
                              snapshot.data![index].points.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: true,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
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
