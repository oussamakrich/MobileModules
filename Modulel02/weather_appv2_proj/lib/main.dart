import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_appv2_proj/currently.dart';
import 'package:weather_appv2_proj/today.dart';
import 'package:weather_appv2_proj/weekly.dart';
import 'package:weather_appv2_proj/getLoacalisation.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'wheather project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        splashColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 104, 51, 195)),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class Result{

  Result({required this.city, required this.country, required this.la, required this.lo});

  String city;
  String country;
  double la;
  double lo;


}

class _MainPageState extends State<MainPage> {

  int pageIndex = 0;
  String searchText = '';
  Result selectedCity = Result(city: '', country: '', la: 0, lo: 0);
  List<Result> searchResult = [];
  bool error = false;
  

  final pageController = PageController();


  switchTab(int index){

    setState(() {
      pageIndex = index;
    });
    pageController.jumpToPage(index);
  }

  updateSearchText(text, isError){
    setState(() {
      searchText = text;
      error = isError;
    });

  }

  fetchCities(String searchText) async {

    final response = await http.get(
      Uri.parse('https://api.api-ninjas.com/v1/city?name=$searchText&limit=10'),
      headers: {'X-Api-Key' : 'qekMDF0MJb3/ASsOzQ6aPQ==Rb5fYuJwi6fxovgo'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<Result> res = [];

      for(var item in data){
        res.add(Result(city: item['name'], country: item['country'], la: item['latitude'], lo: item['longitude']));
      }
      setState(() {
        if (res.isEmpty){
          searchResult = [Result(city: 'No city found', country: '', la: 0, lo:0)];
          return;
        }
        searchResult = res;
      });
      
    }
    else {
      print(response.body);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          titleSpacing: 0,
          backgroundColor: Colors.blue[600],
          leading: Icon(Icons.search, color: Colors.grey[100]),
          title: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextField(
                style: const TextStyle(color : Colors.white, fontWeight: FontWeight.bold, fontSize: 17,decorationThickness: 0.0),
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.grey[100]),
                  border: InputBorder.none,
                ),
                onChanged: (value) async {
                  setState(() {
                    searchText = value;
                  });
                  if (value.isEmpty){
                      setState(() {
                        searchResult = [];
                        selectedCity = Result(city: '', country: '', la: 0, lo: 0);
                        return;
                      });
                  }
                  await fetchCities(searchText);

                },
              ),
          ),
          actions: [Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(onPressed: () async {
              getUserLocation(updateSearchText);
            },icon : Icon(CupertinoIcons.location, color: Colors.grey[100])),
          )],
      ),

      // body: Center(child: _screens[pageIndex]()),
      // body: PageView(
      //   controller: pageController,
      //   onPageChanged: (index) {
      //     setState(() {
      //       pageIndex = index;
      //     });
      //   },
      //   children: [
      //     Currently(searchText: searchText, error : error),
      //     Today(searchText: searchText, error : error),
      //     Weekly(searchText: searchText, error : error),
      //   ],
      // ),

      body : Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                pageIndex = index;
              });
            },
            children: [
              Currently(selectedCity : selectedCity, error: error),
              Today(selectedCity : selectedCity, error: error),
              Weekly(selectedCity : selectedCity, error: error),
            ],
          ),
          if (searchResult.isNotEmpty && searchText.isNotEmpty)
            Container(
              color: Colors.blue[600],
              child: ListView.builder(
                // padding: const EdgeInsets.symmetric(horizontal: 30),
                itemCount: searchResult.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      setState(() {
                        selectedCity = searchResult[index];
                        searchResult = [];
                        searchText = '';
                      });
                    },
                    leading: const Icon(CupertinoIcons.map_pin_ellipse, color: Colors.white,),
                    title: Row(
                      children: [
                        Text(
                          searchResult[index].city,
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(width: 10,child: Text(',', style: TextStyle(color: Colors.white),),),
                        Text(
                          searchResult[index].country,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        selectedItemColor: Colors.blue[600],
        onTap: switchTab,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.access_time_filled_outlined),
              label: 'Currently',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.today_outlined),
              label: 'Today',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined),
              label: 'Weekly',
          ),
        ],
      ),
      // bottomNavigationBar: 
    );
  }
}