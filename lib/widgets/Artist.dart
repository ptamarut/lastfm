import 'package:flutter/material.dart';
import 'package:lastfm/services/lastfm.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart' as intl;

class DetailArguments {
    final String name;

    DetailArguments(this.name);
}

class ArtistCard extends StatelessWidget {

  final Artist? artist;
  const ArtistCard({Key? key, this.artist }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedPlayCount = intl.NumberFormat.decimalPattern().format(artist?.playCount);
    final formattedListeners = intl.NumberFormat.decimalPattern().format(artist?.listeners);

    return GestureDetector( onTap: () {
        if ( artist != null && artist!.name != null ) Navigator.pushNamed(context, '/details', arguments: DetailArguments(artist!.name));
      },
    child: Card(
      margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Row( children: [
        Image.network(artist?.iconUrl ?? ""),
        Expanded(child: Column(children: [
          Padding(  
             padding: EdgeInsets.fromLTRB(0, 0, 0, 2),
             child: Text('${artist?.name}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),), ),
          artist?.playCount != 0 ? Text('${formattedPlayCount}') : Text("Artist"),
        ])),
        Padding( padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0), child: Column(children: [
          Padding(  
            padding: EdgeInsets.fromLTRB(0, 0, 0, 2),
            child: Text('Listeners:', style: TextStyle( color: Colors.grey ), ), ),
          Text('${formattedListeners}')
        ]) )
      ])
    ) );
  }
}

