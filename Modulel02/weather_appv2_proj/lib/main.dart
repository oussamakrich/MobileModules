import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherproj/currently.dart';
import 'package:weatherproj/today.dart';
import 'package:weatherproj/weekly.dart';
import 'package:weatherproj/getLoacalisation.dart';

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

class _MainPageState extends State<MainPage> {

  int pageIndex = 0;
  String searchText = '';
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
                onChanged: (value) {setState(() {
                  searchText = value;
                });},
              ),
          ),
          actions: [Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(onPressed: () {
              getUserLocation(updateSearchText);
            },icon : Icon(CupertinoIcons.location, color: Colors.grey[100])),
          )],
      ),
      // body: Center(child: _screens[pageIndex]()),
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        children: [
          Currently(searchText: searchText, error : error),
          Today(searchText: searchText, error : error),
          Weekly(searchText: searchText, error : error),
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