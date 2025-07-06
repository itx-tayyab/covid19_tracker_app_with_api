import 'dart:async';
import 'dart:convert';
import 'package:covid19_tracker_app_with_api/Components/covidalldata.dart';
import 'package:flutter/material.dart';
import 'package:covid19_tracker_app_with_api/Modals/CovidAllDataModal.dart';
import 'package:covid19_tracker_app_with_api/Screens/countries_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:http/http.dart' as http;

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen>
    with TickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat();
  @override
  void initState() {
    super.initState();
  }

  final colorList = <Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  Future<CovidAllDataModal> getapidata() async {
    final http.Response response = await http.get(
      Uri.parse('https://disease.sh/v3/covid-19/all'),
      headers: {'Accept': 'application/json', 'User-Agent': 'FlutterApp/1.0'},);

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return CovidAllDataModal.fromJson(data);
    } else {
      return CovidAllDataModal.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            FutureBuilder<CovidAllDataModal>(
              future: getapidata(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                    flex: 1,
                    child: SpinKitFadingCircle(
                      controller: controller,
                      color: Colors.white,
                      size: 50,
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsetsGeometry.all(15),
                        child: PieChart(
                          dataMap: {"Total": snapshot.data!.cases!.toDouble(),
                            "Recovered": snapshot.data!.recovered!.toDouble(),
                            "Death": snapshot.data!.deaths!.toDouble()},
                          animationDuration: Duration(milliseconds: 1200),
                          colorList: colorList,
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                          chartType: ChartType.ring,
                          legendOptions: LegendOptions(
                            legendPosition: LegendPosition.left,
                          ),
                          chartValuesOptions: ChartValuesOptions(showChartValuesInPercentage: true),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * .05),
                      Padding(
                        padding: EdgeInsetsGeometry.all(15),
                        child: Card(
                          child: Column(
                            children: [
                              CovidAllData(title: 'Total Cases', value: snapshot.data!.cases!.toString()),
                              CovidAllData(title: 'Total Recovered', value: snapshot.data!.recovered!.toString()),
                              CovidAllData(title: 'Total Deaths', value: snapshot.data!.deaths!.toString()),
                              CovidAllData(title: 'Updated', value: snapshot.data!.updated!.toString()),
                              CovidAllData(title: 'Critical Cases', value: snapshot.data!.critical!.toString()),
                              CovidAllData(title: 'Active Cases', value: snapshot.data!.active!.toString()),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * .05),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CountriesScreen(),));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xff1aa260),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(child: Text('Track Countries',style: TextStyle(fontSize: 20),)),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
