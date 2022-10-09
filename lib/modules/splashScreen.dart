import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width *0.5,
              child: SvgPicture.asset(
                'assets/images/logo.svg',
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.5,
              ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: SvgPicture.asset(
                'assets/images/logo_text.svg',
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
        ],
      ),
     ),
    );
  }
}
