import 'package:bottom_nav/bottom_nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wardrobe/Screens/Navigation/add.dart';
import 'package:wardrobe/Screens/Navigation/feed.dart';
import 'package:wardrobe/Screens/Navigation/homePage.dart';
import 'package:wardrobe/Screens/Navigation/trending.dart';
import 'package:wardrobe/Screens/Sign_in.dart';
import 'package:wardrobe/config/size_config.dart';
import 'package:wardrobe/config/styles.dart';

class Home extends StatefulWidget {
  User user;
  Home({this.user});
  @override
  _HomeState createState() => _HomeState(user: this.user);
}

class _HomeState extends State<Home> {
  User user;
  _HomeState({this.user});
  List<Widget> _pages = [];
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
     _pages = [feed(user: this.user), homePage(), add(), trending()];
    if (user == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Sign_in()));
    }
   
  }

  Future<void> signOut() async {
    FirebaseAuth user = FirebaseAuth.instance;
    user.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Sign_in()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to Wardrobe",style: TextStyle(color: styles.appDarkVioletColor),),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              Icons.exit_to_app_outlined,
              color: Colors.red,
            ),
            onPressed: () {
              signOut();
            },
          )
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: SizedBox(
        height: SizeConfig.heightMultiplier*10,
        child: BottomNav(
          items: [
            BottomNavItem(
              icon: Icons.post_add,
              selectedColor: styles.appDarkVioletColor,
              label: 'Feed',
            ),
            BottomNavItem(
              icon: Icons.home,
              selectedColor: Colors.orange,
              label: 'Home',
            ),
            BottomNavItem(
              icon: Icons.add,
              selectedColor: Colors.green,
              label: 'Add',
            ),
            BottomNavItem(
              icon: Icons.trending_up,
              selectedColor: Colors.yellow,
              label: 'Trending',
            ),
          ],
          index: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
