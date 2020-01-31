import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListComponent extends StatelessWidget {

  String id;
  String todo;
  DateTime date;
  String time;
  String color;

  ListComponent({
    this.id,
    this.todo,
    this.date,
    this.time,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            border: Border(
                left: BorderSide(
                    color: Color(int.parse(color)),
                    width: 3.0
                )
            )
        ),
        child: Row(
          children: <Widget>[
            Container(
              child: Text('$time',
                style: TextStyle(
                    color: Colors.grey
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text('$todo'),
            ),
          ],
        ),
      ),
    );
  }
}
