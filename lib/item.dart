import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'bean/user.dart';
typedef void OnLongClick();

class Item extends StatelessWidget {
  final User user;
  final OnLongClick onLongClick;

  Item(this.user, this.onLongClick);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: (){

        onLongClick.call();
      },
      onTap: () {
        Clipboard.setData(ClipboardData(
            text: user.name + " " + user.phone + " " + user.address));
        Fluttertoast.showToast(
          msg: "已复制到剪贴板",
          toastLength: Toast.LENGTH_SHORT,
        );
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(user.phone.toString()),
                ],
              ),
              Text(user.address)
            ],
          ),
        ),
      ),
    );
  }
}
