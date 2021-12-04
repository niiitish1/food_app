import 'package:flutter/material.dart';
import 'package:food_app/rashiApp/table.dart';

class RashiHome extends StatefulWidget {
  const RashiHome({Key? key}) : super(key: key);

  @override
  _RashiHomeState createState() => _RashiHomeState();
}

class _RashiHomeState extends State<RashiHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GridView.count(
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        crossAxisCount: 2,
        children: List.generate(10, (index) {
          return buildBox(index);
        }),
      )),
    );
  }

  Widget buildBox(int index) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MyTable(index + 1)));
      },
      child: Container(
        alignment: Alignment.center,
        color: Colors.blue,
        child: Text('hello ${index + 1}'),
      ),
    );
  }
}
