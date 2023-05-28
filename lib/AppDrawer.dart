import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thispls/models/login_page.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        // color: color(context.cardColor),
        color: Colors.grey[900],
        child: ListView(
          children: [
             DrawerHeader(
              padding: EdgeInsets.zero,
              //  margin: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.black),
                accountName: Text(logged_name),
                accountEmail: Text(logged_email),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://www.shutterstock.com/image-vector/businessman-icon-can-be-used-260nw-247098721.jpg'),
                ),
              ),
            ),
            //  ListTile(
            //   leading: Icon(CupertinoIcons.person_alt, color: Colors.white),
            //   title: Text(
            //     'Account',
            //     style: TextStyle(color: Colors.white),
            //     textScaleFactor: 1.3,
            //   ),
            //   onTap: () => Navigator.pushNamed(context, "/account"),
            // ),
            // ListTile(
            //   leading:
            //       const Icon(CupertinoIcons.car_detailed, color: Colors.white),
            //   title: const Text(
            //     'put a car on rent',
            //     style: TextStyle(color: Colors.white),
            //     textScaleFactor: 1.3,
            //   ),
            //   onTap: () => Navigator.pushNamed(context, "/addCar"),
            // ),
            // // const ListTile(
            // //   leading: Icon(CupertinoIcons.mail, color: Colors.white),
            // //   title: Text(
            // //     'Email',
            // //     style: TextStyle(color: Colors.white),
            // //     selectionColor: Colors.white,
            // //     textScaleFactor: 1.3,
            // //   ),
            // // ),
            // // ListTile(
            // //   leading:
            // //       const Icon(CupertinoIcons.person_3_fill, color: Colors.white),
            // //   title: const Text(
            // //     "Renters' list",
            // //     style: TextStyle(color: Colors.white),
            // //     textScaleFactor: 1.3,
            // //   ),
            // //   onTap: () => Navigator.pushNamed(context, "/renters"),
            // // ),
            // ListTile(
            //   leading:
            //   const Icon(CupertinoIcons.person_3_fill, color: Colors.white),
            //   title: const Text(
            //     "Car list",
            //     style: TextStyle(color: Colors.white),
            //     textScaleFactor: 1.3,
            //   ),
            //   onTap: () => Navigator.pushNamed(context, "/carlist"),
            // ),
            // ListTile(
            //   leading:
            //   const Icon(CupertinoIcons.person_3_fill, color: Colors.white),
            //   title: const Text(
            //     "Requests",
            //     style: TextStyle(color: Colors.white),
            //     textScaleFactor: 1.3,
            //   ),
            //   onTap: () => Navigator.pushNamed(context, "/request"),
            // ),
            // ListTile(
            //   leading:
            //   const Icon(CupertinoIcons.person_3_fill, color: Colors.white),
            //   title: const Text(
            //     "Updates",
            //     style: TextStyle(color: Colors.white),
            //     textScaleFactor: 1.3,
            //   ),
            //   onTap: () => Navigator.pushNamed(context, "/updates"),
            // ),
            ListTile(
              leading:
              const Icon(CupertinoIcons.person_3_fill, color: Colors.white),
              title: const Text(
                "inward",
                style: TextStyle(color: Colors.white),
                textScaleFactor: 1.3,
              ),
              onTap: () => Navigator.pushNamed(context, "/inward"),
            ),
            ListTile(
              leading:
              const Icon(CupertinoIcons.person_3_fill, color: Colors.white),
              title: const Text(
                "Outward",
                style: TextStyle(color: Colors.white),
                textScaleFactor: 1.3,
              ),
              onTap: () => Navigator.pushNamed(context, "/outward"),
            ),
            ListTile(
              leading:
              const Icon(CupertinoIcons.person_3_fill, color: Colors.white),
              title: const Text(
                "Confirmation",
                style: TextStyle(color: Colors.white),
                textScaleFactor: 1.3,
              ),
              onTap: () => Navigator.pushNamed(context, "/confirm"),
            ),
            ListTile(
              leading:
              const Icon(CupertinoIcons.person_3_fill, color: Colors.white),
              title: const Text(
                "Inventory",
                style: TextStyle(color: Colors.white),
                textScaleFactor: 1.3,
              ),
              onTap: () => Navigator.pushNamed(context, "/inventory"),
            ),
            ListTile(
              leading:
              const Icon(CupertinoIcons.person_3_fill, color: Colors.white),
              title: const Text(
                "History",
                style: TextStyle(color: Colors.white),
                textScaleFactor: 1.3,
              ),
              onTap: () => Navigator.pushNamed(context, "/history"),
            ),
          ],
        ),
      ),
    );
  }
}
