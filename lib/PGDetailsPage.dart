import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'PGFullDetails.dart';


class PGDetailsPage extends StatelessWidget {
  final double latitude;
  final double longitude;

  PGDetailsPage({required this.latitude, required this.longitude});

  Future<List<Map<String, dynamic>>> getNearbyPGs(double lat, double lon) async {
    CollectionReference pgsCollection = FirebaseFirestore.instance.collection('nearby_pg');
    QuerySnapshot querySnapshot = await pgsCollection.get();
    List<Map<String, dynamic>> pgList = querySnapshot.docs.map((doc) {
      return {
        'name': doc['name'],
        'latitude': doc['latitude'],
        'longitude': doc['longitude'],
        'address' : doc['address'],
        'status' : doc['status'],
      };
    }).toList();

    return pgList;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("PG Details"),
        ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getNearbyPGs(latitude, longitude),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
    return Center(child: Text('Error: ${snapshot.error}'));
    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
    return Center(child: Text('No PGs found nearby.'));
    } else {
    List<Map<String, dynamic>> pgList = snapshot.data!;

    return ListView.builder(
    itemCount: pgList.length,
    itemBuilder: (context, index) {
    var pg = pgList[index];
    return ListTile(
    title: Text(pg['name']),
    subtitle: Text("Lat: ${pg['latitude']}, Lon: ${pg['longitude']}"),
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
          builder: (context) => PGFullDetailsPage(
          DocumentId: pg['id'],
      ),
      ),
      );
    },
    );
    },
    );
    }
    },
        ),
    );
  }
}

