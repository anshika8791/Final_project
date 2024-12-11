import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PGFullDetailsPage extends StatelessWidget {
  final DocumentId;
  PGFullDetailsPage({required this.DocumentId});

  Future<Map<String, dynamic>> getPGDetails(DocumentId) async {
    DocumentSnapshot pgSnapshot =
    await FirebaseFirestore.instance.collection('nearby_pg').doc(DocumentId).get();

    if (pgSnapshot.exists) {
      return pgSnapshot.data() as Map<String, dynamic>;
    } else {
      throw Exception("PG not found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("PG Full Details"),
        ),
        body: FutureBuilder<Map<String, dynamic>>(
        future: getPGDetails(DocumentId),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
    return Center(child: Text('Error: ${snapshot.error}'));
    } else if (!snapshot.hasData) {
    return Center(child: Text('No details found for this PG.'));
    } else {
    Map<String, dynamic> pgDetails = snapshot.data!;
    return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text('Name: ${pgDetails['name']}', style: TextStyle(fontSize: 20)),
    SizedBox(height: 10),
    Text('Address: ${pgDetails['address']}'),
    SizedBox(height: 10),
    Text('Status: ${pgDetails['status']}'),
    SizedBox(height: 10),
    Text('Latitude: ${pgDetails['latitude']}'),
    SizedBox(height: 10),
    Text('Longitude: ${pgDetails['longitude']}'),
    ],
    ),
    );
    }
    },
        ),
    );
  }
}
