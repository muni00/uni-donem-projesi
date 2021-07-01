import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //giriş yap fonksiyonu
  Future<User> signIn(String email, String password) async {
    var user;
    try {
      user = await _auth.signInWithEmailAndPassword(email: email, password: password);

      return user.user;
    } catch (e) {
      print("hatalı bişiler $e");
      return user;
    }
  }

  //çıkış yap fonksiyonu
  signOut() async {
    return await _auth.signOut();
  }

  //kayıt ol fonksiyonu
  Future<User> createPerson(String name, String email, String password) async {
    var user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    try {
      await _firestore.collection('Person').doc(user.user.uid).set({'userName': name, 'email': email});

      return user.user;
    } catch (e) {
      print("hatalı bişiler $e");
      return user.user;
    }
  }

  Future customerAdd(String id, String email, String name, String phone, String adress, String tc, String uyelik) async {
    try {
      await _firestore
          .collection('Person')
          .doc(id)
          .collection('Customer')
          .doc(name)
          .set({'cusName': name, 'cusEmail': email, 'cusPhone': phone, 'cusAddress': adress, 'cusTc': tc, 'cusUyelik': uyelik});
    } catch (e) {
      print("hatalı bişiler $e");
    }
  }

  Future faturaAdd(String id, String email, String vergiNum, String vergiDr, String adress, String name) async {
    try {
      await _firestore
          .collection('Person')
          .doc(id)
          .collection('Customer')
          .doc(name)
          .set({'fatEmail': email, 'vergiNum': vergiNum, 'fatAddress': adress, 'vergiDr': vergiDr}, SetOptions(merge: true));
    } catch (e) {
      print("hatalı bişiler $e");
    }
  }

  Future winAdd(
    String id,
    String yukseklik,
    String genislik,
    String mermer,
    String renk,
    String name,
    String camStyle,
    String camType,
    String imagePath,
    int fiyat,
  ) async {
    try {
      await _firestore.collection('Person').doc(id).collection('Customer').doc(name).collection('Window').add({
        "kasa": {"yukseklik": yukseklik, "genislik": genislik},
        "mermer": mermer,
        "renk": renk,
        "camStyle": camStyle,
        "camType": camType,
        "image": imagePath,
        "fiyat": fiyat,
        "tarih": FieldValue.serverTimestamp()
      });
    } catch (e) {
      print("hatalı bişiler $e");
    }
  }

  //liste göstermek için
  Future<QuerySnapshot> readDataFromFirestore() async {
    final QuerySnapshot _ref = await _firestore.collection("Person").get();
    return _ref;
  }

  //kullanıcı silmek için
  Future<void> removeCustom(String uid, String cusid) {
    var ref = _firestore.collection("Person").doc(uid).collection('Customer').doc(cusid).delete();

    return ref;
  }
}
