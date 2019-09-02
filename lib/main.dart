import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/network/Post.dart';
import 'package:http/http.dart' as http;

//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  final double avatarSize = 40;
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//        theme: ThemeData(
//          primarySwatch: Colors.green,
//        ),
//        home: DefaultTabController(
//          length: 2,
//          initialIndex: 0,
//          child: Scaffold(
//            appBar: AppBar(
//              title: Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: [
//                  Spacer(flex: 1),
//                  Container(
//                    width: avatarSize,
//                    height: avatarSize,
//                    decoration: new BoxDecoration(
//                      color: const Color(0xff7c94b6),
//                      image: new DecorationImage(
//                        image: AssetImage('assets/images/no_img.png'),
//                        fit: BoxFit.cover,
//                      ),
//                      borderRadius:
//                          new BorderRadius.all(new Radius.circular(50.0)),
//                      border: new Border.all(
//                        color: Colors.white,
//                        width: 4.0,
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//              bottom: TabBar(
//                tabs: [MyTab("films"), MyTab("favorites")],
//              ),
//            ),
//            body: TabBarView(
//              children: <Widget>[
//                MyTabView(
//                    key: PageStorageKey("bodyContent1"),
//                    bodyContent: "bodyContent1"),
//                MyTabView(
//                    key: PageStorageKey("bodyContent2"),
//                    bodyContent: "bodyContent2"),
//              ],
//            ),
//          ),
//        ));
//  }
//}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Http Request Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post> _posts = [];

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  bool _isLoading = false;

  @override
  initState() {
    super.initState();
    fetchPosts();
  }

  Future<dynamic> fetchPosts() {
    _isLoading = true;

    return http
        .get('https://jsonplaceholder.typicode.com/posts')
        .then((http.Response response) {
      final List<Post> fetchedPosts = [];

      final List<dynamic> postsData = json.decode(response.body);
      if (postsData == null) {
        setState(() {
          _isLoading = false;
        });
      }

      for (var i = 0; i < postsData.length; i++) {
        final Post post = Post(
            userId: postsData[i]['userId'],
            id: postsData[i]['id'],
            title: postsData[i]['title'],
            body: postsData[i]['body']);
        fetchedPosts.add(post);
      }

      setState(() {
        _posts = fetchedPosts;
        _isLoading = false;
      });
    }).catchError((Object error) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<dynamic> _onRefresh() {
    return fetchPosts();
  }

  Widget _buildPostList() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      key: _refreshIndicatorKey,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              Padding(
                child: new ListTile(
                  title: Text(_posts[index].title),
                  subtitle: Text(_posts[index].body),
                ),
                padding: EdgeInsets.all(10.0),
              ),
              Divider(
                height: 5.0,
              )
            ],
          );
        },
        itemCount: _posts.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _buildPostList(),
    );
  }
}
