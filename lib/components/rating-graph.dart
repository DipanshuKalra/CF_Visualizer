import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SimpleTimeSeriesChart extends StatefulWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final dates;
  final ratings;

  SimpleTimeSeriesChart(this.seriesList,
      {this.animate, this.ratings, this.dates});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory SimpleTimeSeriesChart.withSampleData() {
    return new SimpleTimeSeriesChart(
      _createSampleData(),
      animate: false,
    );
  }

  @override
  _SimpleTimeSeriesChartState createState() => _SimpleTimeSeriesChartState();

  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    final data = null;

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
}

class _SimpleTimeSeriesChartState extends State<SimpleTimeSeriesChart> {
  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      widget.seriesList,
      animate: widget.animate,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }
}

class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
