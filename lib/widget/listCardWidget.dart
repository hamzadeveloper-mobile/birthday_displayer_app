import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Widget buildListCard(BuildContext context, DocumentSnapshot document) {
  return Container(
    child: Card(
      color: Colors.deepPurpleAccent[100],
      child: ListTile(
        title: Text(
          "${(document.data() as dynamic)['name']}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          "DOB: ${(document.data() as dynamic)['dob']}",
          style: TextStyle(
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
              color: Colors.white70),
        ),
        leading: CircleAvatar(
          radius: 25.0,
          backgroundImage: NetworkImage(
              'https://firebasestorage.googleapis.com/v0/b/birthday-displayer-app.appspot.com/o/${(document.data() as dynamic)['uid']}?alt=media&token=1fe3c109-5c80-4d71-8ae9-019eb402a9ac'),
        ),
      ),
    ),
  );
}
