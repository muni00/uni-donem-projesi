import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pencere_denetim/constants/color_constant.dart';
import 'package:pencere_denetim/screens/pages/catalog_page.dart';
import 'package:pencere_denetim/screens/pages/customer_page.dart';
import 'package:pencere_denetim/screens/piecemeal/cp_customer.dart';
import 'package:pencere_denetim/service/auth_service.dart';

class InformationPage extends StatefulWidget {
  final String imgPath, windowName, pricePerItem, heroTag;
  final int brFiyat;
  InformationPage({this.imgPath, this.windowName, this.pricePerItem, this.heroTag, this.brFiyat});

  @override
  _InformationPageState createState() => _InformationPageState();
}

enum SingingCharacter { yes, no }
enum ColorCharacter { brown, ice }
enum TypeCharacter { one, two }
enum StyleCharacter { blurred, straight }

class _InformationPageState extends State<InformationPage> {
  SingingCharacter _character = SingingCharacter.yes;
  ColorCharacter _characterColor = ColorCharacter.brown;
  TypeCharacter _characterType = TypeCharacter.one;
  StyleCharacter _characterStyle = StyleCharacter.blurred;

  var frUser = FirebaseAuth.instance.currentUser;
  AuthService _authService = AuthService();

  final TextEditingController _yukseklik = TextEditingController(text: "");
  final TextEditingController _genislik = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          _appBar(size), //SizedBox(height: 15.0),
          _windowImage(size),
          SizedBox(height: 10.0),
          _theBlock(size, 0.3, 0.85, "Kasa Bilgileri"),
          _theBlock(size, 0.25, 0.85, "Mermer"),
          _theBlock(size, 0.25, 0.85, "Renk Seçimi"),
          _theBlock(size, 0.5, 0.85, "Cam Türü"),
          kaydetButton(),
          kaydetAnaDonButton(),
          anasayfayaDonButton()
        ],
      ),
    );
  }

  InkWell kaydetButton() {
    return InkWell(
      onTap: () {
        if (_yukseklik.text != "" && _genislik.text != "") {
          _authService.winAdd(
            frUser.uid,
            _yukseklik.text,
            _genislik.text,
            _character.toString().split('.').last,
            _characterColor.toString().split('.').last,
            Customer.name,
            _characterStyle.toString().split('.').last,
            _characterType.toString().split('.').last,
            widget.imgPath,
            widget.brFiyat,
          );
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CatalogPage()));
        }
      },
      child: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            color: ColorConstants.instance.toktok.withOpacity(.80),
            border: Border.all(color: ColorConstants.instance.curuk, width: 3),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Center(
              child: Text(
            "Kaydet ve Devam Et",
            style: TextStyle(
              color: ColorConstants.instance.ice,
              fontSize: 20,
            ),
          )),
        ),
      ),
    );
  }

  InkWell kaydetAnaDonButton() {
    return InkWell(
      onTap: () {
        if (_yukseklik.text != "" && _genislik.text != "") {
          _authService.winAdd(
            frUser.uid,
            _yukseklik.text,
            _genislik.text,
            _character.toString().split('.').last,
            _characterColor.toString().split('.').last,
            Customer.name,
            _characterStyle.toString().split('.').last,
            _characterType.toString().split('.').last,
            widget.imgPath,
            widget.brFiyat,
          );
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CustomerPage()));
        }
      },
      child: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            color: ColorConstants.instance.toktok.withOpacity(.80),
            border: Border.all(color: ColorConstants.instance.curuk, width: 3),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Center(
              child: Text(
            "Kaydet ve Anasayfaya Dön",
            style: TextStyle(
              color: ColorConstants.instance.ice,
              fontSize: 20,
            ),
          )),
        ),
      ),
    );
  }

  InkWell anasayfayaDonButton() {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CustomerPage()));
      },
      child: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            color: ColorConstants.instance.toktok.withOpacity(.80),
            border: Border.all(color: ColorConstants.instance.curuk, width: 3),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Center(
              child: Text(
            "Anasayfaya Dön",
            style: TextStyle(
              color: ColorConstants.instance.ice,
              fontSize: 20,
            ),
          )),
        ),
      ),
    );
  }

  Center _theBlock(Size size, double yks, double gns, String title) {
    return Center(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            height: size.height * yks,
            width: size.width * gns,
            decoration: BoxDecoration(
                color: ColorConstants.instance.toktok.withOpacity(.80),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [BoxShadow(color: ColorConstants.instance.toktok.withOpacity(.15), blurRadius: 10, spreadRadius: 2)]),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: _valueChange(title, size),
              ),
            ),
          ),
          titleContainer(size, yks, gns, title),
        ],
      ),
    );
  }

  Container titleContainer(Size size, double yks, double gns, String title) {
    return Container(
      margin: EdgeInsets.all(10),
      height: size.height * (yks / 4),
      width: size.width * (gns),
      decoration: BoxDecoration(
        color: ColorConstants.instance.curuk.withOpacity(.80),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Center(
          child: Text(
        title,
        style: TextStyle(color: ColorConstants.instance.muskat),
      )),
    );
  }

  Center _windowImage(Size size) {
    return Center(
      child: Hero(
        tag: widget.heroTag,
        child: Container(
          margin: EdgeInsets.only(top: size.height * 0.05),
          height: size.height * .3,
          width: size.width * .5,
          child: Image.asset(
            widget.imgPath,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  _appBar(Size size) {
    return Container(
      color: ColorConstants.instance.curuk,
      margin: EdgeInsets.only(top: size.height * 0.001),
      padding: EdgeInsets.all(2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              //debugPrint("oldu");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CatalogPage(),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.all(5.0),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(50),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Icon(
                Icons.arrow_back_ios,
                color: ColorConstants.instance.ice,
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextField textField(IconData icon, String text, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: TextStyle(
        color: ColorConstants.instance.muskat,
      ),
      cursorColor: ColorConstants.instance.muskat,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: ColorConstants.instance.nar,
        ),
        hintText: text,
        prefixText: " ",
        hintStyle: TextStyle(color: ColorConstants.instance.muskat),
        focusColor: ColorConstants.instance.muskat,
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorConstants.instance.muskat)),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorConstants.instance.muskat)),
      ),
    );
  }

  Widget _valueChange(String value, Size size) {
    switch (value) {
      case "Kasa Bilgileri":
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.02),
            textField(Icons.height, "Yükseklik", _yukseklik),
            textField(Icons.swap_horiz, "Genişlik", _genislik),
          ],
        );
        break;

      case "Renk Seçimi":
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.027),
            ListTile(
              title: Text(
                "Kahverengi",
                style: TextStyle(color: ColorConstants.instance.muskat),
              ),
              leading: Radio(
                activeColor: ColorConstants.instance.nar,
                value: ColorCharacter.brown,
                groupValue: _characterColor,
                onChanged: (ColorCharacter value) {
                  setState(() {
                    _characterColor = value;
                    debugPrint("gayfe gayfe");
                    //eylemleri buraya yazabilirsin tatlım
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Beyaz', style: TextStyle(color: ColorConstants.instance.muskat)),
              leading: Radio(
                activeColor: ColorConstants.instance.nar,
                value: ColorCharacter.ice,
                groupValue: _characterColor,
                onChanged: (ColorCharacter value) {
                  setState(() {
                    _characterColor = value;
                  });
                },
              ),
            ),
          ],
        );
        break;
      case "Cam Türü":
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.08),
            ListTile(
              title: Text(
                'Tek',
                style: TextStyle(color: ColorConstants.instance.muskat),
              ),
              leading: Radio(
                activeColor: ColorConstants.instance.nar,
                value: TypeCharacter.one,
                groupValue: _characterType,
                onChanged: (TypeCharacter value) {
                  setState(() {
                    _characterType = value;
                    //eylemleri buraya yazabilirsin tatlım
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Çift', style: TextStyle(color: ColorConstants.instance.muskat)),
              leading: Radio(
                activeColor: ColorConstants.instance.nar,
                value: TypeCharacter.two,
                groupValue: _characterType,
                onChanged: (TypeCharacter value) {
                  setState(() {
                    _characterType = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Buzlu', style: TextStyle(color: ColorConstants.instance.muskat)),
              leading: Radio(
                activeColor: ColorConstants.instance.nar,
                value: StyleCharacter.blurred,
                groupValue: _characterStyle,
                onChanged: (StyleCharacter value) {
                  setState(() {
                    _characterStyle = value;
                    //eylemleri buraya yazabilirsin tatlım
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Düz', style: TextStyle(color: ColorConstants.instance.muskat)),
              leading: Radio(
                activeColor: ColorConstants.instance.nar,
                value: StyleCharacter.straight,
                groupValue: _characterStyle,
                onChanged: (StyleCharacter value) {
                  setState(() {
                    _characterStyle = value;
                    //eylemleri buraya yazabilirsin tatlım
                  });
                },
              ),
            ),
          ],
        );
        break;
      case "Mermer":
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.027),
            ListTile(
              title: Text('Yes', style: TextStyle(color: ColorConstants.instance.muskat)),
              leading: Radio(
                activeColor: ColorConstants.instance.nar,
                value: SingingCharacter.yes,
                groupValue: _character,
                onChanged: (SingingCharacter value) {
                  setState(() {
                    _character = value;
                    //eylemleri buraya yazabilirsin tatlım
                  });
                },
              ),
            ),
            ListTile(
              title: Text(
                'No',
                style: TextStyle(color: ColorConstants.instance.muskat),
              ),
              leading: Radio(
                activeColor: ColorConstants.instance.nar,
                value: SingingCharacter.no,
                groupValue: _character,
                onChanged: (SingingCharacter value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
            ),
          ],
        );
        break;
      default:
        return Column(); // just to satisfy flutter analyzer
        break;
    }
  }
}
