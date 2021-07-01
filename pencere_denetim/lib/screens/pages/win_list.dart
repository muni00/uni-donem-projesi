import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pencere_denetim/service/auth_service.dart';

class WinListPage extends StatefulWidget {
  final String userName;
  WinListPage({this.userName});

  @override
  _WinListPageState createState() => _WinListPageState();
}

class _WinListPageState extends State<WinListPage> {
  var frUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Siparişler"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('Person').doc(frUser.uid).collection('Customer').doc(widget.userName).collection('Window').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.hasError) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else
            return ListView(
              children: snapshot.data.docs.map((doc) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      setState(() {
                        _authService.removeCustom(
                          frUser.uid,
                          widget.userName,
                        );
                      });
                    },
                    title: Text("${doc["fiyat"]} TL"),
                    subtitle: Text("${DateTime.parse(doc["tarih"].toDate().toString())}"),
                    leading: Container(
                      height: size.height * 1,
                      width: size.width * .2,
                      child: Image.asset(
                        doc["image"],
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
        },
      ),
    );
  }
}
