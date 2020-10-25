import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'manager.dart';


Future<Album> fetchAlbum() async {
  final response = await http.get(
    addAccessPartOfUrl('https://api.unsplash.com/photos')
    // 'https://api.unsplash.com/photos/random?count=${cnfg.imagesNum}/?client_id=${cnfg.unsplashToken}'
  );

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class Album {
  List<String> imageLinks;

  Album(List<String> imageLinks) {
  	this.imageLinks = imageLinks;
  }

  // List<Map<String, dynamic>> json
  factory Album.fromJson(List<dynamic> json) {
  	print('here JSONNN');
    print(json);


    return Album(
    	json.map((query) => query['urls']['small'].toString()).toList()
    );
  }
}
