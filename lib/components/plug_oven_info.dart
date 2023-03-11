import 'package:flutter/material.dart';

class PlugOvenInfo extends StatelessWidget {
  final void Function()? cameraFunc;
  final String text;
  final String completeInfo;
  const PlugOvenInfo(
      {super.key,
      required this.cameraFunc,
      required this.completeInfo,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.width * 1 / 3) * 2 / 3,
      width: MediaQuery.of(context).size.width * 1 / 3,
      decoration: BoxDecoration(
        color: Color(0xFF22FCC7).withOpacity(0.33),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                text,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                completeInfo,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          IconButton(onPressed: cameraFunc, icon: Icon(Icons.camera_alt)),
        ],
      ),
    );
  }
}
