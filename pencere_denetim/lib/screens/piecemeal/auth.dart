import 'package:flutter/material.dart';
import 'package:pencere_denetim/constants/color_constant.dart';
import 'package:pencere_denetim/screens/background_painter.dart';
import 'package:pencere_denetim/screens/pages/signin_page.dart';

//import 'package:window_create_mnb/screens/pages/signin_page.dart';
//import 'package:window_create_mnb/service/auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: CustomPaint(
              painter: BackgroundPainter(
                animation: _controller.view,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Padding(padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 50.0), child: theFrame(size)),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

Container theFrame(Size size) {
  return Container(
    margin: EdgeInsets.only(top: 200.0),
    height: size.height * .5,
    width: size.width * .85,
    decoration: BoxDecoration(
        color: ColorConstants.instance.toktok.withOpacity(.80),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [BoxShadow(color: ColorConstants.instance.toktok.withOpacity(.15), blurRadius: 10, spreadRadius: 2)]),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [SignInPage()],
        ),
      ),
    ),
  );
}
