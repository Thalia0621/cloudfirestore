import 'dart:io';
import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practica5/models/product_dao.dart';
import 'package:practica5/providers/firebase_providers.dart';
import 'package:practica5/screen/list_products.dart';
import 'package:path/path.dart';

class NewProduct extends StatefulWidget {
  const NewProduct({Key key}) : super(key: key);

  @override
  _NewProductState createState() => _NewProductState();
}

class _NewProductState extends State<NewProduct> {
  File _image;
  String pathimage;
  String fileName,url;var _uploadedFileURL;
  final picker = ImagePicker();
  FirebaseProvider provider=FirebaseProvider();
  TextEditingController edTxtclave=TextEditingController();
    TextEditingController edtxtDescription=TextEditingController();
  

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      pathimage=pickedFile.path;
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });

      }


    void uploadImageToFirebase() async {

     fileName = DateTime.now().toString()+basename(pathimage);
     FirebaseStorage storage = FirebaseStorage.instance;
     Reference ref = storage.ref().child('images/$fileName');
     UploadTask uploadTask = ref.putFile(_image);
   _uploadedFileURL=await (await uploadTask).ref.getDownloadURL();
      print ('ededeed**** '+_uploadedFileURL);
        provider.saveproduct(ProductDAO(
              model: edTxtclave.text,
              description: edtxtDescription.text,
              image: _uploadedFileURL));
  }

  @override
  Widget build(BuildContext context) {
 
    final imgFinal=_image == null
            ? Text('No image selected.')
            : SizedBox(child:Image.file(_image),height: 200,);
      
      
    final txtClave= TextFormField(
          controller:edTxtclave,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: 'key',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          prefixIcon:  Padding(
                padding: EdgeInsets.only(top: 0), // add padding to adjust icon
                child: Icon(Icons.qr_code,color: Colors.cyan),
              
              ),
          ),
        );
        final txtDescription= TextFormField(
          controller:edtxtDescription,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: 'Description',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          prefixIcon:  Padding(
                padding: EdgeInsets.only(top: 0), // add padding to adjust icon
                child: Icon(Icons.edit,color: Colors.cyan),
              ),
          ),
        );
        final btnimg=FloatingActionButton.extended(
            label: Text('Image'),
            icon: Icon(Icons.add_photo_alternate),
            backgroundColor: Colors.pink,
            onPressed: () async {
                getImage();      
            },);
        final btnsave=RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          child: Text('Save',style: TextStyle(color: Colors.white),),
          color: Colors.cyan,
          onPressed: (){ 
            
           uploadImageToFirebase();
           
            
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ListProducts()));
        });
    
    
        return Scaffold(
          appBar: AppBar(
            title: Text("New Product"),
            backgroundColor: Colors.purple[200],),
          body: Card(
                 color: Colors.white70,
                 margin: EdgeInsets.all(30.0),
                 child: Padding(
                   padding: EdgeInsets.all(5),
                   child: ListView(   
                     children: <Widget> [
                        txtClave,
                        SizedBox(height: 10),
                        txtDescription,
                        SizedBox(height: 10),
                        btnimg,
                        SizedBox(height: 10),
                        imgFinal,
                        SizedBox(height: 30),
                        btnsave,
                     ],
                  ),
                 ),
               ),
        );
      
      }

}