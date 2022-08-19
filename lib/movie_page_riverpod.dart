import 'package:flutter/material.dart';
import 'package:get_api_movies/movie_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MoviePageRiverpod extends HookConsumerWidget {
  const MoviePageRiverpod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final movies = ref.watch(movieProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Studio Ghibili'),
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    movies[index].title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Image.network(movies[index].image),
                ],
              ),
            ),
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return Scaffold(
                    appBar: AppBar(
                      title: Text(movies[index].title),
                    ),
                    body: Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(20)),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Description: ${movies[index].description}',
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Director: ${movies[index].director}',
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Producer: ${movies[index].producer}',
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Rating: ${movies[index].rtScore}',
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Launching date: ${movies[index].releaseDate}',
                            ),
                            const SizedBox(height: 10),
                            Image.network(movies[index].movieBanner),
                            Text(
                              'Running time: ${movies[index].runningTime} minutes',
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Original title: ${movies[index].originalTitle}/${movies[index].originalTitleRomanised}',
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ));
            },
          );
        },
      ),
    );
  }
}
