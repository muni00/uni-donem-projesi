import 'package:flutter/material.dart';
import 'package:pencere_denetim/constants/color_constant.dart';
import 'package:pencere_denetim/screens/pages/customer_page.dart';
import 'package:pencere_denetim/screens/pages/register_page.dart';
import 'package:pencere_denetim/service/auth_service.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  AuthService _authService = AuthService();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildEmailTextField(),
        SizedBox(height: size.height * 0.02),
        buildPasswordTextField(),
        SizedBox(height: size.height * 0.06),
        buildInkWellGiris(context),
        SizedBox(height: size.height * 0.02),
        buildInkWellKayitOl(context)
      ],
    );
  }

  InkWell buildInkWellKayitOl(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
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
              "Kayıt ol",
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

  InkWell buildInkWellGiris(BuildContext context) {
    return InkWell(
      onTap: () {
        _authService.signIn(_emailController.text, _passwordController.text).then((value) {
          return Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerPage()));
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            border: Border.all(color: ColorConstants.instance.muskat, width: 2),
            //color: colorPrimaryShade,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Center(
              child: Text(
            "Giriş yap",
            style: TextStyle(
              color: ColorConstants.instance.muskat,
              fontSize: 20,
            ),
          )),
        ),
      ),
    );
  }

  TextField buildEmailTextField() {
    return TextField(
      controller: _emailController,
      style: TextStyle(
        color: ColorConstants.instance.muskat,
      ),
      cursorColor: ColorConstants.instance.muskat,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.email,
          color: ColorConstants.instance.nar,
        ),
        hintText: "E-mail",
        prefixText: " ",
        hintStyle: TextStyle(color: ColorConstants.instance.muskat),
        focusColor: ColorConstants.instance.muskat,
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorConstants.instance.muskat)),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorConstants.instance.muskat)),
      ),
    );
  }

  TextField buildPasswordTextField() {
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
}
