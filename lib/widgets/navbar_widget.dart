import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                      'https://i.pinimg.com/564x/47/91/f0/4791f027dcad85f85883359daf191c5d.jpg'),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'S-2342',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                Text(
                  'Expired in 10 days',
                  style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('home'),
            onTap: () => {},
          ),

          ListTile(
            leading: Icon(Icons.home),
            title: Text('home'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('home'),
            onTap: () => {},
          ),
          /* 
          multiple list icons and title 

          ListTile(
            leading: Icon(Icons.home),
            title: Text('home'),
            onTap: () => {},
          )
          
          ListTile(
            leading: Icon(Icons.home),
            title: Text('home'),
            onTap: () => {},
          )

          ListTile(
            leading: Icon(Icons.home),
            title: Text('home'),
            onTap: () => {},
          )
          
          end of multiple  icons
          */

          // start settings and logout
          SizedBox(
            height: 120,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {},
          ),

          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () => {},
          ),
        ],
      ),
    );
  }
}
