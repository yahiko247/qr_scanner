import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code/page/retsult.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  bool isFlashOn = false;
  bool isFrontCameraOn = false;
  bool isScanCompleted = false;
  MobileScannerController cameraController = MobileScannerController();

  void closeScreen() {
    isScanCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade900,
        leading: IconButton(
          style: ButtonStyle(
              iconSize: const WidgetStatePropertyAll(30),
              iconColor: WidgetStatePropertyAll(Colors.amber.shade900),
              backgroundColor: const WidgetStatePropertyAll(Colors.white)),
          onPressed: () {},
          icon: const Icon(Icons.qr_code_scanner),
        ),
        centerTitle: true,
        title: const Text(
          'QR CODE',
          style: TextStyle(
              color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isFlashOn = !isFlashOn;
                });
                cameraController.toggleTorch();
              },
              icon: Icon(
                Icons.flash_on,
                color: isFlashOn ? Colors.white : Colors.black,
              )),
          IconButton(
              onPressed: () {
                setState(() {
                  isFrontCameraOn = !isFrontCameraOn;
                });
                cameraController.switchCamera();
              },
              icon: Icon(
                Icons.flip_camera_android,
                color: isFrontCameraOn ? Colors.white : Colors.black,
              ))
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Place the QR code in designated area',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'let the scan do the magic - It starts on it own!',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.w100),
                )
              ],
            )),
            SizedBox(height: 20),
            Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    MobileScanner(
                      onDetect: (capture) {
                        final barcode = capture.barcodes.first;
                        if (!isScanCompleted) {
                          isScanCompleted = true;
                          String code = barcode.rawValue ?? "---";
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return QRResult(
                                code: code, closeScreen: closeScreen);
                          }));
                        }
                      },
                    ),
                    QRScannerOverlay(
                      overlayColor: Colors.black26,
                      borderColor: Colors.amber.shade900,
                      borderRadius: 20,
                      borderStrokeWidth: 10,
                      scanAreaWidth: 250,
                      scanAreaHeight: 250,
                    )
                  ],
                )),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "|Scan property to see result",
                    style:
                        TextStyle(color: Colors.amber.shade900, fontSize: 20),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
