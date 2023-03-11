import 'package:b12/components/custom_floating_button.dart';
import 'package:b12/pages/add_trip.dart';
import 'package:b12/pages/trip_info_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  List? wholeList;
  HomePage({super.key, this.wholeList});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List homeShowingPlaces = [
    [
      'https://blog.biletbayi.com/wp-content/uploads/2017/12/bran-kalesi-scaled.jpg',
      'Malatya - Trabzon',
      DateTime.now(),
      TimeOfDay.now(),
      [
        ["Telefon", false],
        ["Cüzdan", false],
        ["Kimlik", false]
      ],
      3,
      1
    ],
  ];

  @override
  Widget build(BuildContext context) {
    if (widget.wholeList != null) {
      setState(() {
        homeShowingPlaces = widget.wholeList!;
      });
    }
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Align(
                    child: Text(
                      "Seyahatlerim",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    alignment: Alignment.centerLeft),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: (MediaQuery.of(context).size.width * 2 / 3) * 4 / 5,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: homeShowingPlaces.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.offAll(TripInfoPage(
                            wholeList: homeShowingPlaces,
                            itemIndex: index,
                          ));
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 15),
                          width: MediaQuery.of(context).size.width * 4 / 5,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image:
                                    NetworkImage(homeShowingPlaces[index][0]),
                                fit: BoxFit.cover,
                                opacity: 0.7),
                          ),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                homeShowingPlaces[index][1],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: CustomFloatingButton(
          onPressed: () {
            Get.to(AddTrip(
              wholeList: homeShowingPlaces,
            ));
          },
          icon: FaIcon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
