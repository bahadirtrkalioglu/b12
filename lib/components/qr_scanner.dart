import 'dart:io';

import 'package:b12/pages/create_list_page.dart';
import 'package:b12/pages/trip_info_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanner extends StatefulWidget {
  List wholeList;
  int itemIndex;
  int listItemIndex;
  QrScanner(
      {super.key,
      required this.wholeList,
      required this.itemIndex,
      required this.listItemIndex});

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  QRViewController? controller;
  Barcode? barcode;
  bool scanSuccessful = false;

  final qrKey = GlobalKey(debugLabel: "QR");

  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
            borderWidth: 10,
            borderLength: 20,
            borderRadius: 10,
            borderColor: Colors.greenAccent,
            cutOutSize: MediaQuery.of(context).size.width * 0.8),
      );

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((barcode) {
      setState(() {
        this.barcode = barcode;
      });
      print(this.barcode!.code);
      if (widget.wholeList[widget.itemIndex][4][widget.listItemIndex][0] ==
          this.barcode!.code) {
        List theList =
            widget.wholeList[widget.itemIndex][4][widget.listItemIndex];
        theList.removeAt(1);
        theList.insert(1, true);
        Get.offAll(TripInfoPage(
            wholeList: widget.wholeList, itemIndex: widget.itemIndex));
        //TODO: Had to finish checking items!
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    // TODO: implement reassemble
    super.reassemble();

    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  Widget buildresult() => Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0), color: Colors.white24),
      child: Text(
        barcode != null ? 'Sonuç: ${barcode!.code}' : "QR Okutunuz",
        maxLines: 3,
      ));

  Widget buildControlButtons() => Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white24,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
              onPressed: () async {
                await controller?.toggleFlash();
                setState(() {});
              },
              icon: FutureBuilder(
                future: controller?.getFlashStatus(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return Icon(
                        snapshot.data! ? Icons.flash_on : Icons.flash_off);
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            IconButton(
              onPressed: () async {
                await controller?.flipCamera();
                setState(() {});
              },
              icon: FutureBuilder(
                future: controller?.getCameraInfo(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return Icon(Icons.switch_camera);
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          buildQrView(context),
          Positioned(
            child: buildresult(),
            bottom: 10,
          ),
          Positioned(
            child: buildControlButtons(),
            top: 10,
          )
        ],
      ),
    );
  }
}
