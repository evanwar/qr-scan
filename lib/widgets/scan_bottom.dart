import 'package:flutter/material.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        elevation: 10.0,
        child: Icon(Icons.qr_code_scanner_sharp),
        onPressed: () async {
          String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
              '#3D8BEF', 'Cancelar', true, ScanMode.QR);

          if (barcodeScanRes != "-1") {
            final scanListProvider =
                Provider.of<ScanListProvider>(context, listen: false);

            final newScan = await scanListProvider.newScan(barcodeScanRes);

            launchURL(context, newScan);
          }
        });
  }
}
