import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'bean/user.dart';

typedef void OnLongClick();
typedef void OnDelClick();

class Item extends StatelessWidget {
  final User user;
  final OnLongClick onLongClick;
  final OnDelClick onDelClick;

  Item(this.user, this.onLongClick, this.onDelClick);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
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
          child: Flex(direction: Axis.horizontal, children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(
                          user.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          user.phone.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Text(user.address)
                ],
              ),
            ),
            InkWell(
              onTap: () {
                onDelClick.call();
              },
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                  size: 23,
                ),
//                child: Image(image: AssetImage("images/del.png"), width: 30.0),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
