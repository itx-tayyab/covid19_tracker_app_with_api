import 'dart:convert';

import 'package:covid19_tracker_app_with_api/Modals/CountriesAllData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({super.key});

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  List<CountriesAllData> countriesdata = [];

  TextEditingController searchcontroller = TextEditingController();

  Future<List<CountriesAllData>> getapicountries() async {
    final http.Response response = await http.get(
      Uri.parse('https://disease.sh/v3/covid-19/Countries'),
      headers: {'Accept': 'application/json', 'User-Agent': 'FlutterApp/1.0'},
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      countriesdata.clear();
      for (Map i in data) {
        countriesdata.add(CountriesAllData.fromJson(i));
      }
      return countriesdata;
    } else {
      return countriesdata;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchcontroller,
              onChanged: (value) {
                setState(() {

                });
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                hintText: 'Search here by country name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getapicountries(),
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return Shimmer.fromColors(
                      baseColor: Colors.grey.shade700 ,
                      highlightColor: Colors.grey.shade200,
                      child: ListView.builder(
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Container(height: 50, width: 50, color: Colors.white,),
                              title: Container(height: 10, width: 89, color: Colors.white,),
                              subtitle: Container(height: 10, width: 89, color: Colors.white,),
                            );
                          }
                      ));
                }else{
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {

                        String name = snapshot.data![index].country.toString();
                        if(searchcontroller.text.isEmpty){
                          return ListTile(
                            leading: Image(
                              height: 50,
                              width: 50,
                              image: NetworkImage(snapshot.data![index].countryInfo!.flag.toString(),
                              ),
                            ),
                            title: Text(snapshot.data![index].country.toString()),
                            subtitle: Text(snapshot.data![index].cases.toString()),
                          );
                        }else if(name.toLowerCase().contains(searchcontroller.text.toLowerCase())){
                          return ListTile(
                            leading: Image(
                              height: 50,
                              width: 50,
                              image: NetworkImage(snapshot.data![index].countryInfo!.flag.toString(),
                              ),
                            ),
                            title: Text(snapshot.data![index].country.toString()),
                            subtitle: Text(snapshot.data![index].cases.toString()),
                          );
                        }else{
                          Container();
                        }
                      }
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
