import 'package:codeforces_data_flutter/components/profile_list_tile.dart';
import 'package:codeforces_data_flutter/networking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:codeforces_data_flutter/main.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:codeforces_data_flutter/components/rating-graph.dart';

bool isOpen = false;

class Profile extends StatefulWidget {
  final String username;
  Profile({this.username});
  @override
  _ProfileState createState() => _ProfileState();
}

var data;
var ratingData;
List<int> ratings = [];
List<DateTime> dates = [];
List<TimeSeriesSales> temp = [];

class _ProfileState extends State<Profile> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  List<String> items = [];

  void getData() async {
    NetworkHelper helper = NetworkHelper(
        url: 'http://codeforces.com/api/user.info?handles=${widget.username}');
    NetworkHelper ratingHelper = NetworkHelper(
        url:
            'https://codeforces.com/api/user.rating?handle=${widget.username}');
    ratingData = await ratingHelper.getData();
    var ratingDateAndValue = ratingData['result'];
    ratingDateAndValue.forEach(
      (map) {
        map.forEach(
          (k, v) {
            if (k == 'newRating') {
              ratings.add(v);
            }
            if (k == 'ratingUpdateTimeSeconds') {
              dates.add(DateTime.fromMillisecondsSinceEpoch(v * 1000));
            }
          },
        );
      },
    );

    for (int i = 1; i < ratings.length; i++) {
      temp.add(
        new TimeSeriesSales(
            new DateTime(dates[i].year, dates[i].month, dates[i].day),
            ratings[i]),
      );
    }

    data = await helper.getData();
    var usrMap = data['result'][0];
    usrMap.forEach(
      (k, v) {
        if (k == 'lastOnlineTimeSeconds' || k == 'registrationTimeSeconds') {
          items.add(k.toString() +
              ' : ' +
              DateTime.fromMillisecondsSinceEpoch(v * 1000)
                  .toLocal()
                  .toString());
        } else if (k != 'avatar' && k != 'titlePhoto') {
          items.add(k.toString() + ' : ' + v.toString());
        }
      },
    );
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    data = null;
    temp.clear();
    ratingData = null;
    ratings.clear();
    dates.clear();
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
                controller: _scrollController,
                thickness: 7.0,
                isAlwaysShown: true,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: ScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          color: Provider.of<Data>(context).isDark
                              ? Colors.black
                              : Colors.white,
                          height: 200.0,
                          child: Image.network(
                            data['result'][0]['titlePhoto'],
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ProfileListTile(
                            textToDisplay: items[index],
                          );
                        },
                      ),
                      ExpansionTile(
                        trailing: Icon(
                          Icons.keyboard_arrow_down,
                          color: Provider.of<Data>(context).isDark
                              ? Colors.white
                              : Colors.black,
                        ),
                        title: Text(
                          'Rating Graph',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Provider.of<Data>(context).isDark
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        children: [
                          Container(
                            height: 500.0,
                            child: new SimpleTimeSeriesChart(
                              _createSampleData(),
                              ratings: ratings,
                              dates: dates,
                            ),
                          ),
                        ],
                        onExpansionChanged: (isOpen) {
                          isOpen = !isOpen;
                        },
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

List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
  List<TimeSeriesSales> data = temp;
  return [
    new charts.Series<TimeSeriesSales, DateTime>(
      id: 'Sales',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (TimeSeriesSales sales, _) => sales.time,
      measureFn: (TimeSeriesSales sales, _) => sales.sales,
      data: data,
    )
  ];
}
