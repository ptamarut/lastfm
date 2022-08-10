import 'package:flutter/material.dart';
import 'package:lastfm/services/lastfm.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart' as intl;

class TrackCard extends StatelessWidget {

  final Track? track;
  const TrackCard({Key? key, this.track }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatPlayCount = intl.NumberFormat.decimalPattern().format(track?.playCount);
    return Card(
      margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Padding( padding: EdgeInsets.fromLTRB(16, 16, 16, 16),child: Row( children: [
          Expanded( child: Text('${track?.name}', style: TextStyle( fontSize: 14, fontWeight: FontWeight.bold )), ),
          Text('${formatPlayCount}')
      ]) )
    );
  }
}


