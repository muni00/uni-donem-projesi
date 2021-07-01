import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pencere_denetim/constants/color_constant.dart';
import 'package:pencere_denetim/service/auth_service.dart';

class Customer extends StatefulWidget {
  // Customer({Key key}) : super(key: key);
  static int radioValue = 0;
  static bool control = false;
  static String uyelik = "";
  static String name = "";
  @override
  _CustomerState createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  final _nameController = TextEditingController(text: "Ad Soyad");
  final _emailController = TextEditingController(text: "Email");
  final _phoneController = TextEditingController(text: "Telefon Numarası");
  final _adressController = TextEditingController(text: "Adres");
  final _identityController = TextEditingController(text: "TC Kimlik");

  var frUser = FirebaseAuth.instance.currentUser;
  AuthService _authService = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _adressController.dispose();
    _identityController.dispose();
    super.dispose();
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      Customer.radioValue = value;
      //seçildikleringerçekleşecek olaylar buraya yazılmalı
      switch (Customer.radioValue) {
        case 0:
          debugPrint("kurumsal");
          Customer.uyelik = "Kurumsal";
          break;
        case 1:
          debugPrint("bireysel");
          Customer.uyelik = "Bireysel";
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              someCusTextField(false, 'Email', Icons.email, _emailController),
              SizedBox(height: 8.0),
              someCusTextField(false, 'Ad Soyad', Icons.perm_identity, _nameController),
              SizedBox(height: 8.0),
              someCusTextField(false, 'Telefon Numarası', Icons.phone, _phoneController),
              SizedBox(height: 8.0),
              someCusTextField(false, 'Adres', Icons.location_on, _adressController),
              SizedBox(height: 8.0),
              someCusTextField(false, 'TC Kimlik', Icons.badge, _identityController),
              SizedBox(height: 12.0),
              radioButton(),
            ],
          ),
        ),
      ),
    );
  }

  Row radioButton() {
    _controllerControl(_emailController.text, _nameController.text, _phoneController.text, _adressController.text, _identityController.text);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.switch_account,
          color: ColorConstants.instance.curuk,
        ),
        Radio(
          value: 0,
          activeColor: ColorConstants.instance.nar,
          groupValue: Customer.radioValue,
          onChanged: _handleRadioValueChange,
        ),
        Text(
          'kurumsal',
          style: TextStyle(fontSize: 16.0, color: ColorConstants.instance.curuk),
        ),
        Radio(
          value: 1,
          activeColor: ColorConstants.instance.nar,
          groupValue: Customer.radioValue,
          onChanged: _handleRadioValueChange,
        ),
        Text(
          'bireysel',
          style: TextStyle(fontSize: 16.0, color: ColorConstants.instance.curuk),
        ),
      ],
    );
  }

  TextFormField someCusTextField(bool obscureText, String hintText, IconData icon, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      autofocus: false,
      obscureText: obscureText,
      cursorColor: ColorConstants.instance.muskat,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: ColorConstants.instance.nar,
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: ColorConstants.instance.curuk),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        fillColor: ColorConstants.instance.muskat,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: ColorConstants.instance.muskat,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: ColorConstants.instance.muskat,
            width: 2.0,
          ),
        ),
      ),
    );
  }

  _controllerControl(String email, String isim, String tel, String adres, String kimlik) {
    setState(() {
      if (email != "Email" && isim != "Ad Soyad" && tel != "Telefon Numarası" && adres != "Adres" && kimlik != "TC Kimlik") {
        Customer.control = true;
        Customer.name = isim;
        debugPrint(frUser.uid); //burda servis elemanı çağırabilirsin
        _authService.customerAdd(frUser.uid, email, isim, tel, adres, kimlik, Customer.uyelik);
      } else
        Customer.control = false;
    });
  }
}
