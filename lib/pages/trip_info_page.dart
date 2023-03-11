import 'package:b12/components/auth_alert_dialog.dart';
import 'package:b12/components/plug_oven_info.dart';
import 'package:b12/components/qr_scanner.dart';
import 'package:b12/home_page.dart';
import 'package:b12/pages/show_item_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class TripInfoPage extends StatefulWidget {
  List wholeList;
  int itemIndex;
  TripInfoPage({super.key, required this.wholeList, required this.itemIndex});

  @override
  State<TripInfoPage> createState() => _TripInfoPageState();
}

class _TripInfoPageState extends State<TripInfoPage> {
  int plugCounter = 0;
  int ovenCounter = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.wholeList[widget.itemIndex]);
  }

  void plugPhoto() async {
    var image = await ImagePicker().getImage(source: ImageSource.camera);
    if (image == null) return;
    GallerySaver.saveImage(image.path);
    setState(() {
      plugCounter += 1;
    });
  }

  void ovenPhoto() async {
    var image = await ImagePicker().getImage(source: ImageSource.camera);
    if (image == null) return;
    GallerySaver.saveImage(image.path);
    setState(() {
      ovenCounter += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    List theList = widget.wholeList[widget.itemIndex][4];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.offAll(HomePage(
                wholeList: widget.wholeList,
              ));
            },
            icon: FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.black87,
            )),
        title: Text(
          widget.wholeList[widget.itemIndex][1],
          style: TextStyle(
              color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color(0xFFB9FFFF),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //TODO: Camera function!
                  PlugOvenInfo(
                      cameraFunc:
                          plugCounter < widget.wholeList[widget.itemIndex][5]
                              ? plugPhoto
                              : () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AuthAlertDialog(
                                        buttonText: "Tamam",
                                        title: "Tamamlandı",
                                        content:
                                            "Tüm prizlerin fotoğrafını çektiniz, galarinizden görüntüleyebilirsiniz.",
                                        onPressed: () {
                                          Get.back();
                                        },
                                      );
                                    },
                                  );
                                },
                      completeInfo:
                          "$plugCounter/${widget.wholeList[widget.itemIndex][5]}",
                      text: "Priz"),
                  SizedBox(
                      width:
                          (MediaQuery.of(context).size.width * 1 / 3) * 1 / 2),
                  PlugOvenInfo(
                      cameraFunc:
                          ovenCounter < widget.wholeList[widget.itemIndex][6]
                              ? plugPhoto
                              : () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AuthAlertDialog(
                                        buttonText: "Tamam",
                                        title: "Tamamlandı",
                                        content:
                                            "Tüm ocakların fotoğrafını çektiniz, galarinizden görüntüleyebilirsiniz.",
                                        onPressed: () {
                                          Get.back();
                                        },
                                      );
                                    },
                                  );
                                },
                      completeInfo:
                          "$ovenCounter/${widget.wholeList[widget.itemIndex][6]}",
                      text: "Ocak"),
                ],
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 1 / 2,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(right: 24.0, left: 24, top: 10),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () =>
                                Get.to(ShowItemPage(data: theList[index][0])),
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    theList[index][0].toString(),
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          icon: FaIcon(FontAwesomeIcons.qrcode),
                                          onPressed: () {
                                            Get.offAll(QrScanner(
                                                wholeList: widget.wholeList,
                                                itemIndex: widget.itemIndex,
                                                listItemIndex: index));
                                          }),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      theList[index][1] == false
                                          ? FaIcon(
                                              FontAwesomeIcons.xmark,
                                              color: Colors.redAccent,
                                            )
                                          : FaIcon(
                                              FontAwesomeIcons.check,
                                              color: Colors.greenAccent,
                                            )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: theList.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
