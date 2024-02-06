import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:oiljar/src/home/home.dart';
import 'package:oiljar/src/widgets/widgets.dart'
    show CustomAlertDialogWithTextButton;

class QRScanner extends StatelessWidget {
  static const String routeName = '/qr-scanner';
  const QRScanner({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
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
                buttonTitle: 'OK',
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    PickerHomePage.routeName,
                    (route) => false,
                    arguments:
                        (args.toString() == barcodes.first.rawValue.toString())
                            ? true
                            : false,
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
