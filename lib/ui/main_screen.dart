import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/ui/tabs/my_tab.dart';

import 'list_view/favorite_view_container.dart';
import 'list_view/movie_view_container.dart';

class MainScreen extends StatefulWidget {
  final dynamic profileImageToLoad;

  MainScreen(this.profileImageToLoad);

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
//            key: new GlobalKey("DebagGlobalScafold"),
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                    child: CachedNetworkImage(
                      imageUrl: widget.profileImageToLoad['picture']['data']['url'],
                      placeholder: (context, url) => new CircularProgressIndicator(),
                      errorWidget: (context, url, error) => new Icon(Icons.error),
                    ),
                  )),
            ],
          ),
          bottom: TabBar(
            tabs: [MyTab("films"), MyTab("favorites")],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            MovieView(
              key: PageStorageKey("bodyContent1"),
//                  bodyContent: "bodyContent1",
            ),
            FavoriteView(
              key: PageStorageKey("bodyContent2"),
//                    bodyContent: "bodyContent2"
            ),
          ],
        ),
      ),
    ));
  }
}
