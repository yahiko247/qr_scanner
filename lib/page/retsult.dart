import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code/page/screen.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRResult extends StatelessWidget {
  final String code;
  final Function() closeScreen;

  const QRResult({super.key, required this.code, required this.closeScreen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade900,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return Screen();
              },
            ));
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        centerTitle: true,
        title: Text(
          "Scanned Result",
          style: TextStyle(
              color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(60),
        child: Column(
          children: [
            SizedBox(
              height: 120,
            ),
            QrImageView(
              data: "",
              size: 300,
              version: QrVersions.auto,
            ),
            Text(
              "Scanned QR",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              code,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black87, fontSize: 15),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 150,
              height: 35,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber.shade900),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: code));
                  },
                  child: Text(
                    "Copy",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
