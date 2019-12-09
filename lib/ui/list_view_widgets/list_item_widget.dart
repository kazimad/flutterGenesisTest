import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/data_classes/movie_inner.dart';
import 'package:flutter_genesis_test/ui/list_view_widgets/source_tab.dart';
import 'package:flutter_genesis_test/ui/screens/movie_details_screen.dart';
import 'package:flutter_genesis_test/ui/utils/constants.dart';

import 'description_widget.dart';
import 'image_and_rating_widget.dart';

abstract class ListViewMovieItemWidget {}

class HeaderItemWidget extends Text implements ListViewMovieItemWidget {
  final String headerText;

  HeaderItemWidget(this.headerText) : super(headerText);
}

class RegularItemWidget extends StatelessWidget implements ListViewMovieItemWidget {
  final MovieInner movie;
  final SourceTab source;

  const RegularItemWidget({this.movie, this.source});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(margin8),
        child: GestureDetector(
          child: Card(
            elevation: movieCardElevation,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ImageAndRatingWidget(
                  movie: movie,
                ),
                DescriptionWidget(
                  movie: movie,
                  source: source,
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => MovieDetails(movieToDetail: movie)));
          },
        ),
      ),
    );
  }
}
