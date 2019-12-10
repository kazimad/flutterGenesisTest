import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/generated/i18n.dart';
import 'package:flutter_genesis_test/ui/widgets/tab_widget/favorite_tab_widget.dart';
import 'package:flutter_genesis_test/ui/widgets/tab_widget/movie_tab_widget.dart';
import 'package:flutter_genesis_test/ui/widgets/tool_bar_widget.dart';

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
                ToolBarWidget(widget.token),
              ]),
              bottom: TabBar(
                tabs: <Widget>[Tab(text: S.of(context).films), Tab(text: S.of(context).favorites)],
              ),
            )
          ];
        },
        body: TabBarView(
          children: <Widget>[
            MovieTabWidget(
              key: PageStorageKey("bodyContent1"),
            ),
            FavoriteTabWidget(
              key: PageStorageKey("bodyContent2"),
            ),
          ],
        ),
      ),
    ));
  }
}
