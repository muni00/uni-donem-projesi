import 'package:flutter/material.dart';
import 'package:pencere_denetim/constants/color_constant.dart';
import 'package:pencere_denetim/screens/background_painter.dart';
import 'package:pencere_denetim/screens/piecemeal/auth.dart';
import 'package:pencere_denetim/service/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordAgainController = TextEditingController();

  AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordAgainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(children: [
      SizedBox.expand(
        child: CustomPaint(
          painter: BackgroundPainter(
            animation: _controller.view,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Stack(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: theFrame(size),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ]));
  }

  Container theFrame(Size size) {
    return Container(
      margin: EdgeInsets.only(top: 70.0),
      height: size.height * .7,
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
            children: [
              adGiris(),
              satirAtla(size, 0.02),
              emailGiris(),
              satirAtla(size, 0.02),
              parolaGiris(),
              satirAtla(size, 0.02),
              parolaTekrarGiris(),
              satirAtla(size, 0.08),
              kaydetButton(),
              satirAtla(size, 0.02),
              buildInkWellKayitOl(context),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox satirAtla(Size size, var olcu) {
    return SizedBox(
      height: size.height * olcu,
    );
  }

  InkWell kaydetButton() {
    return InkWell(
      onTap: () {
        _authService.createPerson(_nameController.text, _emailController.text, _passwordController.text).then((value) {
          return Navigator.push(context, MaterialPageRoute(builder: (context) => AuthScreen()));
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration:
            BoxDecoration(border: Border.all(color: ColorConstants.instance.muskat, width: 2), borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Center(
              child: Text(
            "Kaydet",
            style: TextStyle(
              color: ColorConstants.instance.muskat,
              fontSize: 20,
            ),
          )),
        ),
      ),
    );
  }

  InkWell buildInkWellKayitOl(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AuthScreen()));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 1,
              width: 75,
              color: ColorConstants.instance.muskat,
            ),
            Text(
              "Giris Yap",
              style: TextStyle(color: ColorConstants.instance.muskat),
            ),
            Container(
              height: 1,
              width: 75,
              color: ColorConstants.instance.muskat,
            ),
          ],
        ));
  }

  TextField parolaTekrarGiris() {
    return TextField(
        style: TextStyle(
          color: ColorConstants.instance.muskat,
        ),
        cursorColor: ColorConstants.instance.muskat,
        controller: _passwordAgainController,
        obscureText: true,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.vpn_key,
            color: ColorConstants.instance.nar,
          ),
          hintText: 'Parola Tekrar',
          prefixText: ' ',
          hintStyle: TextStyle(color: ColorConstants.instance.muskat),
          focusColor: ColorConstants.instance.muskat,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: ColorConstants.instance.muskat,
          )),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: ColorConstants.instance.muskat,
          )),
        ));
  }

  TextField parolaGiris() {
    return TextField(
        style: TextStyle(
          color: ColorConstants.instance.muskat,
        ),
        cursorColor: ColorConstants.instance.muskat,
        controller: _passwordController,
        obscureText: true,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.vpn_key,
            color: ColorConstants.instance.nar,
          ),
          hintText: 'Parola',
          prefixText: ' ',
          hintStyle: TextStyle(color: ColorConstants.instance.muskat),
          focusColor: ColorConstants.instance.muskat,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: ColorConstants.instance.muskat,
          )),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: ColorConstants.instance.muskat,
          )),
        ));
  }

  TextField emailGiris() {
    return TextField(
        controller: _emailController,
        style: TextStyle(
          color: Colors.white,
        ),
        cursorColor: Colors.white,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.mail,
            color: ColorConstants.instance.nar,
          ),
          hintText: 'E-Mail',
          prefixText: ' ',
          hintStyle: TextStyle(color: Colors.white),
          focusColor: Colors.white,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: Colors.white,
          )),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: Colors.white,
          )),
        ));
  }

  TextField adGiris() {
    return TextField(
        controller: _nameController,
        style: TextStyle(
          color: ColorConstants.instance.muskat,
        ),
        cursorColor: ColorConstants.instance.muskat,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.person,
            color: ColorConstants.instance.nar,
          ),
          hintText: 'Kullanıcı adı',
          prefixText: ' ',
          hintStyle: TextStyle(color: ColorConstants.instance.muskat),
          focusColor: ColorConstants.instance.muskat,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: ColorConstants.instance.muskat,
          )),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: ColorConstants.instance.muskat,
          )),
        ));
  }
}
