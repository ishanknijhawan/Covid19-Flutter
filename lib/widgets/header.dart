import 'package:flutter/material.dart';
import '../models/world.dart';
import '../widgets/header_total.dart';
import '../widgets/header_total_world.dart';
import '../models/india.dart';

class Header extends StatelessWidget {
  final String location;
  final India india;
  final World world;

  Header(this.location, this.india, this.world);

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
        location == 'States' ? HeaderTotal(india) : HeaderTotalWorld(world),
        Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 15),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    location,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              buildExpanded('Confirmed', Colors.red),
              buildExpanded('Recovered', Colors.green),
              buildExpanded('Deaths', Colors.deepPurple),
            ],
          ),
        ),
      ]),
    );
  }
}
