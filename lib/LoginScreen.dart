import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';
import 'HomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController mailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;


  @override
  void initState(){

    checkUserAuth();
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  checkUserAuth() async {
    try {
      User? user = auth.currentUser;
      print("Cuando la sesión ya existe");
      print(user?.email);

      if (user != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(usuarioActual: user.email!,),
              ));
        });
      }
    } catch (e) {
      print("Error A " + e.toString());
    }
  }

  //Método para loguear
  login() {
    String email = mailController.text;
    String password = passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((result) async {
        //Registrar fcm key
        String? token = await firebaseMessaging.getToken();
        User? user = result.user;
        print("el usuario es");
        print(user?.email);
        print(token.toString());
        db
            .collection("users")
            .doc(user?.uid)
            .set({"email": user?.email, "fcmToken": token});

        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(usuarioActual: user?.email.toString()),
              ));
        });
      }).catchError(
              (error) => {});


    } else {
      // showToast("Provide email and password", gravity: Toast.CENTER);
    }
  }

  /* void showToast(String msg, {required int duration, required int gravity}) {
    Toast.show(msg, textStyle: context, duration: duration, gravity: gravity);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: mailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Email",
                  labelText: "Email",
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Password",
                    labelText: "Password"),
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
              ),
            ),
            MaterialButton(
              color: Colors.green,
              child: Text("Login"),
              onPressed: () {
                login();
              },
            )
          ],
        ),
      ),
    );
  }
}