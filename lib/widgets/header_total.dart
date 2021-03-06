import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sher_in_the_city/theme/constants.dart';
import '../main.dart';
import '../models/india.dart';

class HeaderTotal extends StatefulWidget {
  final India india;
  final Function changeTheme;
  HeaderTotal(this.india, this.changeTheme);

  @override
  _HeaderTotalState createState() => _HeaderTotalState();
}

class _HeaderTotalState extends State<HeaderTotal> {
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
                  color: MyApp.isDarkTheme ? Colors.grey : Color(0xff919191),
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
    DateTime date = new DateFormat("dd/MM/yyyy HH:mm:ss")
        .parse(widget.india.lastupdatedtime);

    return Stack(
      children: [
        Container(
          height: 150,
          color: Theme.of(context).primaryColor,
        ),
        Positioned(
          right: 25,
          top: 15,
          child: Container(
            height: 40,
            width: 40,
            child: IconButton(
                icon: MyApp.isDarkTheme
                    ? SvgPicture.asset(
                        MyApp.sun,
                        color: Colors.black,
                      )
                    : SvgPicture.asset(
                        MyApp.moon,
                        color: Colors.white,
                      ),
                onPressed: () {
                  widget.changeTheme();
                }),
          ),
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
                  color: MyApp.isDarkTheme ? Colors.black : Colors.white,
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
                  color: MyApp.isDarkTheme ? Colors.black : Colors.white,
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
              color: MyApp.isDarkTheme ? Color(0xff363636) : Colors.white,
              elevation: 8,
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      buildIcon(
                          'CONFIRMED',
                          widget.india.confirmed,
                          widget.india.deltaconfirmed,
                          MyApp.isDarkTheme ? kbLightRed : Colors.red,
                          MyApp.confirmed),
                      buildIcon(
                          'RECOVERED',
                          widget.india.recovered,
                          widget.india.deltarecovered,
                          MyApp.isDarkTheme ? kbLightGreen : Colors.green,
                          MyApp.recovered),
                      buildIcon(
                          'DEATHS',
                          widget.india.deaths,
                          widget.india.deltadeaths,
                          MyApp.isDarkTheme ? kbLightPurple : Colors.deepPurple,
                          MyApp.death),
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

  print("BE time is $past");
  print("now time is $date");
  print("difference is $difference");

  if (hours == 0 && minutes == 0) {
    return '$seconds seconds ago';
  } else if (hours > 0 && hours < 24) {
    return '$hours hours $minutes minutes ago';
  } else if (minutes > 0) {
    return '$minutes minutes ago';
  } else {
    return DateFormat('MMM dd, YYYY').format(past).toString();
  }
}
