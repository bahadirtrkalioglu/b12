import 'package:b12/components/auth_textfield.dart';
import 'package:b12/components/custom_floating_button.dart';
import 'package:b12/pages/create_list_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../components/auth_alert_dialog.dart';

class AddTrip extends StatefulWidget {
  List wholeList;
  AddTrip({super.key, required this.wholeList});

  @override
  State<AddTrip> createState() => _AddTripState();
}

class _AddTripState extends State<AddTrip> {
  TextEditingController tripNameController = TextEditingController();
  DateTime theDate = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay(hour: 9, minute: 30);

  void _showTimePicker() async {
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (newTime == null) return;
    setState(() {
      _timeOfDay = newTime;
    });
  }

  List tripList = [];

  @override
  Widget build(BuildContext context) {
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
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AuthTextField(
                      width: MediaQuery.of(context).size.width * 2 / 3,
                      controller: tripNameController,
                      hintText: "Gideceğiniz Yeri Yazınız",
                      isObscureText: false),
                  SizedBox(
                    height: 50,
                  ),
                  Material(
                    elevation: 7.0,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 2 / 3,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color(0xFFF0EBEB),
                          border: Border.all(color: Colors.black87)),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "${theDate.day}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                            VerticalDivider(
                              thickness: 2,
                              color: Colors.black,
                            ),
                            Text(
                              "${theDate.month}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                            VerticalDivider(
                              thickness: 2,
                              color: Colors.black,
                            ),
                            Text(
                              "${theDate.year}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () async {
                      DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: theDate,
                        firstDate: DateTime(2007),
                        lastDate: DateTime(2100),
                      );

                      if (newDate == null) return;
                      setState(() {
                        theDate = newDate;
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 60, vertical: 18),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey.shade300),
                      child: Text(
                        "Tarih Ayarla",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.red[900]),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Material(
                    elevation: 7.0,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 2 / 3,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color(0xFFF0EBEB),
                          border: Border.all(color: Colors.black87)),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "${_timeOfDay.hour}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                            VerticalDivider(
                              thickness: 2,
                              color: Colors.black,
                            ),
                            Text(
                              "${_timeOfDay.minute}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: _showTimePicker,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 60, vertical: 18.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey.shade300),
                      child: Text(
                        "Saati Ayarla",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.red[900]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: CustomFloatingButton(
          onPressed: tripNameController.text != ""
              ? () {
                  tripList.add(tripNameController.text.toString());
                  tripList.add(theDate);
                  tripList.add(_timeOfDay);
                  Get.to(CreateListPage(listItem: [
                    ["Telefon", false],
                    ["Şarj Aleti", false],
                    ["Cüzdan", false]
                  ], tripList: tripList, wholeList: widget.wholeList));
                }
              : () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AuthAlertDialog(
                        buttonText: "Tamam",
                        title: "Hata",
                        content:
                            "Lütfen seyehatinize bir isim verin.",
                        onPressed: () {
                          Get.back();
                        },
                      );
                    },
                  );
                },
          icon: FaIcon(FontAwesomeIcons.list)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
