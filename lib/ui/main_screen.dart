import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/generated/i18n.dart';
import 'package:flutter_genesis_test/ui/utils/commands/commands_api.dart';

import 'list_view/favorite_view_container.dart';
import 'list_view/movie_view_container.dart';

class MainScreen extends StatefulWidget {
  final String token;

  MainScreen(String token) : this.token = token;

  @override
  _State createState() => _State();
}

class _State extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [
            SliverAppBar(
              floating: true,
              pinned: false,
              snap: false,
              title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Spacer(flex: 1),
                ToolBar(widget.token),
              ]),
              bottom: TabBar(
                tabs: <Widget>[Tab(text: S.of(context).films), Tab(text: S.of(context).favorites)],
              ),
            )
          ];
        },
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
}

class ToolBar extends StatelessWidget {
  final double avatarSize = 40;
  final dynamic token;

  ToolBar(String token) : this.token = token;

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
      child: ClipOval(
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
      ),
    );
  }
}
