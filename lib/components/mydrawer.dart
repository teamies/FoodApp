import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../database/services/auth_service.dart';
import 'mytext.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

  // TextEditingController nameController = TextEditingController();
  
  Future<dynamic> signOut() async {
    await Auth().signOut();
    Navigator.pushNamedAndRemoveUntil(context, '/LogIn', (route) => false);
  }

   int? indexClicked;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1),
                    shape: BoxShape.circle,
                    color: Colors.white,
                    // image: DecorationImage(
                    //   fit: BoxFit.cover,
                    //   image: NetworkImage(profileController.image),
                    // ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                SizedBox(
                  width: ScreenSize(context).mainWidth / 2.5,
                  child: Text(
                    // profileController.name.toString(),
                    'Tra my',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ),
          _drawerItem(
            icon: Icons.account_circle_outlined,
            text: 'Profile',
            indexNumber: 0,
            onTap: () {
              indexClicked = 0;
              (context as Element).markNeedsBuild();
            },
          ),
          _drawerItem(
            icon: Icons.logout,
            text: 'Log out',
            indexNumber: 3,
            onTap: () {
              indexClicked = 3;
              (context as Element).markNeedsBuild();
              signOut();
            },
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(
      {required IconData icon,
      required String text,
      required int indexNumber,
      required GestureTapCallback onTap}) {
    return ListTile(
      selected: indexClicked == indexNumber,
      selectedTileColor: AppColor.primaryColor,
      title: Row(
        children: [
          Icon(
            icon,
            color: indexClicked == indexNumber
                ? Colors.white
                : AppColor.primaryColor,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: indexClicked == indexNumber
                    ? Colors.white
                    : AppColor.primaryColor,
              ),
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
