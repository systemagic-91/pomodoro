import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  final Function onPress;
  final double size;
  final Icon icon;
  const MyIconButton({
    required this.onPress,
    required this.icon,
    this.size = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: IconButton(
          splashColor: Colors.blueGrey,
          highlightColor: Colors.purple,
          color: Colors.blueGrey,
          onPressed: onPress(),
          icon: icon,
          iconSize: 60.0,
        ),
      ),
    );
  }
}
