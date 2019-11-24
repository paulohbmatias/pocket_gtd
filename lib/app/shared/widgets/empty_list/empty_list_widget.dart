import 'package:flutter/material.dart';

class EmptyListWidget extends StatelessWidget {

  final String image;
  final IconData icon;
  final String text;

  EmptyListWidget(this.text, {this.image, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            icon == null ? Image.asset(
              image,
              fit: BoxFit.contain,
              height: 200,
            ) : Icon(icon, size: 80, color: Colors.grey,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            )
          ],
        ),
      ),
    );
  }
}
