import 'package:codeforces_data_flutter/screens/username.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return Data();
      },
      child: MaterialApp(
        home: UserName(),
      ),
    );
  }
}

class Data extends ChangeNotifier {
  bool isDark = false;

  void changeState(newState) {
    isDark = newState;
    notifyListeners();
  }
}
