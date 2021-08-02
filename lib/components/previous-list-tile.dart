import 'package:codeforces_data_flutter/screens/previous_contests.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:codeforces_data_flutter/main.dart';
import 'package:url_launcher/url_launcher.dart';

class PreviousListTile extends StatelessWidget {
  final String textToDisplay;
  final String contestURL;
  final int startTime;
  PreviousListTile(
      {this.textToDisplay, this.contestURL = "", this.startTime = 0});

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
          onTap: () {
            _showMyDialog(context, contestURL, textToDisplay, startTime);
          },
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

Future<void> _showMyDialog(context, url, textToDisplay, startTime) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(textToDisplay),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Start Time : ' +
                  ((startTime != 0)
                      ? DateTime.fromMillisecondsSinceEpoch(startTime * 1000)
                          .toString()
                      : 'No Data')),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OPEN'),
            onPressed: () {
              _launchURL(url);
            },
          ),
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
