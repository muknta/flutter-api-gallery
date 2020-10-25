import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'post_data.dart';
import 'image_page.dart';
import 'manager.dart';


List<GestureDetector> imageBtnList(List<String> imageLinks, BuildContext context) {
  return imageLinks.map((link) => imageBtnByLink(link, context)).toList();
}

GestureDetector imageBtnByLink(String link, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ImagePage(link)),
      );
    },
    // behavior: HitTestBehavior.translucent,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Image.network(addAccessPartOfUrl(link)),
    ),
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
          child: Text("Rand"),
        ),
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: FutureBuilder<Album>(
        future: futureAlbum,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: ListView(
                children: imageBtnList(snapshot.data.imageLinks, context),
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
