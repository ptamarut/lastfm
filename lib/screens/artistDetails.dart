import 'package:flutter/material.dart';
import 'package:lastfm/services/lastfm.dart';
import 'package:lastfm/widgets/Artist.dart';
import 'package:lastfm/widgets/Track.dart';
import 'package:intl/intl.dart' as intl;

class ArtistDetails extends StatefulWidget {
  const ArtistDetails({Key? key }) : super(key: key);

  @override
  _ArtistDetailsState createState() => _ArtistDetailsState();
}

class _ArtistDetailsState extends State<ArtistDetails> {
  
  LastFM instance = LastFM();
   ArtistInfo? details;

  void loadInfo( DetailArguments args ) async {

      await instance.getArtistInfo(args.name);
      await instance.getArtistTopTracks(args.name);
      setState(() {
        details = instance.details;
      });
    }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as DetailArguments;
    if ( details == null ) loadInfo(args);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('${args.name}'),
        centerTitle: true,
        elevation: 0,
      ),
      body: details == null ? SizedBox( width: double.infinity, child: Padding( padding: EdgeInsets.fromLTRB(0, 32, 0, 32), child: Text("Loading...", style: TextStyle(fontSize: 24, color: Colors.grey), textAlign: TextAlign.center,), ), ) : Center( child: Padding( padding: const EdgeInsets.all(8.0), child: Column(children: [
        Padding( padding: EdgeInsets.fromLTRB(0, 16, 0, 16), child: CircleAvatar(radius: 36, foregroundImage: NetworkImage(details!.iconUrl),), ),
        SizedBox( width: double.infinity, child: Text(details!.name, textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue[900] )) ),
        SizedBox( width: double.infinity, child: Padding( padding: EdgeInsets.fromLTRB(16, 16, 16, 16), child: Text(details!.bioSummary, textAlign: TextAlign.justify,) ), ),
        SizedBox( width: double.infinity, child: 
            Padding( padding: EdgeInsets.fromLTRB(16, 0, 16, 0), child: Row( children: [
                  Expanded( child: Text("Monthly listeners:", style: TextStyle(fontWeight: FontWeight.bold) ), ),
                  Text( "${intl.NumberFormat.decimalPattern().format(details!.listeners)}", textAlign: TextAlign.center,),
            ] ), ),
        ),
        Padding( padding: EdgeInsets.fromLTRB(0, 32, 0, 0), child: Text("Top Tracks:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), ),
        Expanded(
          child: SizedBox( 
            height: 200.0,
            child: ListView.builder(itemCount: details!.topTracks?.length, itemBuilder: ( context, index ) {
            return TrackCard(track: details!.topTracks![index]);
          },) ) ),
      ]) ) ) ,
    );
  }
}
