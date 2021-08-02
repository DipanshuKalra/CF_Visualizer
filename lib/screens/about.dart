import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttericon/brandico_icons.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:codeforces_data_flutter/main.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            Provider.of<Data>(context).isDark ? Colors.black : Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                CupertinoIcons.chart_bar_fill,
                color: Colors.green,
                size: 100.0,
              ),
              Text(
                'CodeForces Visualizer',
                style: TextStyle(
                    fontSize: 30.0,
                    color: Provider.of<Data>(context).isDark
                        ? Colors.white
                        : Colors.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 50.0,
              ),
              Text(
                'Dipanshu Kalra',
                style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Provider.of<Data>(context).isDark
                        ? Colors.white
                        : Colors.black),
                textAlign: TextAlign.center,
              ),
              Text(
                'FLUTTER DEVELOPER',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20.0,
                    color: Provider.of<Data>(context).isDark
                        ? Colors.white
                        : Colors.black),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      Brandico.github_1,
                      size: 50.0,
                      color: Provider.of<Data>(context).isDark
                          ? Colors.white
                          : Colors.black,
                    ),
                    onPressed: () {
                      _launchURL('https://github.com/DipanshuKalra');
                    },
                  ),
                  SizedBox(
                    width: 40.0,
                  ),
                  IconButton(
                    icon: Icon(
                      Brandico.linkedin_rect,
                      size: 50.0,
                      color: Provider.of<Data>(context).isDark
                          ? Colors.white
                          : Colors.black,
                    ),
                    onPressed: () {
                      _launchURL(
                          'https://www.linkedin.com/in/dipanshu-kalra-4a2b3b1ab/');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _launchURL(String _url) async {
  await canLaunch(_url) ? await launch(_url) : print('Could not launch $_url');
}
