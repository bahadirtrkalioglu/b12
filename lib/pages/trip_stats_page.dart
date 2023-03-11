import 'package:b12/components/oven_info.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TripStatPage extends StatefulWidget {
  const TripStatPage({super.key});

  @override
  State<TripStatPage> createState() => _TripStatPageState();
}

class _TripStatPageState extends State<TripStatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(
          "B-12",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.red.shade300,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OvenInfo(numberOfThings: 6, text: "Priz"),
                    OvenInfo(
                      numberOfThings: 1,
                      text: "Ocak",
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
