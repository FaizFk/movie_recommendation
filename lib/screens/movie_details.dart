import 'package:flutter/material.dart';

class MovieDetails extends StatelessWidget {
  String? imageURL;
  String? movieName;
  String? movieDescription;

  MovieDetails({this.imageURL, this.movieDescription, this.movieName});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Expanded(
                  child: Center(
                    child: imageURL == null
                        ? Text('Cant Load Image')
                        : Image(
                            image: NetworkImage(
                                "https://image.tmdb.org/t/p/w500/$imageURL"),
                          ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '$movieName',
                  style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 30,
                      fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('$movieDescription'),
                SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
