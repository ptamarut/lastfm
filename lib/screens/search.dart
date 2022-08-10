import 'package:flutter/material.dart';
import 'package:lastfm/services/lastfm.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:lastfm/widgets/Artist.dart';

class Search extends StatefulWidget {
  const Search({Key? key }) : super(key: key);
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  LastFM instance = LastFM();
  List<Artist>? artists;
  final controller = TextEditingController();

  void searchAPI( ) async {
      await instance.search(controller.text);
      setState(() {
        artists = instance.searchResult;
      });
    }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField( decoration: InputDecoration(contentPadding: EdgeInsets.all(8), hintText: "Search for artists..."),controller: controller, onChanged: (text) => searchAPI(),),
            artists == null || artists?.length == 0 ? Padding( padding: EdgeInsets.fromLTRB(0, 24, 0, 0), child: Text("No Results", style: TextStyle( fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red )) ) : Expanded(
              child: SizedBox( height: 200, child: ListView(
              children: artists!.map((a) => ArtistCard(artist: a)).toList(),
            ) ) ),
          ]
        )
      ),
    );
  }
}
