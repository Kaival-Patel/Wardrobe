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
  List<String> categories = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddWardrobe(user: user),
              ));
        },
        child: Icon(Icons.add),
        backgroundColor: styles.appDarkVioletColor,
      ),
      body: Column(
        children: [
          Flexible(
              child: StreamBuilder(
            stream: FirebaseDatabase.instance
                .reference()
                .child("Users")
                .child(user.uid)
                .child('Wardrobe')
                .onValue,
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  !snapshot.hasError &&
                  snapshot.data.snapshot.value != null) {
                DataSnapshot snap = snapshot.data.snapshot;
                Map<dynamic, dynamic> snapmap = snap.value;
                categories.clear();
                List<String> _imglist = [];
                snapmap.forEach((key, value) {
                  categories.add(key);
                  print(key);
                  //print(value);
                });
                for (int i = 1; i < snapmap.values.length; i++) {
                  _imglist.add(snapmap.values.elementAt(i)['image']);
                  print(snapmap.values.elementAt(i)['image']);
                }
                return ListView.builder(
                  //shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                        height: 200,
                        child: customPlaceHolder(
                            categories[index],
                            IconButton(
                              icon: Icon(Icons.menu),
                              onPressed: () {},
                            ),
                            _imglist));
                  },
                  itemCount: categories.length,
                );
              } else {
                return Center(
                  child: Text("No Wardrobe Found!"),
                );
              }
            },
          )),
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

  Widget customPlaceHolder(@required String title,
      @required IconButton iconButton, @required List<String> _imglist) {
    return Container(
      child: Column(
        children: [
          ListTile(
            title: Text(title),
            trailing: iconButton,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return SizedBox(
                  height: SizeConfig.heightMultiplier * 20,
                  width: SizeConfig.widthMultiplier * 40,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(image: NetworkImage(_imglist[index])),
                  ),
                );
              },
              // shrinkWrap: true,
              // physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: _imglist.length,
            ),
          ),
        ],
      ),
    );
  }
}
