import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';

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
  List<String> _imglist = [];
  List<String> _imglist1 = [];
  List<String> _imglist2 = [];
  TextEditingController CategoryCTRL = TextEditingController();
  Map<String, List<String>> mData = Map();
  @override
  void initState() {
    super.initState();
    //fetchCategories();
    //fetchImages();
  }

  Future<void> fetchCategories() async {
    setState(() {
      categories.clear();
    });

    FirebaseDatabase.instance
        .reference()
        .child('Users')
        .child(user.uid)
        .child('Wardrobe')
        .once()
        .then((DataSnapshot data) {
      Map<dynamic, dynamic> categoriesData = data.value;
      categoriesData.forEach((key, value) {
        setState(() {
          categories.add(key);
        });
      });
    }).whenComplete(() {
      print("IMAGES");
      fetchImages();
    });
  }

  Future<void> fetchImages() async {
    setState(() {
      _imglist.clear();
    });
    if (categories.length > 0) {
      categories.forEach((element) {
        print("SEARCHING $element");
        FirebaseDatabase.instance
            .reference()
            .child('Users')
            .child(user.uid)
            .child('Wardrobe')
            .child(element)
            .child('images')
            .once()
            .then((DataSnapshot data) {
          Map<dynamic, dynamic> imagesData = data.value;
          imagesData.forEach((key, value) {
            setState(() {
              _imglist.add(value);
            });
          });
        });
        print(_imglist);
        mData.putIfAbsent(element, () => _imglist);
        setState(() {
          _imglist.clear();
        });
      });
    }
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
                _imglist.clear();
                categories.clear();
                int size;
                snapmap.forEach((key, value) {
                  categories.add(key);
                  print("KEY:${key}");
                  print("VALUES:${value['images']}");
                  FirebaseDatabase.instance
                      .reference()
                      .child("Users")
                      .child(user.uid)
                      .child('Wardrobe')
                      .child(key)
                      .child('images')
                      .once()
                      .then((DataSnapshot snap) {
                    size = snap.value.values.length;
                  });
                  
                });

                
                return ListView.builder(
                  //shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                        height: 200,
                        child: customPlaceHolder(
                            categories[index],
                            IconButton(
                              icon: Icon(Icons.menu),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    child: AlertDialog(
                                      title: Text("Action"),
                                      content: Container(
                                        height:
                                            SizeConfig.heightMultiplier * 6.5,
                                        child: Column(
                                          children: [
                                            InkWell(
                                              child: Text("Edit Name"),
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    child: AlertDialog(
                                                      title: Text("Edit Name"),
                                                      content: Container(
                                                        height: SizeConfig
                                                                .heightMultiplier *
                                                            6.5,
                                                        child: Column(
                                                          children: [
                                                            TextField(
                                                                controller:
                                                                    CategoryCTRL),
                                                            Visibility(
                                                                visible: CategoryCTRL
                                                                        .text !=
                                                                    categories[
                                                                        index],
                                                                child:
                                                                    RaisedButton(
                                                                  child: Text(
                                                                      "OK"),
                                                                  onPressed:
                                                                      () {
                                                                    FirebaseDatabase
                                                                        .instance
                                                                        .reference()
                                                                        .child(
                                                                            "Users")
                                                                        .child(user
                                                                            .uid)
                                                                        .child(
                                                                            'Wardrobe')
                                                                        .update(
                                                                            {});
                                                                  },
                                                                ))
                                                          ],
                                                        ),
                                                      ),
                                                    ));
                                              },
                                            ),
                                            InkWell(
                                              child: Text(
                                                "Delete Category",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              onTap: () {
                                                FirebaseDatabase.instance
                                                    .reference()
                                                    .child("Users")
                                                    .child(user.uid)
                                                    .child('Wardrobe')
                                                    .child(categories[index])
                                                    .remove();
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
                                print(categories[index]);
                              },
                            ),
                            mData,
                            size));
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

  
  Widget customPlaceHolder(String title, IconButton iconButton,
      Map<String, List<String>> data, int size) {
    Map<dynamic, dynamic> mapShot = Map();
    List<String> images = [];
    //Rprint("SIZE:$size");
    return Container(
      child: Column(
        children: [
          ListTile(
            title: Text(title),
            trailing: iconButton,
          ),
          FutureBuilder(
                  builder: (context, projectSnap) {
                    if (projectSnap.connectionState == ConnectionState.none &&
                        projectSnap.hasData == null) {
                      //print('project snapshot data is: ${projectSnap.data}');
                      return Text("No Data Found");
                    }
                    return 
                    Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return SizedBox(
                        height: SizeConfig.heightMultiplier * 20,
                        width: SizeConfig.widthMultiplier * 40,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: mapShot.values.length > 0
                                ? Image(
                                    image: NetworkImage(
                                        mapShot.values.elementAt(index)),
                                  )
                                : CircularProgressIndicator())
                        // child: Image(
                        //   image: NetworkImage(mData.values.elementAt(index)[index]),
                        // )),
                        );
              },
              // shrinkWrap: true,
              // physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
            ),
          );
                    
                  },
                  future: FirebaseDatabase.instance
                      .reference()
                      .child("Users")
                      .child(user.uid)
                      .child('Wardrobe')
                      .child(title)
                      .child('images')
                      .once()
                      .then((DataSnapshot shot) {
                    mapShot = shot.value;
                    for (int i = 0; i < mapShot.values.length; i++) {
                      //print("MAPSHOT=>${mapShot.values.elementAt(i)}");
                      images.add(mapShot.values.elementAt(i));
                    }
                  }),
                )
          
          //: CircularProgressIndicator(),
        ],
      ),
    );
  }
}
