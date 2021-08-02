import 'package:codeforces_data_flutter/components/previous-list-tile.dart';
import 'package:codeforces_data_flutter/components/upcoming-list-tile.dart';
import 'package:flutter/material.dart';
import 'package:codeforces_data_flutter/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:codeforces_data_flutter/main.dart';

class Previous extends StatefulWidget {
  @override
  _PreviousState createState() => _PreviousState();
}

var data;

class _PreviousState extends State<Previous> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  List<String> contestNames = [];
  List<String> contestURL = [];
  List<int> contestTimes = [];

  void getData() async {
    NetworkHelper helper =
        NetworkHelper(url: 'https://codeforces.com/api/contest.list?gym=false');
    data = await helper.getData();
    for (int i = 0; i < (data['result']).length; i++) {
      if (data['result'][i]['phase'] == 'FINISHED') {
        contestNames.add(data['result'][i]['name']);
        contestURL.add("https://codeforces.com/contest/" +
            data['result'][i]['id'].toString());
        contestTimes.add(data['result'][i]['startTimeSeconds']);
      }
    }

    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    data = null;
  }

  @override
  Widget build(BuildContext context) {
    return data != null
        ? SafeArea(
            child: Scaffold(
              backgroundColor: Provider.of<Data>(context).isDark
                  ? Colors.black
                  : Colors.white,
              body: Scrollbar(
                interactive: true,
                thickness: 7.0,
                isAlwaysShown: true,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return PreviousListTile(
                      textToDisplay: contestNames[index],
                      contestURL: contestURL[index],
                      startTime: contestTimes[index],
                    );
                  },
                  itemCount: contestNames.length,
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
