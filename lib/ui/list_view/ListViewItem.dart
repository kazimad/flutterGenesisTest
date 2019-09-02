import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/ui/text/StatefulText.dart';

abstract class ListViewItem {}

class HeaderItem extends Text implements ListViewItem {
  final String text;

  HeaderItem(this.text) : super(text);
}

class RegularItem extends StatelessWidget implements ListViewItem {
  final String listViewItemText;
  final double imageSize = 100;
  final double margin8 = 8;
  final double elevation = 4;

  const RegularItem({Key key, this.listViewItemText});

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
                  child: StateFulText(),
                  margin: EdgeInsets.only(
                      left: (imageSize / 2), top: imageSize + (imageSize / 5)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: imageSize + (margin8 * 2), top: margin8),
                child: Column(
                  children: <Widget>[
                    StateFulText(),
                    StateFulText(),
                    Divider(
                      color: Colors.grey,
                    ),
                    Row(
                      children: <Widget>[
                        MaterialButton(
                          child: Text(
                            "add to favorite".toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          onPressed: () {},
                        ),
                        MaterialButton(
                          child: Text(
                            "share".toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          onPressed: () {},
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
