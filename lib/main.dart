import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bean/user.dart';
import 'item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Address'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var controller1 = TextEditingController();
  var controller2 = TextEditingController();
  var controller3 = TextEditingController();
  var _list = <User>[];

  _addAddress() {
    showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
            title: Text("请输入信息"),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              TextField(
                  controller: controller1,
                  decoration: InputDecoration(hintText: "姓名")),
              TextField(
                  controller: controller2,
                  decoration: InputDecoration(hintText: "电话")),
              TextField(
                  controller: controller3,
                  decoration: InputDecoration(hintText: "地址")),
            ]),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () => Navigator.of(context).pop(), //关闭对话框
              ),
              FlatButton(
                child: Text("确定"),
                onPressed: () async {
                  Navigator.of(context).pop(); //关闭对话框

                  var user = User(
                      controller1.text, controller2.text, controller3.text);

                  setState(() {
                    _list.insert(0, user);
                  });
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  var mapList = List<Map<String, dynamic>>();
                  _list.forEach((element) {
                    mapList.add(element.toJson());
                  });
                  await prefs.setString('list', jsonEncode(mapList));
                },
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      setState(() {
        if (value.getString("list") == null) {
          return;
        }
        List<dynamic> mapList = jsonDecode(value.getString("list"));
        mapList.forEach((element) {
          _list.add(User.fromJson(element));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print("${_list.length}");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
                child: _list == null
                    ? Text("暂无数据")
                    : ListView.builder(
                        itemBuilder: (context, index) => Item(_list[index]),
                        itemCount: _list.length,
                      ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addAddress,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
