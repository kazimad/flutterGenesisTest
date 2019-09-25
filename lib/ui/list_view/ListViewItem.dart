import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/data_classes/MoviePOJO.dart';
import 'package:flutter_genesis_test/ui/utils/Commands.dart';

abstract class ListViewItem {}

class HeaderItem extends Text implements ListViewItem {
  final String text;

  HeaderItem(this.text) : super(text);
}

class RegularItem extends StatelessWidget implements ListViewItem {
  final MoviePOJO movie;
  final double imageSize = 100;
  final double margin8 = 8;
  final double elevation = 4;
  final double minFontSize = 12;
  final int maxLines =1;

  const RegularItem({Key key, this.movie});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 4,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(margin8),
                  child: Container(
                    child: Image.asset(
                      'assets/images/no_img.png',
                      width: imageSize,
                      height: imageSize,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  child: Text(movie.popularity.toString()),
//                  child: Text("ss"),
                  margin: EdgeInsets.only(
                      left: (imageSize / 2), top: imageSize + (imageSize / 5)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: imageSize + (margin8 * 2), top: margin8),
                child: Column(
                  children: <Widget>[
                    Text(movie.originalTitle),
//                    Text("ssss"),
                    Text(movie.overview),
//                    Text("qqq"),
                    Divider(
                      color: Colors.grey,
                    ),
                    // TODO change to FlexBox

                    Row(
                      children: <Widget>[
                        Flexible(
                          flex: 2,
                          child: MaterialButton(
                            child: AutoSizeText(
                              "add to favorite".toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                              minFontSize: minFontSize,
                              maxLines: maxLines,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: MaterialButton(
                            child: AutoSizeText(
                              "share".toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                              minFontSize: minFontSize,
                              maxLines: maxLines,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onPressed: () {
                              showErrorMessage(context,
                                  movie.voteCount.toString() + ' - ' + movie.title);
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
