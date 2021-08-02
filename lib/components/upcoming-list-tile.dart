import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:codeforces_data_flutter/main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CustomListTile extends StatefulWidget {
  final String textToDisplay;
  final String contestURL;
  final String startTime;
  CustomListTile(
      {this.textToDisplay, this.contestURL = "", this.startTime = ''});

  @override
  _CustomListTileState createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  FlutterLocalNotificationsPlugin fltrNotification;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var androidInitialize = AndroidInitializationSettings('icon');
    var iosInitialize = IOSInitializationSettings();
    var initializationSettings =
        InitializationSettings(androidInitialize, iosInitialize);
    fltrNotification = FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initializationSettings);
  }

  _showNotification() async {
    var androidDetails = AndroidNotificationDetails(
      "Channel ID",
      "Channel Name",
      "Description",
      importance: Importance.Max,
      enableVibration: true,
      playSound: true,
      priority: Priority.Max,
      enableLights: true,
    );
    var iosDetails = IOSNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(androidDetails, iosDetails);

    String startTime;
    var scheduledTime =
        DateTime.parse(widget.startTime).toLocal().subtract(Duration(hours: 1));

    fltrNotification.schedule(
        0,
        'Contest Alert',
        '${widget.textToDisplay} starts in 1 hour!',
        scheduledTime,
        generalNotificationDetails);
  }

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
            _showMyDialog(context, widget.contestURL, widget.textToDisplay,
                widget.startTime);
          },
          title: Text(
            widget.textToDisplay,
            style: TextStyle(
              color: Provider.of<Data>(context).isDark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              _showNotification();
              SnackBar snackBar = SnackBar(
                  content: Text(
                      'You will be notified one hour before the contest. Yay!'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            icon: Icon(
              Icons.add_alert,
              color: Provider.of<Data>(context).isDark
                  ? Colors.white
                  : Colors.grey,
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
                  ((startTime != '')
                      ? DateTime.parse(startTime).toLocal().toString()
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
