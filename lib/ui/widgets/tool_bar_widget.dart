import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'avatar_widget.dart';

class ToolBarWidget extends StatelessWidget {
  final double avatarSize = 40;
  final dynamic token;

  ToolBarWidget(String token) : this.token = token;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: avatarSize,
        height: avatarSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
        ),
        child: AvatarWidget(token: token));
  }
}
