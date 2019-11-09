import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './models/user.dart';
import './providers/authentication_service.dart';
import './providers/authentication_service_adapter.dart';
import './auth_widget_builder.dart';
import './auth_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({this.initialAuthServiceType = AuthenticationServiceType.firebase});

  final AuthenticationServiceType initialAuthServiceType;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        Provider<AuthenticationService>(
          builder: (_) => AuthServiceAdapter(
            initialAuthServiceType: initialAuthServiceType,
          ),
          dispose: (_, AuthenticationService authService) => authService.dispose(),
        ),
      ],
      child: AuthWidgetBuilder(
        builder: (BuildContext context, AsyncSnapshot<User> userSnapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: Colors.deepOrange),
            home: AuthWidget(userSnapshot: userSnapshot),
          );
        },
      ),
    );
  }
}
