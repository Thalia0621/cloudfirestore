import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CardProduct extends StatefulWidget {
  final DocumentSnapshot productDocument;
  const CardProduct({
    Key key,
    @required this.productDocument
  }) : super(key: key);

  @override
  _CardProductState createState() => _CardProductState(productDocument);
}

class _CardProductState extends State<CardProduct> {
  final DocumentSnapshot productDocument;
  _CardProductState(this.productDocument);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _card=Stack(
    alignment:  Alignment.bottomCenter,
    children: [
      Container(
        width: MediaQuery.of(context).size.width,
        child: FadeInImage(
          placeholder: AssetImage('assets/activity_indicator.gif'),
          image: NetworkImage(widget.productDocument['image']==null?'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTn6SET2El-z4kXli3jVt9AbinH7v57jvxfuA&usqp=CAU':widget.productDocument['image']),
          fit: BoxFit.cover,
          fadeInDuration: Duration(milliseconds: 100),
          height: 230.0,
          ),
      ),
      Opacity(opacity: 0.6,
      child: Container(
        height: 55.0,
        color: Colors.black,
        child: Row(
          children: [
            Text('key: '+widget.productDocument['model'],
            style: TextStyle(color:  Colors.white),),
            SizedBox(width: 20,),
            Text('Description: '+widget.productDocument['description'],
            style: TextStyle(color:  Colors.white),)
          ],
        ),
      ),
      )
    ]
  );
    return Container(
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.2),
            offset: Offset(0.0,5.0),
            blurRadius: 1.0
          )
        ]
        ),
        child:  ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: _card,
          ),
    );
  }
}