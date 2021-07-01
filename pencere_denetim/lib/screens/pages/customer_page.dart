import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pencere_denetim/constants/color_constant.dart';
import 'package:pencere_denetim/screens/pages/catalog_page.dart';
import 'package:pencere_denetim/screens/pages/home_page.dart';
import 'package:pencere_denetim/screens/piecemeal/auth.dart';
import 'package:pencere_denetim/screens/piecemeal/cp_customer.dart';
import 'package:pencere_denetim/screens/piecemeal/cp_invoice.dart';
import 'package:pencere_denetim/screens/piecemeal/step_models.dart';
//import 'package:pencere_denetim/service/auth_service.dart';

class CustomerPage extends StatefulWidget {
  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  List<StepModel> list = StepModel.list;
  var _controller = PageController();
  var initialPage = 0;
  //AuthService _authService = AuthService();
  var frUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    _controller.addListener(() {
      setState(() {
        initialPage = _controller.page.round(); //sayfa kontrolü için controller
      });
    });

    return Scaffold(
      backgroundColor: ColorConstants.instance.ice,
      drawer: drawer(context),
      body: Column(
        children: [
          _appBar(size),
          _body(_controller),
          _indicator(),
        ],
      ),
    );
  }

  Drawer drawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(frUser.email),
            accountEmail: Text("welcome"),
            decoration: BoxDecoration(
              color: ColorConstants.instance.curuk,
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/customer/1.png"),
            ),
          ),
          ListTile(
            title: Text('Anasayfa'),
            leading: Icon(Icons.home, color: ColorConstants.instance.toktok),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          ListTile(
            title: Text('Profilim'),
            onTap: () {
              Navigator.pop(context);
            },
            leading: Icon(Icons.person, color: ColorConstants.instance.toktok),
          ),
          Divider(),
          ListTile(
            title: Text('Çıkış yap'),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AuthScreen()));
            },
            leading: Icon(Icons.remove_circle, color: ColorConstants.instance.nar),
          ),
        ],
      ),
    );
  }

  _appBar(Size size) {
    return Container(
      color: ColorConstants.instance.curuk,
      margin: EdgeInsets.only(top: size.height * 0.04),
      padding: EdgeInsets.all(2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          initialPage == 0
              ? GestureDetector(
                  onTap: () {
                    if (initialPage > 0) _controller.animateToPage(initialPage - 1, duration: Duration(microseconds: 500), curve: Curves.easeIn);
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
                )
              : SizedBox(),
          initialPage == 1
              ? InkWell(
                  onTap: () {
                    if (Invoice.control == true) {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CatalogPage()));
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(5.0),
                    width: 110,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(50),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Tamamla",
                        style: TextStyle(
                          fontSize: 17,
                          color: ColorConstants.instance.ice,
                        ),
                      ),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  _body(PageController controller) {
    return Expanded(
      child: PageView.builder(
        controller: controller,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Container(
            color: ColorConstants.instance.ice,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: [
                  index == 1 ? _displayText(list[index].text) : _displayImage(list[index].id),
                  SizedBox(
                    height: 25,
                  ),
                  index == 1 ? _displayImage(list[index].id) : _displayText(list[index].text),
                  SizedBox(
                    height: 25,
                  ),
                  index == 1 ? Invoice() : Customer()
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _indicator() {
    return Container(
      width: 50,
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 12),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 90,
              height: 90,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(ColorConstants.instance.nar),
                value: (initialPage + 1) / (list.length + 1),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                if (initialPage < list.length && Customer.control == true) {
                  _controller.animateToPage(initialPage + 1, duration: Duration(microseconds: 500), curve: Curves.easeIn);
                }
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: ColorConstants.instance.curuk,
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: ColorConstants.instance.ice,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _displayText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      textAlign: TextAlign.center,
    );
  }

  _displayImage(int path) {
    return Image.asset(
      "assets/customer/$path.png",
      height: MediaQuery.of(context).size.height * .5,
    );
  }
}
