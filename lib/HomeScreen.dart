import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'LoginScreen.dart';
import 'MessageScreen.dart';

class HomeScreen extends StatefulWidget {
  final String? usuarioActual;

  const HomeScreen({Key? key, required this.usuarioActual}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState(this.usuarioActual);
}

class _HomeScreenState extends State<HomeScreen> {
  String? usuariologueado = "";
  FirebaseFirestore db = FirebaseFirestore.instance;
  late List<DocumentSnapshot> users=[];

  _HomeScreenState(this.usuariologueado);

  @override
  void initState() {


    // TODO: implement initState
    print("El usuario logueado es: ");
    print(this.usuariologueado);
    print("Viene desde la clase principal");

    _getUsers();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      print(notification?.body.toString());
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');

    });

    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    /*FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      Navigator.pushNamed(context, '/message',
          arguments: MessageArguments(message, true));
    });*/


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          this.usuariologueado.toString(),
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                FirebaseAuth.instance.signOut().then((val) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                });
              })
        ],
      ),
      body: Container(
          child: users!=null? ListView.builder(
              itemCount: users.length,
              itemBuilder: (ctx,index){
                return Container(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(users[index]
                      ["email"]
                          .toString()
                          .substring(0, 1)),
                    ),
                    //title: Text(users[index].data()["email"]),
                    title: Text(users[index]["email"]),
                    onTap: (){
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>
                                MessageScreen(doc: users[index])));
                      });
                    },
                  ),
                );
              }):CircularProgressIndicator()
      ),
    );
  }

  _showMessage(title, message) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              MaterialButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: Text("Dismiss"))
            ],
          );
        });
  }

  _getUsers() async {
    QuerySnapshot snapshot = await db.collection("users").get();
    setState(() {
      users = snapshot.docs;
      //users.removeWhere((element) => element.data().containsValue(usuariologueado));
      users.removeWhere((element) => element.data().toString().contains(usuariologueado!));
      print(users);
    });
  }
}