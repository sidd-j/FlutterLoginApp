import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserData extends StatelessWidget {
  final CollectionReference<Map<String, dynamic>> usersCollection;

  const GetUserData({super.key, required this.usersCollection});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: usersCollection.get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<Map<String, dynamic>> userData =
              snapshot.data!.docs.map((doc) => doc.data()).toList();
          return Column();
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
