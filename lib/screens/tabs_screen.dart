import 'package:flutter/material.dart';
import 'package:sher_in_the_city/screens/india_screen.dart';
import 'package:sher_in_the_city/screens/world_screen.dart';

class TabsScreen extends StatefulWidget {
  final Function changeTheme;

  TabsScreen(this.changeTheme);
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: new AppBar(
          elevation: 5,
          flexibleSpace: new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              new TabBar(
                indicatorWeight: 3,
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle: TextStyle(
                  fontSize: 17,
                ),
                tabs: [
                  Tab(
                    text: '       India       ',
                  ),
                  Tab(
                    text: '       World       ',
                  ),
                ],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            IndiaScreen(widget.changeTheme),
            WorldScreen(widget.changeTheme)
          ],
        ),
      ),
    );
  }
}
