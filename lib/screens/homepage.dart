import 'package:codeforces_data_flutter/main.dart';
import 'package:codeforces_data_flutter/screens/upcoming_contests.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:codeforces_data_flutter/screens/profile.dart';
import 'package:codeforces_data_flutter/screens/previous_contests.dart';
import 'package:codeforces_data_flutter/screens/about.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final String username;
  HomePage({this.username});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetsToDisplay = [
      Profile(
        username: widget.username,
      ),
      Previous(),
      Upcoming(),
      About(),
    ];
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Provider.of<Data>(context).isDark
              ? Color(0xFF1A1110)
              : Colors.blue,
        ),
        drawer: Drawer(
          child: Container(
            color:
                Provider.of<Data>(context).isDark ? Colors.black : Colors.white,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                          child: Text('${widget.username[0].toUpperCase()}')),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        '${widget.username}',
                        style: TextStyle(
                          color: Provider.of<Data>(context).isDark
                              ? Colors.white
                              : Colors.black,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Provider.of<Data>(context).isDark
                          ? Color(0xFF1A1110)
                          : Colors.blue),
                ),
                ListTile(
                  leading: Icon(
                    Icons.dark_mode,
                    color: Provider.of<Data>(context).isDark
                        ? Colors.white
                        : Colors.grey,
                  ),
                  trailing: Switch(
                    value: Provider.of<Data>(context).isDark,
                    onChanged: (value) {
                      Provider.of<Data>(context, listen: false)
                          .changeState(value);
                    },
                  ),
                  title: Text(
                    'Dark Mode',
                    style: TextStyle(
                        color: Provider.of<Data>(context).isDark
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.refresh,
                    color: Provider.of<Data>(context).isDark
                        ? Colors.white
                        : Colors.grey,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  title: Text(
                    'Reset Handle',
                    style: TextStyle(
                        color: Provider.of<Data>(context).isDark
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.profile_circled,
              ),
              label: 'User Profile',
              backgroundColor: Colors.teal,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.arrow_counterclockwise,
              ),
              label: 'Previous Contest',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.arrow_clockwise,
              ),
              label: 'Upcoming Contest',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.suit_heart,
              ),
              label: 'About',
              backgroundColor: Colors.pink,
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.yellow,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
        body: widgetsToDisplay[selectedIndex],
      ),
    );
  }
}
