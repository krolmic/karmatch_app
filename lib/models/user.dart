import 'package:meta/meta.dart';

@immutable
class User {
  const User({
    @required this.uid,
    this.displayName,
  });

  final String uid;
  final String displayName;
}
