import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HighscoreTile extends StatelessWidget {
  final String documentId;

  const HighscoreTile({Key? key, required this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference highscores =
        FirebaseFirestore.instance.collection('highscores');

    return FutureBuilder<DocumentSnapshot>(
      future: highscores.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return Row(
            children: [
              Text(data['score'].toString(),textAlign: TextAlign.right,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),textDirection: TextDirection.rtl,),
              Spacer(),
              Text(data['name'],textAlign: TextAlign.right,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),textDirection: TextDirection.rtl,),
              SizedBox(
                height: 10,
              ),
            ],
          );
        } else {
          return Text('loading ...');
        }
      },
    );
  }
}
