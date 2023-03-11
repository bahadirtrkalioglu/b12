import 'package:b12/components/custom_floating_button.dart';
import 'package:b12/home_page.dart';
import 'package:b12/pages/add_item.dart';
import 'package:b12/pages/trip_stats_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'dart:math';

class CreateListPage extends StatefulWidget {
  List listItem;
  List tripList;
  List wholeList;
  CreateListPage(
      {super.key,
      required this.listItem,
      required this.tripList,
      required this.wholeList});

  @override
  State<CreateListPage> createState() => _CreateListPageState();
}

class _CreateListPageState extends State<CreateListPage> {
  int plugNum = 2;
  int ovenNum = 1;

  List placePhotoUrl = [
    'https://www.indyturk.com/sites/default/files/styles/1368x911/public/article/main_image/2019/02/28/46541-155911454.jpg?itok=8SoQRIuz',
    'https://blog.obilet.com/wp-content/uploads/2018/09/d%C3%BCnyan%C4%B1n-en-g%C3%BCzel-%C3%BClkeleri-slovenya.jpg',
    'https://blog.biletbayi.com/wp-content/uploads/2017/12/bran-kalesi-scaled.jpg',
    'https://www.etstur.com/letsgo/wp-content/uploads/2018/11/lg-tepe-1.jpg',
    'https://gezlist.com/wp-content/uploads/2018/06/tasi-taragi-toplayip-yerlesmek-isteyeceginiz-turkiyenin-en-guzel-sahil-kasabalari-1280x720.jpg',
    'https://cdn1.ntv.com.tr/gorsel/Iov0W1K_RUGHW5W8M63VuA.jpg?width=800&height=531&mode=crop&scale=both&v=20220825090452796',
    'https://blog.biletbayi.com/wp-content/uploads/2020/02/bursa-golyazi.jpg',
    'https://i4.hurimg.com/i/hurriyet/75/750x0/582b0cf10f25442048876117.jpg',
    'https://i2.gazetevatan.com/i/gazetevatan/75/0x0/6294a492136acf48a956dde5.jpg',
    'https://listelist.com/wp-content/uploads/2017/03/12-2-Iguazu-750x375.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    //Generating random number for placePhotoUrl List.
    Random random = Random();
    int randomNumber = random.nextInt(10);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.black87,
            )),
        actions: [
          MaterialButton(
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 1 / 2,
                      color: Color(0xFF7EFFD8),
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                  child: Text(
                                "Priz Sayısı",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87),
                              )),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: FaIcon(
                                        FontAwesomeIcons.minus,
                                        color: Colors.black87,
                                      ),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.transparent,
                                          border: Border.all(
                                              width: 2, color: Colors.black87)),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        if (plugNum < 1) {
                                          return;
                                        }
                                        plugNum -= 1;
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    plugNum.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: Colors.black87),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: FaIcon(
                                        FontAwesomeIcons.plus,
                                        color: Colors.black87,
                                      ),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.transparent,
                                          border: Border.all(
                                              width: 2, color: Colors.black87)),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        plugNum += 1;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Center(
                                  child: Text("Ocak Sayısı",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87))),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: FaIcon(
                                        FontAwesomeIcons.minus,
                                        color: Colors.black87,
                                      ),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.transparent,
                                          border: Border.all(
                                              width: 2, color: Colors.black87)),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        if (ovenNum < 1) {
                                          return;
                                        }
                                        ovenNum -= 1;
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    ovenNum.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: Colors.black87),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: FaIcon(
                                        FontAwesomeIcons.plus,
                                        color: Colors.black87,
                                      ),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.transparent,
                                          border: Border.all(
                                              width: 2, color: Colors.black87)),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        ovenNum += 1;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              GestureDetector(
                                onTap: () {
                                  widget.tripList.add(widget.listItem);
                                  widget.tripList.add(plugNum);
                                  widget.tripList.add(ovenNum);
                                  var newItem = widget.tripList;
                                  if (newItem != null) {
                                    setState(() {
                                      newItem.insert(
                                          //FIXME: Add some photos!!!!!
                                          0,
                                          placePhotoUrl[randomNumber]);
                                      widget.wholeList.add(newItem);
                                    });
                                  }
                                  Get.offAll(HomePage(
                                    wholeList: widget.wholeList,
                                  ));
                                },
                                child: Material(
                                  elevation: 7,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.teal,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 12),
                                    child: Text("Tamamla",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                            color: Colors.white)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
                },
              );
            },
            child: Icon(
              Icons.thumb_up,
              color: Colors.black87,
            ),
          )
        ],
        title: Text(
          "B-12",
          style: TextStyle(
              color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color(0xFFB9FFFF),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 8 / 9,
              width: MediaQuery.of(context).size.width - 10,
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 45,
                bottom: 16,
              ),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.listItem[index][0],
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            FaIcon(FontAwesomeIcons.qrcode)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  );
                },
                itemCount: widget.listItem.length,
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: CustomFloatingButton(
        onPressed: () {
          Get.to(AddItem(
            itemList: widget.listItem,
            tripList: widget.tripList,
            wholeList: widget.wholeList,
          ));
        },
        icon: FaIcon(FontAwesomeIcons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
