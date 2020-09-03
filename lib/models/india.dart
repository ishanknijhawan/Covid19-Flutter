import 'package:flutter/foundation.dart';

class India {
  final String active;
  final String confirmed;
  final String deaths;
  final String deltaconfirmed;
  final String deltadeaths;
  final String deltarecovered;
  final String lastupdatedtime;
  final String migratedother;
  final String recovered;
  final String state;
  final String statecode;
  final String statenotes;

  India(
      {@required this.active,
      @required this.confirmed,
      @required this.deaths,
      @required this.deltaconfirmed,
      @required this.deltadeaths,
      @required this.deltarecovered,
      @required this.lastupdatedtime,
      @required this.migratedother,
      @required this.recovered,
      @required this.state,
      @required this.statecode,
      @required this.statenotes});
}
