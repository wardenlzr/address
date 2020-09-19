import 'package:flutter/material.dart';

class MNavBar extends StatefulWidget {
  ValueChanged<int> callback;

  MNavBar(this.callback);

  @override
  _MNavBarState createState() => _MNavBarState();
}

class _MNavBarState extends State<MNavBar> {
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.grey,
      onTap: (i) {
        setState(() {
          _currentTab = i;
        });
        widget.callback(i);
      },
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.adb), title: Text("首页")),
        BottomNavigationBarItem(icon: Icon(Icons.adb), title: Text("首页")),
        BottomNavigationBarItem(icon: Icon(Icons.adb), title: Text("首页")),
        BottomNavigationBarItem(icon: Icon(Icons.adb), title: Text("首页")),
      ],
      currentIndex: _currentTab,
    );
  }
}
