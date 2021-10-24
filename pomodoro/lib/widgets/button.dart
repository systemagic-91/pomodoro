import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function onPress;
  final String text;
  const Button({
    required this.onPress,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: ElevatedButton(
          onPressed: () => {
            onPress(),
          },
          child: Text(
            text,
            style: TextStyle(fontSize: 15),
          ),
          // style: ElevatedButton.styleFrom(
          //   fixedSize: Size(200, 40),
          // ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
          ),
        ),
      ),
    );
  }
}
