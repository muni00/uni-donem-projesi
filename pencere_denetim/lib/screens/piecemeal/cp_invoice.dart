import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pencere_denetim/constants/color_constant.dart';
import 'package:pencere_denetim/screens/piecemeal/cp_customer.dart';
import 'package:pencere_denetim/service/auth_service.dart';

class Invoice extends StatefulWidget {
  static bool control = false;
  @override
  _InvoiceState createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  final _emailController = TextEditingController(text: "Email");
  final _vergiNumController = TextEditingController(text: "vergi numarası");
  final _vergiDrController = TextEditingController(text: "vergi dairesi");
  final _adressController = TextEditingController(text: "Adres");

  var frUser = FirebaseAuth.instance.currentUser;
  AuthService _authService = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _vergiNumController.dispose();
    _vergiDrController.dispose();
    _adressController.dispose();
    super.dispose();
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
              someCusTextField(_adressController, false, 'Adres', Icons.location_on),
              SizedBox(height: 8.0),
              someCusTextField(_vergiNumController, false, 'vergi numarası', Icons.filter_8),
              SizedBox(height: 8.0),
              someCusTextField(_vergiDrController, false, 'vergi dairesi', Icons.location_city),
              SizedBox(height: 8.0),
              someCusTextField(_emailController, false, 'Email', Icons.email),
              _controllerControl(_emailController.text, _vergiDrController.text, _vergiNumController.text, _adressController.text)
            ],
          ),
        ),
      ),
    );
  }

  TextFormField someCusTextField(TextEditingController controller, bool obscureText, String hintText, IconData icon) {
    return TextFormField(
      autofocus: false,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: ColorConstants.instance.nar,
        ),
        hintText: hintText,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
  }

  SizedBox _controllerControl(String email, String verDr, String verNum, String adress) {
    setState(() {
      if (email != "Email" && verDr != "vergi dairesi" && verNum != "vergi numarası" && adress != "Adres") {
        Invoice.control = true;
        debugPrint(email); //burda servis elemanı çağırabilirsin
        _authService.faturaAdd(frUser.uid, email, verNum, verDr, adress, Customer.name);
      } else
        Invoice.control = false;
    });
    return SizedBox(
      width: 0.01,
    );
  }
}
