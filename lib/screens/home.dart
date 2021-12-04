import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:food_app/rashiApp/rashi_home.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var arr = [];
  bool isLoading = true;
  var link = 'https://gorest.co.in/public/v1/users';
  Map<String, bool> checkIndex = HashMap();
  Map<String, dynamic> checkValue = HashMap();
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkInternet().then((isOnline) {
      if (isOnline) {
        apicall();
      } else {
        checkLocalData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: SafeArea(
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: arr.length,
                  itemBuilder: (context, index) {
                    var userData = arr[index];
                    return ExpansionTile(
                      title: Text(
                        userData['name'],
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                      children: [
                        TextFormField(
                          initialValue: userData['id'].toString(),
                        ),
                        TextFormField(
                          initialValue: userData['name'],
                        ),
                        TextFormField(
                          initialValue: userData['gender'],
                        ),
                        TextFormField(
                          initialValue: userData['status'],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  print(idController.text);
                                },
                                child: Text('Update')),
                            ElevatedButton(
                                onPressed: () {}, child: Text('Delete'))
                          ],
                        )
                      ],
                    );
                  },
                ),
        ));
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("MyApp"),
      actions: [
        PopupMenuButton(
          onSelected: (val) {
            if (val == 2) {
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RashiHome(),
                    ));
              });
            }
          },
          icon: Icon(Icons.more_vert),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              child: Row(
                children: const [
                  Text("Sort by"),
                  Icon(Icons.arrow_drop_down_circle_rounded,
                      color: Colors.black),
                ],
              ),
            ),
            PopupMenuItem(
              value: 2,
              child: Text("by ID"),
            )
          ],
        ),
      ],
    );
  }

  Widget buildExpanCollapse(userData, index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                userData['name'],
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: checkIndex[index] == true ? Colors.blue : Colors.black,
                ),
              ),
              GestureDetector(
                child: checkIndex[userData['name']] == true
                    ? Icon(Icons.arrow_upward, color: Colors.blue)
                    : Icon(Icons.arrow_downward),
                onTap: () {
                  setState(() {
                    if (checkIndex.containsKey(userData['name'])) {
                      if (checkIndex[userData['name']] == true) {
                        checkIndex[userData['name']] = false;
                      } else {
                        checkIndex[userData['name']] = true;
                      }
                    } else {
                      checkIndex[userData['name']] = true;
                      checkValue[userData['name']] = userData;
                    }
                  });
                },
              )
            ],
          ),
          if (checkIndex[userData['name']] == true &&
              checkValue.containsKey(userData['name'])) ...{
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              width: double.infinity,
              color: Colors.green,
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(checkValue[userData['name']]['id'].toString()),
                  // Text(checkValue[userData['name']]['name']),
                  // Text(checkValue[userData['name']]['email']),
                  // Text(checkValue[userData['name']]['gender']),
                  // Text(checkValue[userData['name']]['status']),
                  TextFormField(
                    initialValue: checkValue[userData['name']]['id'].toString(),
                  ),
                  TextFormField(
                    initialValue: checkValue[userData['name']]['name'],
                  ),
                  TextFormField(
                    initialValue: checkValue[userData['name']]['email'],
                  ),
                  TextFormField(
                    initialValue: checkValue[userData['name']]['gender'],
                  ),
                  TextFormField(
                    initialValue: checkValue[userData['name']]['status'],
                  ),
                  // TextField(controller: genderController),
                  // TextField(controller: statusController),
                  // TextField(controller: emailController),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            print('tap');
                            // updateUser(userData);
                          },
                          child: Text('Update')),
                      ElevatedButton(
                          onPressed: () {
                            deleteUser(userData);
                          },
                          child: Text('Delete')),
                    ],
                  )
                ],
              ),
            )
          }
        ],
      ),
    );
  }

  checkLocalData() {
    SharedPreferences.getInstance().then((pref) {
      var prefData = pref.getString('data');
      if (prefData == null) {
        apicall();
      } else {
        var data = jsonDecode(prefData);
        setState(() {
          isLoading = false;
          arr = data['data'];
        });
      }
    });
    print('======local data end=========');
  }

  apicall() async {
    var resp = await http.get(Uri.parse(link));
    var jsnResp = jsonDecode(resp.body);
    setState(() {
      isLoading = false;
      arr = jsnResp['data'];
    });
    SharedPreferences.getInstance().then((pref) {
      pref.setString('data', resp.body);
    });
    print('======api call end=========');
  }

  updateUser(userData) async {
    var name = nameController.text,
        email = emailController.text,
        gender = genderController.text,
        status = statusController.text;
    var resp = await http.patch(
      Uri.parse(link + "/${userData['id']}"),
      body: {
        "name": name,
        "email": email,
        "gender": gender,
        "status": status,
      },
      headers: {
        "Authorization":
            "Bearer a39bd94de4d16524d53767585cca09968dee649f244d473750c25e3518e280fe"
      },
    );
    print('${userData['id']}  response code: ${resp.statusCode}');
    if (resp.statusCode == 200) {
      apicall();
    }
  }

  deleteUser(userData) async {
    var resp = await http.delete(
      Uri.parse(link + "/${userData["id"]}"),
      headers: {
        "Authorization":
            "Bearer a39bd94de4d16524d53767585cca09968dee649f244d473750c25e3518e280fe"
      },
    );
    print(resp.statusCode);
    if (resp.statusCode == 204) {
      apicall();
    }
    // print(rsp.stat);
  }

  Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
