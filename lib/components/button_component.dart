import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {

  String title;
  Function onTap;

  ButtonComponent({ this.title, this.onTap });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onTap,
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(15.0),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xFF1976D2),
                Color(0xFF42A5F5),
              ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(5.0))
        ),
        child: Center(
          child: Text('$title',
            style: TextStyle(
              color: Colors.white
            ),
          ),
        )
      ),
    );
  }
}
