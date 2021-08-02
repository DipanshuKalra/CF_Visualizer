import 'package:codeforces_data_flutter/components/upcoming-list-tile.dart';
import 'package:flutter/material.dart';
import 'package:codeforces_data_flutter/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:codeforces_data_flutter/main.dart';

class Upcoming extends StatefulWidget {
  @override
  _UpcomingState createState() => _UpcomingState();
}

var data1;
var data2;
var data3;
var data4;

class _UpcomingState extends State<Upcoming> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  List<String> codeforcesContests = [];
  List<String> codechefContests = [];
  List<String> hackerrankContests = [];
  List<String> hackerearthContests = [];
  List<String> codeforcesContestsURL = [];
  List<String> codechefContestsURL = [];
  List<String> hackerrankContestsURL = [];
  List<String> hackerearthContestsURL = [];
  List<String> codeforcesContestsDateTime = [];
  List<String> codechefContestsDateTime = [];
  List<String> hackerrankContestsDateTime = [];
  List<String> hackerearthContestsDateTime = [];

  void getData() async {
    //Codeforces
    NetworkHelper helper1 =
        NetworkHelper(url: 'https://kontests.net/api/v1/codeforces');
    data1 = await helper1.getData();

    for (int i = 0; i < data1.length; i++) {
      codeforcesContests.add(data1[i]['name']);
      codeforcesContestsURL.add(data1[i]['url']);
      codeforcesContestsDateTime.add(data1[i]['start_time']);
    }

    //Codechef
    NetworkHelper helper2 =
        NetworkHelper(url: 'https://kontests.net/api/v1/code_chef');
    data2 = await helper2.getData();

    for (int i = 0; i < data2.length; i++) {
      codechefContests.add(data2[i]['name']);
      codechefContestsURL.add(data2[i]['url']);
      codechefContestsDateTime.add(data2[i]['start_time']);
    }

    //Hackerrank
    NetworkHelper helper3 =
        NetworkHelper(url: 'https://kontests.net/api/v1/hacker_rank');
    data3 = await helper3.getData();

    for (int i = 0; i < data3.length; i++) {
      hackerrankContests.add(data3[i]['name']);
      hackerrankContestsURL.add(data3[i]['url']);
      hackerrankContestsDateTime.add(data3[i]['start_time']);
    }

    //Hackerearth
    NetworkHelper helper4 =
        NetworkHelper(url: 'https://kontests.net/api/v1/hacker_earth');
    data4 = await helper4.getData();

    for (int i = 0; i < data4.length; i++) {
      hackerearthContests.add(data4[i]['name']);
      hackerearthContestsURL.add(data4[i]['url']);
      hackerearthContestsDateTime.add(data4[i]['start_time']);
    }
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    data1 = null;
  }

  @override
  Widget build(BuildContext context) {
    return (data1 != null && data2 != null && data3 != null && data4 != null)
        ? SafeArea(
            child: Scaffold(
              backgroundColor: Provider.of<Data>(context).isDark
                  ? Colors.black
                  : Colors.white,
              body: Scrollbar(
                thickness: 7.0,
                isAlwaysShown: true,
                interactive: true,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  child: Column(
                    children: [
                      ExpansionTile(
                        trailing: Icon(
                          Icons.keyboard_arrow_down,
                          color: Provider.of<Data>(context).isDark
                              ? Colors.white
                              : Colors.black,
                        ),
                        title: Text(
                          'Codeforces',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Provider.of<Data>(context).isDark
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        onExpansionChanged: (codeforcesExpanded) {
                          setState(() {
                            codeforcesExpanded = !codeforcesExpanded;
                          });
                        },
                        children: [
                          ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return CustomListTile(
                                textToDisplay: codeforcesContests[index],
                                contestURL: codeforcesContestsURL[index],
                                startTime: codeforcesContestsDateTime[index],
                              );
                            },
                            itemCount: codeforcesContests.length,
                          ),
                        ],
                      ),
                      ExpansionTile(
                        trailing: Icon(
                          Icons.keyboard_arrow_down,
                          color: Provider.of<Data>(context).isDark
                              ? Colors.white
                              : Colors.black,
                        ),
                        title: Text(
                          'CodeChef',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Provider.of<Data>(context).isDark
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        onExpansionChanged: (codeforcesExpanded) {
                          setState(() {
                            codeforcesExpanded = !codeforcesExpanded;
                          });
                        },
                        children: [
                          ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return CustomListTile(
                                textToDisplay: codechefContests[index],
                                contestURL: codechefContestsURL[index],
                                startTime: codechefContestsDateTime[index],
                              );
                            },
                            itemCount: codechefContests.length,
                          ),
                        ],
                      ),
                      ExpansionTile(
                        trailing: Icon(
                          Icons.keyboard_arrow_down,
                          color: Provider.of<Data>(context).isDark
                              ? Colors.white
                              : Colors.black,
                        ),
                        title: Text(
                          'HackerRank',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Provider.of<Data>(context).isDark
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        onExpansionChanged: (codeforcesExpanded) {
                          setState(() {
                            codeforcesExpanded = !codeforcesExpanded;
                          });
                        },
                        children: [
                          ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return CustomListTile(
                                textToDisplay: hackerrankContests[index],
                                contestURL: hackerrankContestsURL[index],
                                startTime: hackerrankContestsDateTime[index],
                              );
                            },
                            itemCount: hackerrankContests.length,
                          ),
                        ],
                      ),
                      ExpansionTile(
                        trailing: Icon(
                          Icons.keyboard_arrow_down,
                          color: Provider.of<Data>(context).isDark
                              ? Colors.white
                              : Colors.black,
                        ),
                        title: Text(
                          'HackerEarth',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Provider.of<Data>(context).isDark
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        onExpansionChanged: (codeforcesExpanded) {
                          setState(() {
                            codeforcesExpanded = !codeforcesExpanded;
                          });
                        },
                        children: [
                          ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return CustomListTile(
                                textToDisplay: hackerearthContests[index],
                                contestURL: hackerearthContestsURL[index],
                                startTime: hackerearthContestsDateTime[index],
                              );
                            },
                            itemCount: hackerearthContests.length,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : SafeArea(
            child: Scaffold(
              backgroundColor: Provider.of<Data>(context).isDark
                  ? Colors.black
                  : Colors.white,
              body: Center(
                child: SpinKitWave(
                  color: Colors.teal,
                  size: 60.0,
                ),
              ),
            ),
          );
  }
}
