import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController imageTxtController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Image Downloder"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: imageTxtController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Image Link",
              ),
            ),
            SizedBox(height: 20),
            FlatButton(
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () {
                getDownloadImg(myImage: imageTxtController.text);
              },
              child: Text("Download"),
            ),
          ],
        ),
      ),
    );
  }

  getDownloadImg({var myImage}) async {
    await ImageDownloader.downloadImage(
      myImage,
    ).then((_) {
      FocusScope.of(context).unfocus();
      imageTxtController.clear();
      _showSnackBar(
          message: "Image Downloaded Successfully", color: Colors.blue);
    });
  }

  _showSnackBar({String message, Color color}) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 3),
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: color,
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
