import 'package:flutter/material.dart';
import '../main.dart';
import '../models/world.dart';
import '../widgets/header_total.dart';
import '../widgets/header_total_world.dart';
import '../models/india.dart';

class Header extends StatefulWidget {
  final String location;
  final India india;
  final World world;
  final Function changeTheme;

  Header(this.location, this.india, this.world, this.changeTheme);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  Widget buildExpanded(String status, Color color) {
    return Expanded(
      flex: 2,
      child: Container(
        alignment: Alignment.center,
        child: Text(
          status,
          style: TextStyle(
              fontSize: 15, color: color, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        widget.location == 'States'
            ? HeaderTotal(widget.india, widget.changeTheme)
            : HeaderTotalWorld(widget.world, widget.changeTheme),
        Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 15),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.location,
                    style: TextStyle(
                        fontSize: 15,
                        color: MyApp.isDarkTheme ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              MyApp.isDarkTheme
                  ? buildExpanded('Confirmed', Color(0xffff7597))
                  : buildExpanded('Confirmed', Colors.red),
              MyApp.isDarkTheme
                  ? buildExpanded('Recovered', Color(0xffa1ff62))
                  : buildExpanded('Recovered', Colors.green),
              MyApp.isDarkTheme
                  ? buildExpanded('Deaths', Color(0xffbb86fc))
                  : buildExpanded('Deaths', Colors.deepPurple),
            ],
          ),
        ),
      ]),
    );
  }
}
