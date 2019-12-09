import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/data_classes/movie_inner.dart';
import 'package:flutter_genesis_test/generated/i18n.dart';
import 'package:flutter_genesis_test/ui/ui_utils/handlers/error_handler.dart';

Future<void> showErrorMessage(BuildContext context, Exception exception) async {
  await Future<void>.microtask(() {
    Scaffold.of(context).showSnackBar(
      SnackBar(content: Text(handleError(exception))),
    );
  });
}

String validateTextAddOrRemove(MovieInner movieInner, BuildContext context) {
  if (movieInner.isFavorite) {
    return S.of(context).remove_from_favorite.toUpperCase();
  } else {
    return S.of(context).add_to_favorite.toUpperCase();
  }
}


