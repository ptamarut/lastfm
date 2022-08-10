import 'package:flutter/material.dart';
import 'package:lastfm/services/lastfm.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:lastfm/widgets/Artist.dart';

class TopArtists extends StatefulWidget {
  const TopArtists({Key? key }) : super(key: key);
  @override
  _TopArtistsState createState() => _TopArtistsState();
}

class _TopArtistsState extends State<TopArtists> {

  LastFM instance = LastFM();
  List<Artist> artists = [];
  
  void getTopArtists() async {
      //print("Grabbing");
      await instance.getTopArtists();
      setState(() {
        artists = instance.artists;
      });
    }

  @override
  void initState() {
    super.initState();
    getTopArtists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: artists.map((a) => ArtistCard(artist: a)).toList(),
        ),
      ),
    );
  }
}
