import 'package:flutter/material.dart';
import 'package:lastfm/services/lastfm.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:lastfm/widgets/Artist.dart';
import 'package:lastfm/widgets/Track.dart';

class TopTracks extends StatefulWidget {
  const TopTracks({Key? key }) : super(key: key);
  @override
  _TopTracksState createState() => _TopTracksState();
}

class _TopTracksState extends State<TopTracks> {

  LastFM instance = LastFM();
  List<Track>? tracks;
  
  void getTopTracks() async {
      //print("Grabbing");
      await instance.getTopTracks();
      setState(() {
        tracks = instance.topTracks;
      });
    }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if ( tracks == null ) getTopTracks();
    return Scaffold(
      body: SafeArea(
        child: tracks == null ? SizedBox( width: double.infinity, child: Padding( padding: EdgeInsets.fromLTRB(0, 32, 0, 32), child: Text("Loading...", style: TextStyle(fontSize: 24, color: Colors.grey), textAlign: TextAlign.center,) ), ) : ListView(
          children: tracks!.map((t) => TrackCard(track: t)).toList(),
        ),
      ),
    );
  }
}

