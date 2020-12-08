//import 'package:firebase/firebase.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:uuid/uuid.dart';
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
  String category = "Select Category";
  List<String> categories = [];
  String error = 'No Error Dectected';
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  TextEditingController categoryCTRL = TextEditingController();
  DatabaseReference dbref;
  bool isUploading = false;
  @override
  void initState() {
    super.initState();
    dbref = FirebaseDatabase.instance
        .reference()
        .child('Users')
        .child(user.uid)
        .child("Wardrobe");
    fetchCategories();
  }

  Future<void> fetchCategories() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 5),
            child: Text("Upload the Wardrobe Pictures"),
          ),

          Padding(
            padding: EdgeInsets.all(SizeConfig.imageSizeMultiplier * 2),
            child: RaisedButton(
              child: Text(
                _images.length > 0 ? "Add more" : "Select Pictures",
                style: TextStyle(color: Colors.white),
              ),
              color: styles.appDarkVioletColor,
              onPressed: () async {
                await pickImages();
              },
            ),
          ),
          // Container(
          //   child:_images.length>0?Image.file(_images[1]):Text("Select")
          // ),
          Expanded(
              flex: 3,
              child: _images.length > 0
                  ? GridView.count(
                      crossAxisCount: 3,
                      children: List.generate(
                          _images.length,
                          (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                        height: 60,
                                        width: 60,
                                        child: Image.file(_images[index])),
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _images.removeAt(index);
                                        });
                                      },
                                    )
                                  ],
                                ),
                              )),
                    )
                  : Container()),
          Expanded(
            flex: 2,
            child: Padding(
                padding: EdgeInsets.all(SizeConfig.imageSizeMultiplier * 2),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: SizeConfig.heightMultiplier * 5),
                      child: Text("Select the Category"),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.all(SizeConfig.imageSizeMultiplier * 2),
                      child: RaisedButton(
                        child: Text(
                          "Add Category",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: styles.appDarkVioletColor,
                        onPressed: () async {
                          showDialog(
                              context: context,
                              child: Container(
                                height: 100,
                                child: AlertDialog(
                                  content: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          SizeConfig.widthMultiplier * 5,
                                      vertical:
                                          SizeConfig.heightMultiplier * 0.1,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: styles.appFormLightVioletColor,
                                      ),
                                      height: SizeConfig.isMobilePortrait
                                          ? SizeConfig.heightMultiplier * 8
                                          : SizeConfig.heightMultiplier * 5,
                                      width: SizeConfig.isMobilePortrait
                                          ? SizeConfig.widthMultiplier * 80
                                          : SizeConfig.widthMultiplier * 60,
                                      child: Center(
                                        child: ListTile(
                                          leading: Icon(
                                            Icons.shopping_bag_outlined,
                                            color: Colors.grey,
                                            size: SizeConfig.isMobilePortrait
                                                ? SizeConfig
                                                        .imageSizeMultiplier *
                                                    7.5
                                                : SizeConfig
                                                        .imageSizeMultiplier *
                                                    4,
                                          ),
                                          title: TextFormField(
                                            autofocus: true,
                                            autocorrect: true,
                                            keyboardType: TextInputType.text,
                                            style: TextStyle(
                                                fontSize:
                                                    SizeConfig.textMultiplier *
                                                        2,
                                                fontWeight: FontWeight.bold),
                                            cursorColor:
                                                styles.appDarkVioletColor,
                                            controller: categoryCTRL,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Bottomwear",
                                              hintStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: Text("Add Category"),
                                  actions: [
                                    ButtonBar(
                                      children: [
                                        RaisedButton(
                                          child: Text("Add"),
                                          onPressed: () async {
                                            //TODO: ADD CATEGORY
                                            dbref.child(categoryCTRL.text).set({
                                              'created_at': DateTime.now()
                                                  .millisecondsSinceEpoch
                                            }).then((value) {
                                              _scaffoldkey.currentState
                                                  .showSnackBar(SnackBar(
                                                content: Text("Category Added"),
                                              ));
                                              Navigator.pop(context);
                                            }).catchError((onError) =>
                                                _scaffoldkey.currentState
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Error Adding Category"),
                                                )));
                                          },
                                          color: styles.appOrangeColor,
                                        ),
                                        RaisedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Cancel"),
                                          color: Colors.grey,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ));
                        },
                      ),
                    ),
                    Flexible(
                      child: StreamBuilder(
                        stream: FirebaseDatabase.instance
                            .reference()
                            .child('Users')
                            .child(user.uid)
                            .child('Wardrobe')
                            .onValue,
                        builder: (context, snapshot) {
                          if (snapshot.hasData &&
                              !snapshot.hasError &&
                              snapshot.data.snapshot.value != null) {
                            categories.clear();
                            DataSnapshot dataSnapShot = snapshot.data.snapshot;
                            Map<dynamic, dynamic> snapmap = dataSnapShot.value;
                            snapmap.forEach((key, value) {
                              categories.add(key);
                            });
                            return DropdownButton<String>(
                              onChanged: (String value) {
                                setState(() {
                                  category = value;
                                });
                              },
                              hint: Text(category),
                              items: categories.map(
                                (String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                },
                              ).toList(),
                            );
                          } else {
                            return DropdownButton<String>(
                              onChanged: (String value) {
                                setState(() {
                                  category = value;
                                });
                              },
                              hint: Text("No Categories found"),
                              items: categories.map(
                                (String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                },
                              ).toList(),
                            );
                          }
                        },
                      ),
                    ),
                    isUploading
                        ? CircularProgressIndicator()
                        : GestureDetector(
                            onTap: () {
                              uploadFilesToStorage();
                            },
                            child: Container(
                              height: SizeConfig.heightMultiplier * 7,
                              width: SizeConfig.widthMultiplier * 60,
                              decoration: BoxDecoration(
                                  color: styles.appOrangeColor,
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Center(
                                child: ListTile(
                                  trailing: Padding(
                                    padding: EdgeInsets.only(
                                        bottom:
                                            SizeConfig.heightMultiplier * 0.5),
                                    child: Icon(
                                      Icons.arrow_right_alt_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                  title: Padding(
                                    padding: EdgeInsets.only(
                                        bottom:
                                            SizeConfig.heightMultiplier * 0.5),
                                    child: Center(
                                        child: Text(
                                      "Upload",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              SizeConfig.textMultiplier * 3),
                                    )),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Future<void> uploadFilesToStorage() async {
    setState(() {
      isUploading = true;
    });
    for (int i = 0; i < _images.length; i++) {
      String downloadURL = "";
      String uuid = Uuid().v4();
      try {
        Reference firebaseStorageRef =
            FirebaseStorage.instance.ref().child('uploads/${_images[i].path}');
        TaskSnapshot uploadTask =
            await firebaseStorageRef.putFile(_images[i]).whenComplete(() async {
          downloadURL = await firebaseStorageRef.getDownloadURL();
          dbref.child(category).child('images').update({
            uuid: '$downloadURL',
          }).then((value) {
            _scaffoldkey.currentState.showSnackBar(SnackBar(
                content: Text(
                    "Successfully uploaded to our db ${i + 1}/${_images.length}!")));
          });
          print("DOWNLOAD URL:$downloadURL");
          _scaffoldkey.currentState.showSnackBar(SnackBar(
              content: Text("Uploaded file ${i + 1}/${_images.length}!")));
        });
      } catch (e) {
        print("error:$e");
        _scaffoldkey.currentState.showSnackBar(
            SnackBar(content: Text("Error Uploading the Data,Try Later!")));
      }
      uuid = "";
    }
    setState(() {
      isUploading = false;
    });
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
