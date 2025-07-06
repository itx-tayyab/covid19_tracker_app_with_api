import 'package:covid19_tracker_app_with_api/Components/covidalldata.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String image, name, cases, recovererd, deaths, active ,population, tests;
  DetailScreen({super.key,
    required this.image,
    required this.name,
    required this.cases,
    required this.recovererd,
    required this.deaths,
    required this.active,
    required this.population,
    required this.tests
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.name),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(widget.image),
          ),
          Padding(
            padding: EdgeInsetsGeometry.all(15.0),
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CovidAllData(title: 'Total Cases', value: widget.cases),
                  CovidAllData(title: 'Recovered', value: widget.recovererd),
                  CovidAllData(title: 'Total Deaths', value: widget.deaths),
                  CovidAllData(title: 'Active Cases', value: widget.active),
                  CovidAllData(title: 'Total tests', value: widget.tests),
                  CovidAllData(title: 'Population', value: widget.population),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
