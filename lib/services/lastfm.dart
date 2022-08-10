import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:collection/collection.dart';

class Artist {
  
  String name;
  int listeners;
  int playCount;
  String iconUrl;
  
  Artist({required this.name, required this.listeners, required this.playCount, required this.iconUrl});

  static Artist fromJSON(Map json) {
      String image = json['image'].elementAt(1)['#text'];
      int playcount = 0;
      if ( json['playcount'] != null ) {
          playcount  = int.parse( json['playcount'] );
        }
      return Artist(name: json['name'], listeners: int.parse(json['listeners']), playCount: playcount, iconUrl: image);
    }

  static List<Artist> fromJSONList(List jsonList) {
    return jsonList.map((a) => fromJSON(a)).toList();
  }

}

class Track {
    String name;
    int playCount;
    
    Track({ required this.name, required this.playCount});

    static Track fromJSON( Map json ) {
      return Track(name: json['name'], playCount: int.parse(json['playcount']));
    }


    static List<Track> listFromJSON( List jsonList ) {
    return jsonList.map((t) => fromJSON(t)).toList();
    }
}

class ArtistInfo {
    String name;
    int listeners;
    int playCount;
    String iconUrl;
    String bioSummary;

    List<Track>? topTracks;

    ArtistInfo({required this.name, required this.listeners, required this.playCount, required this.iconUrl, required this.bioSummary});

    static ArtistInfo fromJSON(Map json) {
        String image = json['image'].elementAt(1)['#text'];
        return ArtistInfo(name: json['name'], listeners: int.parse(json['stats']['listeners']), playCount: int.parse(json['stats']['playcount']), iconUrl: image, bioSummary: json['bio']['summary']);
    }

  }

class LastFM {

  final String _apiKey = 'f2d3f716c4ac4c0cb6f639c05dd36ca2';
  List<Artist> artists = [];
  List<Artist> searchResult = [];
  List<Track>? topTracks;
  late ArtistInfo details;

  LastFM();

  Future<void> getTopArtists() async {
    // make the request
    var url = Uri.http('ws.audioscrobbler.com', '/2.0/', {'method': 'chart.gettopartists', 'api_key': _apiKey, 'format': 'json'});

      // Await the http get response, then decode the json-formatted response.
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final Map jsonResponse =
            convert.jsonDecode(response.body);
        //print(jsonResponse['artists']['artist']);
        artists = Artist.fromJSONList( jsonResponse['artists']['artist'] );
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
  }

  Future<void> getArtistInfo(String name) async {
    // make the request
    var url = Uri.http('ws.audioscrobbler.com', '/2.0/', {'method': 'artist.getinfo', 'artist': name, 'api_key': _apiKey, 'format': 'json'});

      // Await the http get response, then decode the json-formatted response.
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final Map jsonResponse =
            convert.jsonDecode(response.body);
        //print(jsonResponse['artists']['artist']);
        details = ArtistInfo.fromJSON( jsonResponse['artist'] );
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
  }

  Future<void> getArtistTopTracks(String name) async {
    // make the request
    var url = Uri.http('ws.audioscrobbler.com', '/2.0/', {'method': 'artist.gettoptracks', 'artist': name, 'api_key': _apiKey, 'format': 'json'});

      // Await the http get response, then decode the json-formatted response.
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final Map jsonResponse =
            convert.jsonDecode(response.body);
        //print(jsonResponse['artists']['artist']);
        details.topTracks = Track.listFromJSON( jsonResponse['toptracks']['track'] );
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
  }

  Future<void> getTopTracks() async {
    // make the request
    var url = Uri.http('ws.audioscrobbler.com', '/2.0/', {'method': 'chart.gettoptracks', 'api_key': _apiKey, 'format': 'json'});

      // Await the http get response, then decode the json-formatted response.
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final Map jsonResponse =
            convert.jsonDecode(response.body);
        //print(jsonResponse['artists']['artist']);
        topTracks = Track.listFromJSON( jsonResponse['tracks']['track'] );
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
  }

  Future<void> search(String text) async {
    // make the request
    var url = Uri.http('ws.audioscrobbler.com', '/2.0/', {'method': 'artist.search', 'artist': text, 'api_key': _apiKey, 'format': 'json'});

      // Await the http get response, then decode the json-formatted response.
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final Map jsonResponse =
            convert.jsonDecode(response.body);
        //print(jsonResponse['artists']['artist']);
        print(jsonResponse['results']['artistmatches']['artist']);
        searchResult = Artist.fromJSONList( jsonResponse['results']['artistmatches']['artist'] );
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
  }

}
