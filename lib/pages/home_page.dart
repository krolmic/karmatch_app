import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import '../models/user.dart';
import '../providers/authentication_service.dart';
import '../common_widgets/dialog.dart';
import '../constants.dart';

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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'karmatch',
                style: TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
              ),
            ),
            ListTile(
              title: Text('Log out'),
              onTap: () => _signOut(context),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("karmatch"),
      ),
      body: _buildUserInfo(user),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
      ),
    );
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
