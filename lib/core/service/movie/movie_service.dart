import 'package:comenta_ai/core/models/movie.dart';
import 'package:comenta_ai/core/service/movie/movie_data_service.dart';

abstract class MovieService {
  Stream<List<Movie>> movieStream();
  Stream<List<Movie>> searchStream();
  Stream<List<Movie>> popularStream();

  Future<void> loadMovies();

  Future<void> searchMovie(String query);

  Future<void> popularMovie();

  factory MovieService() {
    return MovieDataService();
  }
}
