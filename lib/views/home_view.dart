import 'package:flutter/material.dart';
import 'package:starman/widgets/navbar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Home Page'),
          backgroundColor: Colors.grey[600],
        ),

        //body
        body: const Center(
          child: Text(
            'Home Page',
            style: TextStyle(fontSize: 30.0),
          ),
        ),
      ),
    );
  }
}