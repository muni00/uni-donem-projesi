import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pencere_denetim/screens/pages/win_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var frUser = FirebaseAuth.instance.currentUser;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Müşteriler"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('Person').doc(frUser.uid).collection('Customer').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData && snapshot.hasError) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else
            return ListView(
              children: snapshot.data.docs.map((doc) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      print("${doc["cusName"]}");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WinListPage(
                                    userName: doc["cusName"].toString(),
                                  )));
                    },
                    title: Text("${doc["cusName"]}"),
                    subtitle: Text("${doc["cusEmail"]}"),
                  ),
                );
              }).toList(),
            );
        },
      ),
    );
  }
}
