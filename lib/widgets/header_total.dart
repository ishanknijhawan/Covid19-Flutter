import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../main.dart';
import '../models/india.dart';

class HeaderTotal extends StatelessWidget {
  final India india;
  HeaderTotal(this.india);
  final RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  final Function mathFunc = (Match match) => '${match[1]},';

  Widget buildIcon(String textStatus, String status, String deltaStatus,
      Color color, String image) {
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
          status.replaceAllMapped(reg, mathFunc),
          style: TextStyle(
            fontSize: 16,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        textStatus != 'ACTIVE'
            ? Text(
                '↑${deltaStatus.replaceAllMapped(reg, mathFunc)}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              )
            : Text(
                '',
                style: TextStyle(
                  fontSize: 14,
                ),
              )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime date =
        new DateFormat("dd/MM/yyyy HH:mm:ss").parse(india.lastupdatedtime);
    print('coming here with date ${india.lastupdatedtime}');

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
                'Covid19 Cases Overview',
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
                      buildIcon('CONFIRMED', india.confirmed,
                          india.deltaconfirmed, Colors.red, MyApp.confirmed),
                      buildIcon('RECOVERED', india.recovered, india.recovered,
                          Colors.green, MyApp.recovered),
                      buildIcon('DEATHS', india.deaths, india.deltadeaths,
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
