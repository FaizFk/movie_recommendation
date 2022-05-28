import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final String? movieName;
  final String? imageURL;
  MovieCard({this.movieName, this.imageURL});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.red[800]!, width: 2.0)),
        child: Column(
          children: [
            Container(
              child: Image(
                image:
                    NetworkImage("https://image.tmdb.org/t/p/w500/$imageURL"),
              ),
            ),
            Expanded(
              child: Expanded(
                child: Container(
                  width: 150,
                  color: Colors.blue[800],
                  child: Center(child: Text('$movieName')),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
