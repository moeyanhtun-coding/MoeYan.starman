import 'package:flutter/material.dart';
import 'package:starman/widgets/navbar_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _remainingBox();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }

  Future _remainingBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 255, 243, 243),
            title: Row(
              children: [
                Icon(
                  Icons.circle_notifications,
                  color: Colors.redAccent,
                  size: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Day Remaining'),
              ],
            ),
            content: Text('This is a dialog box.'),
            actions: <Widget>[
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
