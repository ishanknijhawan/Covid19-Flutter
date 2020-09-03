import 'package:flutter/foundation.dart';

class World {
  final String Country;
  final String CountryCode;
  final String Slug;
  final int NewConfirmed;
  final int TotalConfirmed;
  final int NewDeaths;
  final int TotalDeaths;
  final int NewRecovered;
  final int TotalRecovered;
  final String Date;

  World({
    @required this.Country,
    @required this.CountryCode,
    @required this.Slug,
    @required this.NewConfirmed,
    @required this.TotalConfirmed,
    @required this.NewDeaths,
    @required this.TotalDeaths,
    @required this.NewRecovered,
    @required this.TotalRecovered,
    @required this.Date,
  });
}
