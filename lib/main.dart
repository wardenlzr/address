import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  var _list = [
    {"name": "张三", "phone": 1388888888, "address": "湖北省武汉市XXX区XXX"},
  ];

  _addAddress() {
    showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
            title: Text("请输入信息"),
            content: Column(children: [
              TextField(decoration: InputDecoration(hintText: "姓名")),
              TextField(decoration: InputDecoration(hintText: "电话")),
              TextField(decoration: InputDecoration(hintText: "地址")),
            ]),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () => Navigator.of(context).pop(), //关闭对话框
              ),
              FlatButton(
                child: Text("确定"),
                onPressed: () {
                  Navigator.of(context).pop(true); //关闭对话框
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    print("${_list.length}");
    for (int i1 = 0; i1 < 50; i1++) {
      _list.add({
        "name": "张$i1三",
        "phone": "13888888$i1",
        "address": "湖北省武汉市XXX区XXX"
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
                child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              _list[index]["name"],
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18.0,
                              ),
                            ),
                            SizedBox(width: 20),
                            Text(_list[index]["phone"].toString()),
                          ],
                        ),
                        Text(_list[index]["address"])
                      ],
                    ),
                  ),
                );
              },
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
      /*bottomNavigationBar: MNavBar((i) {
        setState(() {});
      }),*/
    );
  }
}
