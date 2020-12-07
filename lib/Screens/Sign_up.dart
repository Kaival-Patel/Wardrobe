import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:wardrobe/Screens/Home.dart';
import 'package:wardrobe/Screens/Sign_in.dart';
import 'package:wardrobe/components/SignupBanner.dart';
import 'package:wardrobe/components/centerBottomToast.dart';
import 'package:wardrobe/config/size_config.dart';
import 'package:wardrobe/config/styles.dart';

class Sign_up extends StatefulWidget {
  @override
  _Sign_upState createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  GlobalKey<FormState> _formkey = GlobalKey();
  TextEditingController nameCTRL = TextEditingController();
  TextEditingController emailCTRL = TextEditingController();
  TextEditingController pwdCTRL = TextEditingController();
  centerBottomToast cbt = centerBottomToast();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
          Padding(
            padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 3.5),
            child: SignUpBanner(),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.isMobilePortrait
                          ? SizeConfig.widthMultiplier * 8
                          : SizeConfig.widthMultiplier * 20,
                      vertical: SizeConfig.heightMultiplier * 0.1,
                    ),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Name",
                          style: TextStyle(
                              color: styles.appOrangeColor,
                              fontWeight: FontWeight.w600,
                              fontSize: SizeConfig.textMultiplier * 2.5),
                        )),
                  ),

                  //EMAIL FIELD
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 5,
                      vertical: SizeConfig.heightMultiplier * 0.1,
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
                            Icons.person,
                            color: Colors.grey,
                            size: SizeConfig.isMobilePortrait
                                ? SizeConfig.imageSizeMultiplier * 7.5
                                : SizeConfig.imageSizeMultiplier * 4,
                          ),
                          title: TextFormField(
                            autofocus: true,
                            autocorrect: true,
                            keyboardType: TextInputType.name,
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 2,
                                fontWeight: FontWeight.bold),
                            cursorColor: styles.appDarkVioletColor,
                            controller: nameCTRL,
                            onFieldSubmitted: (v) {
                              print("SUBMITTED EMAIL!!");
                              //FocusScope.of(context).requestFocus(focus);
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Martin Fox",
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //EMAIL LABEL
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.isMobilePortrait
                          ? SizeConfig.widthMultiplier * 8
                          : SizeConfig.widthMultiplier * 20,
                      vertical: SizeConfig.heightMultiplier * 0.1,
                    ),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Email",
                          style: TextStyle(
                              color: styles.appOrangeColor,
                              fontWeight: FontWeight.w600,
                              fontSize: SizeConfig.textMultiplier * 2.5),
                        )),
                  ),

                  //EMAIL FIELD
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 5,
                      vertical: SizeConfig.heightMultiplier * 0.5,
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
                            Icons.email_sharp,
                            color: Colors.grey,
                            size: SizeConfig.isMobilePortrait
                                ? SizeConfig.imageSizeMultiplier * 7.5
                                : SizeConfig.imageSizeMultiplier * 4,
                          ),
                          title: TextFormField(
                            autofocus: true,
                            autocorrect: true,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 2,
                                fontWeight: FontWeight.bold),
                            cursorColor: styles.appDarkVioletColor,
                            controller: emailCTRL,
                            onFieldSubmitted: (v) {
                              print("SUBMITTED EMAIL!!");
                              //FocusScope.of(context).requestFocus(focus);
                            },
                            validator: (value) {
                              // if (emailCTRL.text.isEmpty) {
                              //   cbt.showCenterFlash(
                              //     bgColor: Colors.white,
                              //     msgtext: "Please provide valid email!",
                              //     borderColor: Colors.red,
                              //     textColor: Colors.red,
                              //     duration: Duration(seconds: 3),
                              //     ctx: context,
                              //     alignment: Alignment.bottomCenter,
                              //   );
                              // }
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "abc@xyz.com",
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  //PWD LABEL
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.isMobilePortrait
                          ? SizeConfig.widthMultiplier * 8
                          : SizeConfig.widthMultiplier * 20,
                      vertical: SizeConfig.heightMultiplier * 1,
                    ),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Password",
                          style: TextStyle(
                              color: styles.appOrangeColor,
                              fontWeight: FontWeight.w600,
                              fontSize: SizeConfig.textMultiplier * 2.5),
                        )),
                  ),

                  //PWD FIELD
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 5,
                      vertical: SizeConfig.heightMultiplier * 0.1,
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
                            Icons.lock,
                            color: Colors.grey,
                            size: SizeConfig.isMobilePortrait
                                ? SizeConfig.imageSizeMultiplier * 7.5
                                : SizeConfig.imageSizeMultiplier * 4,
                          ),
                          title: TextFormField(
                            obscureText: true,
                            autofocus: true,
                            autocorrect: true,
                            keyboardType: TextInputType.visiblePassword,
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 2,
                                fontWeight: FontWeight.bold),
                            cursorColor: styles.appDarkVioletColor,
                            controller: pwdCTRL,
                            onFieldSubmitted: (v) {
                              print("SUBMITTED EMAIL!!");
                              //FocusScope.of(context).requestFocus(focus);
                            },
                            // validator: (value) {
                            //   if (pwdCTRL.text.isEmpty) {
                            //     cbt.showCenterFlash(
                            //       bgColor: Colors.white,
                            //       msgtext: "Please provide password!",
                            //       borderColor: Colors.red,
                            //       textColor: Colors.red,
                            //       duration: Duration(seconds: 3),
                            //       ctx: context,
                            //       alignment: Alignment.bottomCenter,
                            //     );
                            //   }
                            //   return;
                            // },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "***********",
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top:8.0),
                    //   child: TextFormField(

                    //     cursorColor: styles.appOrangeColor,
                    //     decoration: InputDecoration(
                    //       fillColor: styles.appLightVioletColor,
                    //       hintText: "abc@xyz.com",
                    //       hintStyle: TextStyle(color: Colors.grey,fontStyle: FontStyle.italic),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(3.0),
                    //         borderSide: BorderSide(
                    //           width: SizeConfig.widthMultiplier*0.5,
                    //           color: styles.appDarkVioletColor
                    //         )
                    //       ),
                    //       border:OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(3.0),
                    //         borderSide: BorderSide(
                    //           color: styles.appDarkVioletColor
                    //         )
                    //       ),
                    //     ),

                    //   ),
                    // )
                    //   ],
                    // ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 2),
            child: isLoading
                ? CircularProgressIndicator(backgroundColor: styles.appDarkVioletColor,)
                : GestureDetector(
                    onTap: () async {
                      if (emailCTRL.text.isEmpty ||
                          pwdCTRL.text.isEmpty ||
                          nameCTRL.text.isEmpty) {
                        cbt.showCenterFlash(
                          bgColor: Colors.red,
                          msgtext: "Please fill out the form properly!",
                          borderColor: Colors.red,
                          textColor: Colors.white,
                          duration: Duration(seconds: 3),
                          ctx: context,
                          alignment: Alignment.bottomCenter,
                        );
                        return;
                      }
                      try {
                        setState(() {
                          isLoading = true;
                        });
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .createUserWithEmailAndPassword(
                                email: emailCTRL.text, password: pwdCTRL.text);
                        userCredential.user
                            .updateProfile(displayName: nameCTRL.text);

                        if (userCredential.user != null) {
                          FirebaseDatabase.instance
                              .reference()
                              .child("Users")
                              .child(userCredential.user.uid)
                              .child('Profile')
                              .set({
                            'name': nameCTRL.text,
                            'email': emailCTRL.text,
                          }).then((value) {
                            print("SAVED");
                          }).catchError((onError) {
                            cbt.showCenterFlash(
                              bgColor: Colors.red,
                              msgtext: "Error adding you into our Database!",
                              borderColor: Colors.red,
                              textColor: Colors.white,
                              duration: Duration(seconds: 5),
                              ctx: context,
                              alignment: Alignment.bottomCenter,
                            );
                          });
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Home(user: userCredential.user)));
                        }
                      } catch (error) {
                        setState(() {
                          isLoading = false;
                        });
                        print("${error.code}");
                        cbt.showCenterFlash(
                          bgColor: Colors.red,
                          msgtext: "Error Registering into our Database!",
                          borderColor: Colors.red,
                          textColor: Colors.white,
                          duration: Duration(seconds: 5),
                          ctx: context,
                          alignment: Alignment.bottomCenter,
                        );
                      }

                      print("SIGN UP");
                    },
                    child: Container(
                      height: SizeConfig.heightMultiplier * 7,
                      width: SizeConfig.widthMultiplier * 70,
                      decoration: BoxDecoration(
                          color: styles.appDarkVioletColor,
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Center(
                        child: ListTile(
                          trailing: Padding(
                            padding: EdgeInsets.only(
                                bottom: SizeConfig.heightMultiplier * 0.7),
                            child: Icon(
                              Icons.arrow_right_alt_outlined,
                              color: Colors.white,
                            ),
                          ),
                          title: Padding(
                            padding: EdgeInsets.only(
                                bottom: SizeConfig.heightMultiplier * 0.7),
                            child: Center(
                                child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: SizeConfig.textMultiplier * 3),
                            )),
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
          Padding(
            padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 2),
            child: Text(
              "Gone through this?",
              style: TextStyle(fontSize: SizeConfig.textMultiplier * 1.5),
            ),
          ),
          InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Sign_in()));
              },
              child: Text(
                "Sign In",
                style: TextStyle(
                    fontSize: SizeConfig.textMultiplier * 1.8,
                    decoration: TextDecoration.underline,
                    color: styles.appOrangeColor),
              )),
        ])));
  }
}
