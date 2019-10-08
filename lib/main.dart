import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/ui/list_view/favorite_view_container.dart';
import 'package:flutter_genesis_test/ui/list_view/movie_view_container.dart';
import 'package:flutter_genesis_test/ui/tabs/my_tab.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final double avatarSize = 40;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: DefaultTabController(
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
                    decoration: new BoxDecoration(
                      color: const Color(0xff7c94b6),
                      image: new DecorationImage(
                        image: AssetImage('assets/images/no_img.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius:
                          new BorderRadius.all(new Radius.circular(50.0)),
                      border: new Border.all(
                        color: Colors.white,
                        width: 4.0,
                      ),
                    ),
                  ),
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
