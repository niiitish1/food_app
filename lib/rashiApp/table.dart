// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTable extends StatelessWidget {
  MyTable(this.number, {Key? key}) : super(key: key);
  int number = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Table of $number')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(0.8, 0.0),
                colors: [Colors.red, Colors.blue],
                tileMode: TileMode.repeated,
              ),
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                10,
                (index) => craeteTable(index),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget craeteTable(int no) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          '$number x ${no + 1} = ${number * (no + 1)}',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ));
  }
}
