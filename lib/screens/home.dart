import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  fetchData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print("on_bording values ${pref.getBool("onBording_done")}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Center(
            child: Text('this is hone'),
          ),
          FloatingActionButton(
            onPressed: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.setBool('key', true);
            },
            child: Icon(Icons.add),
          )
        ],
      )),
    );
  }
}
