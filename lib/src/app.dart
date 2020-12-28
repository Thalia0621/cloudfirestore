import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practica5/screen/list_products.dart';
class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context,snapshot){
      if (snapshot.hasError) {
          debugPrint("${snapshot.error}");
          return MaterialApp(home: Text("Algo salio mal"));
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            home: ListProducts(),
          );
        }
      
        return Center(
                              child:CircularProgressIndicator());
      },);
    }
  }

/*home: Scaffold(
        appBar: AppBar(
          title: Text('Products'),
          actions: <Widget>[
            MaterialButton(
              child: Icon(Icons.add_circle),
              onPressed: (){})
          ],
        ),
        body: ListProducts()),
    );
  }*/
  