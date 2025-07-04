import 'package:flutter/material.dart';

class CovidAllData extends StatelessWidget {
  String title, value;
  CovidAllData({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontSize: 20,color: Colors.white),),
              Text(value, style: TextStyle(fontSize: 20,color: Colors.white),),
            ],
          ),
        ),
        Divider(height: 10,),
      ],
    );
  }
}
