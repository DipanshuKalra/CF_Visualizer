import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:codeforces_data_flutter/main.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileListTile extends StatelessWidget {
  final String textToDisplay;

  ProfileListTile({this.textToDisplay});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Material(
        elevation: 10.0,
        child: ListTile(
          tileColor: Provider.of<Data>(context).isDark
              ? Color(0xFF1A1110)
              : Colors.white,
          title: Text(
            textToDisplay,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Provider.of<Data>(context).isDark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

void _launchURL(String _url) async {
  await canLaunch(_url) ? await launch(_url) : print('Could not launch $_url');
}
