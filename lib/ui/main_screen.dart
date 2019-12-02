import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'list_view/favorite_view_container.dart';
import 'list_view/movie_view_container.dart';
import 'tabs/my_tab.dart';

class MainScreen extends StatefulWidget {
  final String token;

  MainScreen(String token) : this.token = token;

  @override
  _State createState() => _State();
}

class _State extends State<MainScreen> {
  final double avatarSize = 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Spacer(flex: 1),
            Container(
              width: avatarSize,
              height: avatarSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                ),
              ),
              child: ClipOval(
                child: FutureBuilder(
                  future: _getProfile(widget.token),
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
              ),
            ),
          ]),
          bottom: TabBar(
            tabs: [MyTab("films"), MyTab("favorites")],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            MovieView(
              key: PageStorageKey("bodyContent1"),
            ),
            FavoriteView(
              key: PageStorageKey("bodyContent2"),
            ),
          ],
        ),
      ),
    ));
  }

  Future<dynamic> _getProfile(String accessToken) async {
    var graphResponse =
        await http.get('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=$accessToken');
    var profile = json.decode(graphResponse.body);
    return profile;
  }
}
