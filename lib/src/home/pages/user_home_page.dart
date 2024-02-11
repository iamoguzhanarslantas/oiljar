import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import 'package:oiljar/src/home/home.dart' show HomePagesDrawer;
import 'package:oiljar/src/services/services.dart' show AuthRepository;

class UserHomePage extends StatefulWidget {
  static const String routeName = '/user-home';
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final user = AuthRepository().getCurrentUser();

  @protected
  late QrCode qrCode;

  @protected
  late QrImage qrImage;

  @protected
  late PrettyQrDecoration qrDecoration;

  @override
  void initState() {
    super.initState();
    qrCode = QrCode.fromData(
      data: user!.uid,
      errorCorrectLevel: QrErrorCorrectLevel.H,
    );
    qrImage = QrImage(qrCode);
    qrDecoration = const PrettyQrDecoration(
        shape: PrettyQrSmoothSymbol(color: Colors.black));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Home Page'),
        automaticallyImplyLeading: true,
      ),
      drawer: const HomePagesDrawer(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (user != null)
              Column(
                children: [
                  Text('Welcome ${user!.email}'),
                  Text(user!.uid),
                ],
              ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.width / 2,
              child: PrettyQrView(
                qrImage: qrImage,
                decoration: qrDecoration,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
