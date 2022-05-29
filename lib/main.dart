import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:movie_recommendation/screens/movie_details.dart';
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
  bool isSpinning = false;

  void getMovieData() async {
    final tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, accessToken),
      logConfig: ConfigLogger(
        showLogs: true, //must be true than only all other logs will be shown
        showErrorLogs: true,
      ),
    );
    Map result;
    try {
      setState(() {
        isSpinning = true;
      });

      result = await tmdbWithCustomLogs.v3.trending.getTrending();
      setState(() {
        isSpinning = false;
      });
      movieData = result['results'];
      print(movieData[2]);
    } catch (e) {
      print("Errrrrrrrrrrrrrrorrrrrrrrrrrrrr");
    }
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
        body: ModalProgressHUD(
          inAsyncCall: isSpinning,
          child: SafeArea(
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
                                ? movieData[index]['name']
                                : (movieData[index]['original_name'] != null
                                    ? movieData[index]['original_name']
                                    : movieData[index]['title']),
                            imageURL: movieData[index]['poster_path'],
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetails(
                                      imageURL: movieData[index]['poster_path'],
                                      movieName:
                                          movieData[index]['name'] != null
                                              ? movieData[index]['name']
                                              : (movieData[index]
                                                          ['original_name'] !=
                                                      null
                                                  ? movieData[index]
                                                      ['original_name']
                                                  : movieData[index]['title']),
                                      movieDescription: movieData[index]
                                          ['overview'],
                                    ),
                                  ));
                            },
                          );
                        })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
