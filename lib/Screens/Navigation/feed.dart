import 'dart:io';
import 'AddWardrobe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:wardrobe/config/size_config.dart';
import 'package:wardrobe/config/styles.dart';

class feed extends StatefulWidget {
  User user;
  feed({this.user});
  @override
  _feedState createState() => _feedState(user: this.user);
}

class _feedState extends State<feed> {
  User user;
  _feedState({this.user});
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final result = Navigator.push(context, MaterialPageRoute(
            builder: (context) => AddWardrobe(user:user),
          ));
        },
        child: Icon(Icons.add),
        backgroundColor: styles.appDarkVioletColor,
      ),
      body: Column(
        children: [
          Center(
            child: Text("Hello"),
          )
        ],
      ),
    );
  }

  // Future<void> showAddWardrobe() async {
  //   DatabaseReference dbref = FirebaseDatabase.instance
  //       .reference()
  //       .child('Users')
  //       .child(user.uid)
  //       .child("Wardrobe");
  //   showDialog(
  //       context: context,
  //       barrierDismissible: true,
  //       child: Container(
  //         height: SizeConfig.heightMultiplier * 90,
  //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.0)),
  //         child: AlertDialog(
  //             content: SingleChildScrollView(
  //           child: Column(
  //             children: [
  //               Padding(
  //                 padding: EdgeInsets.all(SizeConfig.imageSizeMultiplier * 2),
  //                 child: Text("Upload the Wardrobe Pictures"),
  //               ),
  //               Padding(
  //                 padding: EdgeInsets.all(SizeConfig.imageSizeMultiplier * 2),
  //                 child: RaisedButton(
  //                   child: Text(
  //                     _images.length > 0?"Select Pictures":"Add more",
  //                     style: TextStyle(color: Colors.white),
  //                   ),
  //                   color: styles.appDarkVioletColor,
  //                   onPressed: () async {
  //                     await pickImages();
  //                   },
  //                 ),
  //               ),
  //               Padding(
  //                   padding: EdgeInsets.all(SizeConfig.imageSizeMultiplier * 2),
  //                   child: _images.length > 0
  //                       ? ListView.builder(
  //                         itemBuilder:(context,index)=>SizedBox(height: 50,width: 50,child: Image.file(_images[index]),),
  //                         itemCount: _images.length,
  //                         )
  //                       : Container()),
  //               Padding(
  //                   padding: EdgeInsets.all(SizeConfig.imageSizeMultiplier * 2),
  //                   child: DropdownButton<String>(
  //                     onChanged: (value) => print(value),
  //                     items: <String>['A', 'B', 'C', 'D'].map(
  //                       (String value) {
  //                         return new DropdownMenuItem<String>(
  //                           value: value,
  //                           child: new Text(value),
  //                         );
  //                       },
  //                     ).toList(),
  //                   )),
  //             ],
  //           ),
  //         )),
  //       ));
  // }

  // Future<void> pickImages() async {
  //   File _image;
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);
  //   setState(() {
  //     if (pickedFile != null) {
  //       _images.add(File(pickedFile.path));
  //     }
  //   });
  // }

  Future<void> loadAssets() async {
    // try {
    //   resultList = await MultiImagePicker.pickImages(
    //     maxImages: 300,
    //     enableCamera: true,
    //     selectedAssets: images,
    //     cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
    //     materialOptions: MaterialOptions(
    //       actionBarColor: "#FFA600",
    //       actionBarTitle: "Wardrobe",
    //       allViewTitle: "All Photos",
    //       useDetailsView: false,
    //       selectCircleStrokeColor: "#423B7E",
    //     ),
    //   );
    // } on Exception catch (e) {
    //   error = e.toString();
    // }

    // // If the widget was removed from the tree while the asynchronous platform
    // // message was in flight, we want to discard the reply rather than calling
    // // setState to update our non-existent appearance.
    // if (!mounted) return;

    // setState(() {
    //   images = resultList;
    //   //error = error;
    // });
  }
}
