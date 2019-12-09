import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/repositories/profile_repository.dart';

class AvatarWidget extends StatelessWidget {
  final String token;

  AvatarWidget({@required this.token});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: FutureBuilder(
        future: getProfile(token),
        builder: (c, s) {
          if (s.hasData) {
            return CachedNetworkImage(
              imageUrl: s.data['picture']['data']['url'],
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}