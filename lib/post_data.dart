import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'manager.dart';


Future<Album> fetchAlbum() async {
  final response = await http.get(addAccessPartOfUrl(getPhotosAPI()));

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class Album {
  List<Photo> photoList;

  Album(List<Photo> photoList) {
  	this.photoList = photoList;
  }

  // List<Map<String, dynamic>> json
  factory Album.fromJson(List<dynamic> json) {
    // print(json);
    return Album(
    	json.map((q) => Photo(q['id'],
    												q['user']['username'],
    												q['description'],
    												q['urls']['raw'])).toList()
    );
  }
}


class Photo {
	String photoId, authorName, description, rawUrl;

	Photo(photoId, authorName, description, rawUrl) {
  	this.photoId = photoId;
  	this.authorName = authorName;
  	this.description = (description != null) ? description : 'no description';
  	this.rawUrl = rawUrl;
  }

	String urlWithWidth(int width) =>
		'${rawUrl}&w=${width}&q=80&fm=jpg&crop=entropy&cs=tinysrgb&fit=max';

	String urlWithMaxLength(int length) =>
		'${rawUrl}&w=${length}&h=${length}&q=80&fm=jpg&crop=entropy&cs=tinysrgb&fit=max';


}
