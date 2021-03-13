import 'package:flutter/material.dart';
import 'package:happy_postcode_flutter/components/app_theme.dart';

class CenteredMessage extends StatelessWidget {
  final String message;
  final IconData icon;
  final double iconSize;
  final double fontSize;

  CenteredMessage(
    this.message, {
    this.icon,
    this.iconSize = 64,
    this.fontSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Visibility(
              child: Icon(
                icon,
                size: iconSize,
                color: AppTheme.buildTheme().primaryColor,
              ),
              visible: icon != null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Text(
              message,
              style: TextStyle(
                  fontSize: fontSize,
                  color: AppTheme.buildTheme().primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
