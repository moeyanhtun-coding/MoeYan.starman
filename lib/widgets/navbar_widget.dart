import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

class NavBar extends StatelessWidget {
  String starId;
  String reaminingDate;
  NavBar({
    super.key,
    required this.starId,
    required this.reaminingDate,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _drawerHeader(context),
          Expanded(child: _listGroup()),
          Divider(),
          _drawerBottom(),
        ],
      ),
    );
  }

  Widget _drawerHeader(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Colors.grey,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
                'https://i.pinimg.com/564x/47/91/f0/4791f027dcad85f85883359daf191c5d.jpg'),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                starId,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Expired in $reaminingDate days',
                style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _listGroup() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _listTile("အရှုံးအမြတ်အစီရင်ခံစာ", Icons.home, () {
            Get.offAndToNamed('profitlost');
          }),
          _listTile("ငွေအဝင်အထွက်အစီရင်ခံစာ", Icons.money, () {
            Get.offAndToNamed('cfreport');
          }),
          _listTile('နေ့အလိုက်ဝင်ငွေထွက်ငွေအစီရင်ခံစာ', Icons.money, () {
            Get.offAndToNamed('cashflowdaily');
          }),
          _listTile("Setting", Icons.settings, () {}),
        ],
      ),
    );
  }

  Widget _drawerBottom() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: _listTile("LogOut", Icons.logout, () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();
        Get.offAllNamed('/starId');
      }), //TODO: Write Logout Process
    );
  }

  Widget _listTile(
    String title,
    IconData icon,
    Function() tap,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: tap,
    );
  }
}
