import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wardrobe/Screens/Home.dart';
import 'package:wardrobe/Screens/Sign_in.dart';
import 'package:wardrobe/config/size_config.dart';
import 'package:wardrobe/config/styles.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldkey;
  AnimationController scaleanimationController;
  Animation _scaleAmimation;
  void initState() {
    super.initState();
    _scaffoldkey = GlobalKey();
    scaleanimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    _scaleAmimation = CurvedAnimation(
        curve: Curves.bounceIn, parent: scaleanimationController);
    scaleanimationController.forward();
    startTimer();
  }

  void dispose() {
    super.dispose();
    scaleanimationController?.dispose();
  }

  startTimer() async {
    //timer duration
    var _duration = new Duration(milliseconds: 2500);
    return new Timer(_duration, navigateFurther);
  }

  void navigateFurther() async {
    FirebaseAuth user = FirebaseAuth.instance;
    if (user.currentUser == null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => Sign_in()));
    }
    else{
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => Home(user: user.currentUser,)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F7),
      key: _scaffoldkey,
      body: Center(
          child: SizedBox(
        height: SizeConfig.heightMultiplier * 50,
        width: SizeConfig.widthMultiplier * 80,
        child: FadeTransition(
          opacity: _scaleAmimation,
          child: Image(
            image: AssetImage(styles.wardrobeLogo),
          ),
        ),
      )),
    );
  }
}
