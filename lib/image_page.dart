import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'manager.dart';


class ImagePage extends StatefulWidget {
  final String link;

  ImagePage(String link) : link = link;

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  final double scaleUnit = 0.2;
  Image _imageToShow;
  double fixScale;

  @override
  void initState() {
    super.initState();

    fixScale = 1.0;
    _imageToShow = Image.network(
      addAccessPartOfUrl(widget.link),
      scale: fixScale,
    );
  }


  void _adjustImage(String url, double newScale) {
    setState(() {
      fixScale = newScale;
      _imageToShow = Image.network(
          url,
          scale: newScale,
        );
      print(fixScale);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back, color: Colors.black
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Picture"),
        // centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exposure_plus_2,
              color: Colors.black,
            ),
            onPressed: () {
              if (fixScale > 1.0) {
                _adjustImage(
                  addAccessPartOfUrl(widget.link),
                  fixScale - scaleUnit
                );
              }
            },
          ),
          IconButton(
            icon: Icon(
              Icons.exposure_minus_2,
              color: Colors.black,
            ),
            onPressed: () {
              if (fixScale < 3.0) {
                _adjustImage(
                  addAccessPartOfUrl(widget.link),
                  fixScale + scaleUnit
                );
              }
            },
          ),
          IconButton(
            icon: Icon(
              // Icons.favorite_sharp,
              Icons.favorite_outline_sharp,
              color: Colors.black,
            ),
            onPressed: () { /* via SharedPreferences */ }
          ),
        ],
      ),
      body: Center(
        child: _imageToShow,
      ),
    );
  }
}
