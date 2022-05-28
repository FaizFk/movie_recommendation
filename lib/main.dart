import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_recommendation/widgets/movie_card.dart';
import 'package:tmdb_api/tmdb_api.dart';

void main() {
  runApp(const MyApp());
}

String apiKey = "";
String accessToken = "";

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List movieData = ['A', 'B', 'C', 'D'];

  void getMovieData() async {
    final tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, accessToken),
      logConfig: ConfigLogger(
        showLogs: true, //must be true than only all other logs will be shown
        showErrorLogs: true,
      ),
    );
    Map result = await tmdbWithCustomLogs.v3.trending.getTrending();
    movieData = result['results'];
    print(movieData[1]);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMovieData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Trending Movies',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 40),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                  height: 270,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movieData.length,
                      itemBuilder: (context, int index) {
                        return MovieCard(
                          movieName: movieData[index]['name'] != null
                              ? movieData[index]['name'].toString()
                              : movieData[index]['original_title'].toString(),
                          imageURL: movieData[index]['poster_path'],
                        );
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
