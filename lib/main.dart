import 'dart:convert';

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

  _addEditAddressDialog() {
    showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
            title: Text("请输入信息"),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              TextFormField(
                controller: controller1,
                decoration: InputDecoration(
                  hintText: '请输入姓名',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        debugPrint('suffixIcon.onPressed');
                        controller1.text = "";
                      });
                    },
                  ),
                ),
                onChanged: (str) {
                  debugPrint(str.length.toString());
                },
              ),
              TextFormField(
                controller: controller2,
                decoration: InputDecoration(
                  hintText: '请输入电话',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        controller2.text = "";
                      });
                    },
                  ),
                ),
              ),
              TextFormField(
                controller: controller3,
                decoration: InputDecoration(
                  hintText: '请输入地址',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        controller3.text = "";
                      });
                    },
                  ),
                ),
              ),
            ]),
            actions: [
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
            Visibility(
                visible: _list != null,
                child: Padding(
                  //上下左右各添加16像素补白
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "长按可编辑已存在的信息",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0,
                    ),
                  ),
                )),
            Expanded(
                child: _list == null
                    ? Text("暂无数据")
                    : ListView.builder(
                        itemBuilder: (context, index) => Item(
                          _list[index],
                          () {
                            controller1.text = _list[index].name;
                            controller2.text = _list[index].phone;
                            controller3.text = _list[index].address;
                            _addEditAddressDialog();
                          },
                          () {
                            showDialog(
                                context: context,
                                builder: (c) {
                                  return AlertDialog(
                                    title: Text("确认删除第${index + 1}条？"),
                                    actions: [
                                      FlatButton(
                                        child: Text("取消"),
                                        onPressed: () =>
                                            Navigator.of(context).pop(), //关闭对话框
                                      ),
                                      FlatButton(
                                        child: Text("确定"),
                                        onPressed: () {
                                          setState(() {
                                            _list.removeAt(index);
                                          });
                                          Navigator.of(context).pop(); //关闭对话框
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                        itemCount: _list.length,
                      ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller1.text = "";
          controller2.text = "";
          controller3.text = "";
          _addEditAddressDialog();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
