import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'utils/colors.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {

  File imageFile;

  _openGallery(BuildContext context) async{
    var picture = await ImagePicker.pickImage(source:ImageSource.gallery);
    this.setState((){
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }


  _openCamera(BuildContext context) async{
    var picture = await ImagePicker.pickImage(source:ImageSource.camera);
    this.setState((){
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  upload(BuildContext context, File imageFile) async {    
      // open a bytestream
      var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      // get file length
      var length = await imageFile.length();

      // string to uri
      var uri = Uri.parse("http://10.0.2.2:5001/predict");

      // create multipart request
      var request = new http.MultipartRequest("POST", uri);

      // multipart that takes file
      var multipartFile = new http.MultipartFile('file', stream, length,
          filename: basename(imageFile.path));

      // add file to multipart
      request.files.add(multipartFile);

      // send
      var response = await request.send();
      print(response.statusCode);

      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        _showAlert(context,value);
      });
    }

  Future <void> _showChoiceDialog(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text('Make a choice'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text('Gallery'),
                onTap: (){
                  // loadModel();
                  _openGallery(context);
                },
              ),
              Padding(padding: EdgeInsets.all(8.0),),
              GestureDetector(
                child: Text('Camera'),
                onTap: (){
                  _openCamera(context);
                },
              )
            ],
          ),
        ),
      );
    },);
  }

  Widget _decideImageView(){
    if(imageFile == null){
      return Text('No Image Selected');
    }
    else{
      return Image.file(imageFile,width:400,height:400);
    }
  }

    Widget _decideButton(BuildContext context){
    if(imageFile != null){
      return  RaisedButton(
              child: Text('Submit'),
              onPressed: (){
                upload(context, imageFile);
              }
      );
    }
    else{
      return Text('');
    }

  }

  void _showAlert(BuildContext context,value) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Result"),
            content: Text(value),
          )
      );
    }


    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Camera',
              textAlign: TextAlign.center,    
              style: TextStyle(color:Colors.white,
                            fontFamily: 'Poppins-Bold',
                            fontSize: 18,
                            letterSpacing: 1.0
              ),  
          ),
        ),
        backgroundColor:HexColor('#55113A'),
        automaticallyImplyLeading: false,
        ),
        body: Container(
          child: Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _decideImageView(),
                RaisedButton(onPressed: (){
                  _showChoiceDialog(context);
                },child: Text('Select Image'),),
                _decideButton(context)

              ],
            ),
          ),
        ),
      
    );
  }
}