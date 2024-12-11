import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:developer';
import 'PGDetailsPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LocationServices extends StatefulWidget {
  const LocationServices ({super.key});

  @override
  State<LocationServices> createState() => _LocationServicesState();
}

class _LocationServicesState extends State<LocationServices> {
  Position? currentPosition;
  List<Map<String, dynamic>> nearbyPGs = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }
  Future <void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      log("Location denied");
      LocationPermission ask = await Geolocator.requestPermission();
      if (ask == LocationPermission.denied ||
          ask == LocationPermission.deniedForever) {
        log("Location permissions are still denied.");
        return;
      }
    }
    Position currentposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    setState(() {
      currentPosition = currentposition;
    });
    log("Latitude=${currentposition.latitude.toString()}");
    log("Longitute=${currentposition.longitude.toString()}");
    fetchNearbyPGs();
  }
  Future<void> fetchNearbyPGs() async {
    final CollectionReference pgCollection =
    FirebaseFirestore.instance.collection('nearby_pg');

    try {
      QuerySnapshot snapshot = await pgCollection.get();
      List<DocumentSnapshot> allPGs = snapshot.docs;

      const thresholdDistanceKm = 20.0;

      for (var doc in allPGs) {
        Map<String, dynamic> pgData = doc.data() as Map<String, dynamic>;
        final pgLatitude = pgData['latitude'];
        final pgLongitude = pgData['longitude'];

        final distanceInMeters = Geolocator.distanceBetween(
          currentPosition!.latitude,
          currentPosition!.longitude,
          pgLatitude,
          pgLongitude,
        );

        final distanceInKm = distanceInMeters / 1000;

        if (distanceInKm <= thresholdDistanceKm) {
          pgData['distance'] = distanceInKm;
          nearbyPGs.add(pgData);
        }
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      log("Error fetching PGs: $e");
      setState(() {
        isLoading = false;
      });
    }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          body: isLoading
              ? const Center(child: CircularProgressIndicator())
          : nearbyPGs.isEmpty
      ? const Center(child: Text("Fetching your location....."))
          : ListView.builder(
      itemCount: nearbyPGs.length,
      itemBuilder: (context, index) {
      Map<String, dynamic> pg = nearbyPGs[index];
      return ListTile(
      title: Text(pg['name']),
      subtitle: Text(pg['address'] ?? "Address not available"),
      trailing: Text("${pg['distance'].toStringAsFixed(2)} km"),
      onTap: () {
      Navigator.push(
      context,
      MaterialPageRoute(
      builder: (context) => PGDetailsPage(
      latitude: pg['latitude'],
      longitude: pg['longitude'],

      ),
      ),
      );
      },
      );
      },
          ),
          floatingActionButton: FloatingActionButton(
          onPressed: () {
        if (currentPosition != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PGDetailsPage(
                latitude: currentPosition!.latitude,
                longitude: currentPosition!.longitude,
              ),
            ),
          );
        } else {
          log("Location not available yet.");
        }
          },
            child: const Text('Next'),
            backgroundColor: Colors.red[400],
          ),
      );
    }
}





