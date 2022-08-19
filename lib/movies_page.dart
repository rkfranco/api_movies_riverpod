import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'movie_model.dart';
import 'movie_repository.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  MovieRepository repository = MovieRepository(Dio());
  late Future<List<MovieModel>> movies;

  @override
  void initState() {
    movies = repository.getAllMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    repository.getAllMovies();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
      ),
      body: Center(
        child: FutureBuilder(
          future: movies,
          builder: (context, AsyncSnapshot<List<MovieModel>> snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        snapshot.data![index].title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Hero(
                        tag: index,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      Hero(
                                tag: index,
                                child: GestureDetector(
                                  onTap: () => Navigator.of(context).pop(),
                                  child: Image.network(
                                    snapshot.data![index].movieBanner,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            ));
                          },
                          child: Image.network(
                            snapshot.data![index].image,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Data de lançamento: ${snapshot.data![index].releaseDate}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        title: const Text(
                          'Descrição:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          snapshot.data![index].description,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
