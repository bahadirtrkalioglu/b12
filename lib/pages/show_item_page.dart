import 'dart:io';

import 'package:b12/pages/create_list_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:typed_data';

class ShowItemPage extends StatefulWidget {
  String data;
  ShowItemPage({Key? key, required this.data}) : super(key: key);

  @override
  State<ShowItemPage> createState() => _ShowItemPageState();
}

class _ShowItemPageState extends State<ShowItemPage> {
  final _screenShotController = ScreenshotController();
  int _counter = 0;
  late Uint8List _imageFile;

  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();

    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = 'screenshot$time';
    final result = await ImageGallerySaver.saveImage(bytes, name: name);

    return result['filePath'];
  }

  Future saveAndShare(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/flutter.png');
    image.writeAsBytesSync(bytes);
    await Share.shareFiles([image.path]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.black87,
            )),
        title: Text(
          widget.data,
          style: TextStyle(
              color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color(0xFFB9FFFF),
      ),
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  Center(
                    child: Screenshot(
                      controller: _screenShotController,
                      child: QrImage(
                        data: widget.data,
                        backgroundColor: Colors.grey.shade200,
                        version: QrVersions.auto,
                        size: 300.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35.0,
                  ),
                  RawMaterialButton(
                    onPressed: () async {
                      await _screenShotController
                          .capture()
                          .then((Uint8List? image) {
                        //Capture Done
                        setState(() {
                          _imageFile = image!;
                        });
                      }).catchError((onError) {
                        print(onError);
                      });
                      await saveImage(_imageFile);
                      Get.back();
                      //await saveAndShare(_imageFile);
                    },
                    fillColor: Colors.red.shade300,
                    elevation: 0.0,
                    padding: EdgeInsets.symmetric(
                      horizontal: 36.0,
                      vertical: 16.0,
                    ),
                    child: Text(
                      "Galeriye Kaydet",
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  RawMaterialButton(
                    onPressed: () async {
                      await _screenShotController
                          .capture()
                          .then((Uint8List? image) {
                        //Capture Done
                        setState(() {
                          _imageFile = image!;
                        });
                      }).catchError((onError) {
                        print(onError);
                      });
                      //await saveImage(_imageFile);
                      await saveAndShare(_imageFile);
                      Get.back();
                    },
                    fillColor: Colors.red.shade300,
                    elevation: 0.0,
                    padding: EdgeInsets.symmetric(
                      horizontal: 36.0,
                      vertical: 16.0,
                    ),
                    child: Text(
                      "Yazdır",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
