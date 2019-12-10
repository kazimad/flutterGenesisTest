

class MovieApi {
  final int id;
  final double popularity;
  final int voteCount;
  final bool video;
  final String posterPath;
  final bool adult;
  final String backdropPath;
  final String originalLanguage;
  final String originalTitle;
  final String title;
  final String overview;
  final String releaseDate;

  MovieApi(
      {this.id,
      this.popularity,
      this.voteCount,
      this.video,
      this.posterPath,
      this.adult,
      this.backdropPath,
      this.originalLanguage,
      this.originalTitle,
      this.title,
      this.overview,
      this.releaseDate});

  factory MovieApi.fromJson(Map<String, dynamic> json) {
    return MovieApi(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      id: json['id'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      title: json['title'],
      video: json['video'],
      voteCount: json['vote_count'],
    );
  }
}
