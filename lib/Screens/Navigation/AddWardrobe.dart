import 'package:flutter/material.dart';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:wardrobe/config/size_config.dart';
import 'package:wardrobe/config/styles.dart';

class AddWardrobe extends StatefulWidget {
  User user;
  AddWardrobe({this.user});
  @override
  _AddWardrobeState createState() => _AddWardrobeState(user: this.user);
}

class _AddWardrobeState extends State<AddWardrobe> {
  User user;
  _AddWardrobeState({this.user});
  List<File> _images = [];
  String error = 'No Error Dectected';
  @override
  void initState() {
    super.initState();
    DatabaseReference dbref = FirebaseDatabase.instance
        .reference()
        .child('Users')
        .child(user.uid)
        .child("Wardrobe");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top:SizeConfig.heightMultiplier * 5),
              child: Text("Upload the Wardrobe Pictures"),
            ),
            Padding(
              padding: EdgeInsets.all(SizeConfig.imageSizeMultiplier * 2),
              child: RaisedButton(
                child: Text(
                  _images.length > 0 ? "Select Pictures" : "Add more",
                  style: TextStyle(color: Colors.white),
                ),
                color: styles.appDarkVioletColor,
                onPressed: () async {
                  await pickImages();
                },
              ),
            ),
            Container(
              _images[0]==null?Text("Select"):Image.file(_images[0])
            )
            // Padding(
            //     padding: EdgeInsets.all(SizeConfig.imageSizeMultiplier * 2),
            //     child: _images.length > 0
            //         ? ListView.builder(
            //             itemBuilder: (context, index) => SizedBox(
            //               height: 50,
            //               width: 50,
            //               child: Image.file(_images[index]),
            //             ),
            //             itemCount: _images.length,
            //           )
            //         : Container()),
            Padding(
                padding: EdgeInsets.all(SizeConfig.imageSizeMultiplier * 2),
                child: DropdownButton<String>(
                  onChanged: (value) => print(value),
                  items: <String>['A', 'B', 'C', 'D'].map(
                    (String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    },
                  ).toList(),
                )),
          ],
        ),
      ),
    );
  }

  Future<void> pickImages() async {
    File _image;
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _images.add(File(pickedFile.path));
      }
    });
  }
}
