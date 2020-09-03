import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../main.dart';
import '../models/world.dart';

class HeaderTotalWorld extends StatelessWidget {
  final World world;
  HeaderTotalWorld(this.world);
  RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  Function mathFunc = (Match match) => '${match[1]},';

  Widget buildIcon(String textStatus, int status, int deltaStatus, Color color,
      String image) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          textStatus,
          style: TextStyle(
            fontSize: 11,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          height: 55,
          width: 55,
          child: SvgPicture.asset(image, color: color),
        ),
        SizedBox(
          height: 6,
        ),
        Text(
          status.toString().replaceAllMapped(reg, mathFunc),
          style: TextStyle(
            fontSize: 16,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '↑${deltaStatus.toString().replaceAllMapped(reg, mathFunc)}',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var date1 = world.Date;
    if (date1.contains("T")) date1 = date1.replaceAll("T", " ");
    if (date1.contains("Z")) date1 = date1.replaceAll("Z", "");
    if (date1.contains("-")) date1 = date1.replaceAll("-", "/");

    DateTime date = new DateFormat("yyyy/MM/dd HH:mm:ss").parse(date1);
    print('coming here with date $date');

    return Stack(
      children: [
        Container(
          height: 150,
          color: Theme.of(context).primaryColor,
        ),
        Positioned(
          left: 25,
          top: 15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Covid19 Global Status',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                'Last updated ${getTimeAgo(date)}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Ubuntu',
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 150,
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(20, 60, 20, 20),
          child: Center(
            child: Card(
              elevation: 8,
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      buildIcon('CONFIRMED', world.TotalConfirmed,
                          world.NewConfirmed, Colors.red, MyApp.confirmed),
                      buildIcon('RECOVERED', world.TotalRecovered,
                          world.NewRecovered, Colors.green, MyApp.thermometer),
                      buildIcon('DECEASED', world.TotalDeaths, world.NewDeaths,
                          Colors.purple, MyApp.death),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

String getTimeAgo(DateTime past) {
  DateTime date = DateTime.now();
  var difference = date.difference(past);
  var hours = double.parse(difference.toString().split(':')[0]).round();
  var minutes = double.parse(difference.toString().split(':')[1]).round();
  var seconds = double.parse(difference.toString().split(':')[2]).round();

  print('present date is $date');
  print('past date is $past');
  print('difference is $difference');

  if (hours == 0 && minutes == 0) {
    return '$seconds seconds ago';
  } else if (minutes > 0) {
    return '$minutes minutes ago';
  } else if (hours > 0 && hours < 24) {
    return '$hours hours ago';
  } else {
    return DateFormat('MMM dd, YYYY').format(past).toString();
  }
}
