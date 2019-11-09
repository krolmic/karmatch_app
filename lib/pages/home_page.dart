import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import '../models/user.dart';
import '../providers/authentication_service.dart';
import '../common_widgets/dialog.dart';
import '../constants.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import './detail_page.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<void> _signOut(BuildContext context) async {
    try {
      final AuthenticationService auth =
          Provider.of<AuthenticationService>(context);
      await auth.signOut();
    } on PlatformException catch (e) {
      await PlatformExceptionAlertDialog(
        title: Strings.logoutFailed,
        exception: e,
      ).show(context);
    }
  }

  List<String> images = [
    "assets/images/adam-stefanca-hdMSxGizchk-unsplash.jpg",
    "assets/images/dhiva-krishna-GRV4ypBKgxE-unsplash.jpg",
    "assets/images/eduardo-flores-xpcUYaZtplI-unsplash.jpg",
    "assets/images/joey-banks-YApiWyp0lqo-unsplash.jpg",
    "assets/images/lance-asper-N9Pf2J656aQ-unsplash.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    CardController controller; //Use this to trigger swap.

    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          child: TinderSwapCard(
            orientation: AmassOrientation.BOTTOM,
            totalNum: images.length,
            stackNum: 2,
            swipeEdge: 3,
            maxWidth: MediaQuery.of(context).size.width * 0.9,
            maxHeight: MediaQuery.of(context).size.width * 0.9,
            minWidth: MediaQuery.of(context).size.width * 0.8,
            minHeight: MediaQuery.of(context).size.width * 0.8,
            cardBuilder: (context, index) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>Details()),
                );
              },
              child: Card(
                child: Image.asset(
                  '${images[index]}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            cardController: controller = CardController(),
            swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
              log(align.toString());

              /// Get swiping card's alignment
              if (align.x < 0) {
                //Card is LEFT swiping
              } else if (align.x > 0) {
                //Card is RIGHT swiping
              }
            },
            swipeCompleteCallback:
                (CardSwipeOrientation orientation, int index) {
              log(orientation.toString());
              /// Get orientation & index of swiped card!
            },
          ),
        ),
      ),
    );
//    final user = Provider.of<User>(context);
//
//    return Scaffold(
//      key: _scaffoldKey,
//      drawer: Drawer(
//        child: ListView(
//          padding: EdgeInsets.zero,
//          children: <Widget>[
//            DrawerHeader(
//              child: Text(
//                'karmatch',
//                style: TextStyle(color: Colors.white),
//              ),
//              decoration: BoxDecoration(
//                color: Colors.deepOrange,
//              ),
//            ),
//            ListTile(
//              title: Text('Log out'),
//              onTap: () => _signOut(context),
//            ),
//          ],
//        ),
//      ),
//      appBar: AppBar(
//        title: Text("karmatch"),
//      ),
//      body: _buildUserInfo(user),
//      floatingActionButton: FloatingActionButton(
//        child: Icon(
//          Icons.add,
//        ),
//      ),
//    );
  }

  Widget _buildUserInfo(User user) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (user.displayName != null)
          Center(
            child: Text(
              user.displayName,
              style: TextStyle(color: Colors.black),
            ),
          ),
        SizedBox(height: 8),
      ],
    );
  }
}
