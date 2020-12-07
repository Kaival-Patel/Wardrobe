import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wardrobe/config/size_config.dart';
import 'package:wardrobe/config/styles.dart';
class SignUpBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier * 5,
          vertical: SizeConfig.heightMultiplier * 0.1),
      child: Container(
        child: AspectRatio(
          aspectRatio: 1.5,
          child: SizedBox(
              height: SizeConfig.heightMultiplier*20,
              width: SizeConfig.widthMultiplier*20,
              child: SvgPicture.asset(styles.signupBannerPath)
            ),
          // child: Image(
          //   image: AssetImage(AppTheme.loginBannerPath),
          // ),
        ),
      ),
    );
  }
}