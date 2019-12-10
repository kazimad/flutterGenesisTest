import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/data_classes/movie_inner.dart';
import 'package:flutter_genesis_test/ui/screens/movie_details_screen.dart';
import 'package:flutter_genesis_test/ui/ui_utils/constants.dart';
import 'package:flutter_genesis_test/ui/widgets/list_view_widgets/source_tab.dart';

import 'list_item_description_widget.dart';
import 'list_item_image_and_rating_widget.dart';

abstract class ListViewMovieItemWidget extends Widget {}

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
        padding: const EdgeInsets.all(8),
        child: GestureDetector(
          child: Card(
            elevation: movieCardElevation,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListItemImageAndRatingWidget(
                  movie: movie,
                ),
                ListItemDescriptionWidget(
                  movie: movie,
                  source: source,
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => MovieDetailsScreen(movieToDetail: movie)));
          },
        ),
      ),
    );
  }
}
