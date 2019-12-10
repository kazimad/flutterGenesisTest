import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/data_classes/movie_inner.dart';
import 'package:flutter_genesis_test/ui/widgets/detail_widgets/detail_description_widget.dart';
import 'package:flutter_genesis_test/ui/widgets/detail_widgets/detail_image_widget.dart';

class MovieDetailsScreen extends StatelessWidget {
  final MovieInner movieToDetail;

  const MovieDetailsScreen({this.movieToDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              DetailImageWidget(movieToDetail: movieToDetail),
              DetailDescriptionWidget(movieToDetail: movieToDetail),
            ],
          ),
        ),
      ),
    );
  }
}
