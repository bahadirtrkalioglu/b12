import 'dart:io';

import 'package:b12/pages/create_list_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:typed_data';

class AddItem extends StatefulWidget {
  List itemList;
  List tripList;
  List wholeList;
  AddItem(
      {Key? key,
      required this.itemList,
      required this.tripList,
      required this.wholeList})
      : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _screenShotController = ScreenshotController();
  int _counter = 0;
  late Uint8List _imageFile;
  String data = "";

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
                      child: QrImageView(
                        data: data,
                        backgroundColor: Colors.grey.shade200,
                        version: QrVersions.auto,
                        size: 300.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    width: 300.0,
                    child: TextField(
                      //we will generate a new qr code when the input value change
                      onChanged: (value) {
                        setState(() {
                          data = value;
                        });
                      },
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                      decoration: InputDecoration(
                        hintText: "Yeni eşya ekleyin.",
                        filled: true,
                        fillColor: Colors.grey.shade400,
                        border: InputBorder.none,
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
                      //await saveAndShare(_imageFile);
                      widget.itemList.add([data.toString(), false]);
                      Get.offAll(CreateListPage(
                          listItem: widget.itemList,
                          tripList: widget.tripList,
                          wholeList: widget.wholeList));
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
                      widget.itemList.add(data.toString());
                      Get.offAll(CreateListPage(
                          listItem: widget.itemList,
                          tripList: widget.tripList,
                          wholeList: widget.wholeList));
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
