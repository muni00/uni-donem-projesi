import 'package:flutter/material.dart';
import 'package:pencere_denetim/constants/color_constant.dart';
import 'package:pencere_denetim/screens/pages/customer_page.dart';
import 'package:pencere_denetim/screens/pages/information_page.dart';

class CatalogPage extends StatefulWidget {
  CatalogPage({Key key}) : super(key: key);

  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          _appBar(size),
          SizedBox(height: 15.0),
          Container(
            height: size.height * .75,
            child: listViewWindowCards(size),
          ),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }

  listViewWindowCards(Size size) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        _listItem("Tek sağa açılım", "assets/catalog/tek.png", "1", size, 22),
        _listItem("Ikili sağa açılım", "assets/catalog/ikili.png", "2", size, 22),
        _listItem("Uçlu çift içeri  açılım", "assets/catalog/uclu.png", "3", size, 22),
        _listItem("Orta kayıtsız çift içeri açılım", "assets/catalog/butun.png", "4", size, 22),
      ],
    );
  }

  _listItem(String windowName, String imgPath, String price, Size size, int brFiyat) {
    Color textColor = ColorConstants.instance.toktok;
    return Padding(
      padding: EdgeInsets.only(left: 15.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => InformationPage(
              heroTag: windowName,
              windowName: windowName,
              pricePerItem: price,
              imgPath: imgPath,
              brFiyat: brFiyat,
            ),
          ));
        },
        child: Container(
          width: size.width * 0.75,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0), color: ColorConstants.instance.toktok.withOpacity(.80)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: windowName,
                child: Container(
                  height: size.height * 0.50,
                  width: size.width * 0.60,
                  decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: Center(
                    child: Image.asset(
                      imgPath,
                      fit: BoxFit.fill,
                      height: size.height * 0.27,
                      width: size.width * 0.40,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25.0),
              Text(
                windowName,
                style: TextStyle(fontSize: 17.0, color: textColor),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "model : $price",
                style: TextStyle(fontSize: 17.0, color: textColor),
              )
            ],
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomerPage(),
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
}
