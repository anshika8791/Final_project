import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'locationservices.dart';

class HomeScreen extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PG Scout', style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        )),
        centerTitle: true,
        backgroundColor: Colors.purple[400],
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(gradient: LinearGradient(colors: [
          Color(0xffCB2893),
          Color(0xff9546C4),
          Color(0xff5E61F4),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child:Padding(
          padding: const EdgeInsets.all(20.0),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
          SizedBox(
          height:250,
          child: Lottie.network(
              "https://lottie.host/90beb4e6-f3cb-4530-8875-1eac53656fee/MGHd3ldOlm.json",
          ),
        ),
          Text(
            "Hello User,",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          Text(
            "Find out where to stay nearby!",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.white70,
            ),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              hintText: "Enter your location",
              prefixIcon: Icon(Icons.location_on, color: Colors.purple),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 15),
            ),
          ),
          SizedBox(height: 20),
            ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LocationServices()),
              );
            },
    style: ElevatedButton.styleFrom(
    backgroundColor: Colors.purple,
    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
    ),
    ),
    child: Text(
    "Search Nearby PGs",
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
    ),
        ],

          ),
        ),
      ),
      );
  }
}