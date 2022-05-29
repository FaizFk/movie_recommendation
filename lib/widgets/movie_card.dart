import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  String? movieName;
  String? imageURL;
  VoidCallback? onTap;
  MovieCard({this.movieName, this.imageURL, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 150,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.red[800]!, width: 2.0)),
          child: Column(
            children: [
              Container(
                child: imageURL != null
                    ? Image(
                        image: NetworkImage(
                            "https://image.tmdb.org/t/p/w500/$imageURL"),
                      )
                    : Text('Loading...'),
              ),
              Expanded(
                child: Container(
                  width: 150,
                  color: Colors.blue[800],
                  child: Center(
                      child: movieName != null
                          ? Text('$movieName')
                          : Text('Loading...')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
