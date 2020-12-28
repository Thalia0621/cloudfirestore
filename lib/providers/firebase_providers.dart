import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practica5/models/product_dao.dart';

class FirebaseProvider{
  FirebaseFirestore _firestore;
  CollectionReference _productsCollection;
  FirebaseProvider(){
    _firestore=FirebaseFirestore.instance;
    _productsCollection=_firestore.collection('products');
  }
  Future <void> saveproduct(ProductDAO product) {return _productsCollection.add(product.toMap());}
  Future<void> updateProduct(ProductDAO product, String documentID){return _productsCollection.doc(documentID).update(product.toMap());}
  Future <void> removeProduct(String documentID){return _productsCollection.doc(documentID).delete();}
  
  
  Stream<QuerySnapshot>getAllproducts(){
    return _productsCollection.snapshots();
    }
  
}