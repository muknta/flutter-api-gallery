import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'post_data.dart';
import 'image_page.dart';
import 'manager.dart';

final int listImageWidth = 200;
final int fullImageWidth = 500;


List<Widget> imageList(List<Photo> photoList, BuildContext context) {
  return photoList.map((photoObj) => imageBlock(photoObj, context)).toList();
}

Widget imageBlock(Photo photoObj, BuildContext context) {
  String author = photoObj.authorName;
  String desc = photoObj.description;
  String link = photoObj.urlWithMaxLength(listImageWidth);

  return Column(
    children: <Widget>[
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>
              ImagePage(photoObj.urlWithWidth(fullImageWidth))),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Image.network(addAccessPartOfUrl(link)),
        ),
      ),
      Text(
        author,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text(desc),
    ],
  );
}


void main() => runApp(GalleryApp());


class GalleryApp extends StatelessWidget {
  final String _title = "Unsplash Actual Gallery";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(title: _title),
    );
  }
}


class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            setState(() {
              futureAlbum = fetchAlbum();
            });
          },
          child: Container(
            padding: const EdgeInsets.only(left: 3.0, top: 20.0),
            child: Text("Update"),
          ),
        ),
        title: Text(widget.title),
      ),
      body: FutureBuilder<Album>(
        future: futureAlbum,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Widget> someWidg = imageList(snapshot.data.photoList, context);

            return Center(
              child: StaggeredGridView.count(
                primary: false,
                // padding: const EdgeInsets.only(left: 10, top: 10),
                crossAxisCount: 4,
                staggeredTiles: someWidg.map<StaggeredTile>((_) => StaggeredTile.fit(2))
                    .toList(),
                mainAxisSpacing: 3.0,
                crossAxisSpacing: 4.0,
                children: someWidg,
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(
            child: CircularProgressIndicator());
        },
      ),
    );
  }
}
