import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practica5/providers/firebase_providers.dart';
import 'package:practica5/views/addProduct.dart';
import 'package:practica5/views/card_product.dart';

class ListProducts extends StatefulWidget {
  ListProducts({Key key}) : super(key: key);

  @override
  _ListProductsState createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {
  FirebaseProvider _firestore;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firestore=FirebaseProvider();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        backgroundColor: Colors.purple[200],
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add,size: 30,), onPressed: (){
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => NewProduct()));
          })
        ],

        // leading: MaterialButton(
        //     child: Icon(Icons.add_circle, color: Colors.amber),
        //     onPressed: () {
        //       debugPrint("Agregando . . . ");
        //     }),
        //actions: <Widget>[
        //  MaterialButton(
        //      child: Icon(Icons.add_circle, color: Colors.amber),
        //      onPressed: () {
        //        Navigator.pushReplacement(context,
        //            MaterialPageRoute(builder: (context) => AddProduct()));
        //      })
        //],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.getAllproducts(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return CircularProgressIndicator();
          else {
            return ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return CardProduct(productDocument: document);
              }).toList(),
            );
          }
        },
      ),
    );
  }
}