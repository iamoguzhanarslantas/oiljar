import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:oiljar/src/home/home.dart' show PickerHomePage;
import 'package:oiljar/src/services/services.dart' show UserRepository;
import 'package:oiljar/src/widgets/widgets.dart'
    show CustomAlertDialogWithTextButton;

class QRScanner extends StatelessWidget {
  static const String routeName = '/qr-scanner';
  const QRScanner({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    debugPrint('QRScanner args: ${args.toString()}');
    return Scaffold(
      body: MobileScanner(
        fit: BoxFit.contain,
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
          returnImage: true,
        ),
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          final Uint8List? image = capture.image;
          for (final barcode in barcodes) {
            debugPrint('Barcode: ${barcode.rawValue}');
          }
          if (image != null) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialogWithTextButton(
                title: barcodes.first.rawValue ?? '',
                content: Image(
                  image: MemoryImage(image),
                ),
                child: const Text('Add Points'),
                onPressed: () async {
                  if (args['id'].toString() ==
                      barcodes.first.rawValue.toString()) {
                    await UserRepository().addPoints(
                      args['id'].toString(),
                      int.parse(
                        args['points'],
                      ),
                    );
                  } else {
                    debugPrint('Invalid QR Code');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Invalid QR Code'),
                      ),
                    );
                  }
                  if (context.mounted) {
                    await Navigator.of(context).pushNamedAndRemoveUntil(
                      PickerHomePage.routeName,
                      (route) => false,
                    );
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }
}
