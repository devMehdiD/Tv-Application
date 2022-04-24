import 'package:films/pages/downloadpage.dart';
import 'package:films/pages/homepage.dart';
import 'package:films/pages/likepage..dart';
import 'package:films/pages/searchpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int index = 0;
  List scren = [];

  @override
  void initState() {
    scren.add(const HomePage());
    scren.add(const SearchPage());
    scren.add(const LikePage());
    scren.add(const DownloadPgae());
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: scren[index],
        bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              setState(() {
                index = value;
              });
            },
            iconSize: 20,
            unselectedItemColor: Colors.grey,
            currentIndex: index,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(FontAwesome.home),
                  label: "",
                  backgroundColor: Color(0xFF460546)),
              BottomNavigationBarItem(
                  icon: Icon(FontAwesome.search), label: ""),
              BottomNavigationBarItem(icon: Icon(FontAwesome.heart), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(FontAwesome.download), label: "")
            ]),
      ),
    );
  }
}
