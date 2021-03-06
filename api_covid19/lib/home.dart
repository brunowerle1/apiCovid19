import 'package:api_covid19/widgets/countries_stats.dart';
import 'package:api_covid19/widgets/search.dart';
import 'package:api_covid19/widgets/world_stats.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _globalCount;
  var _countryData;

  void _getStats() async {
    final base = 'https://api.covid19api.com/';
    final url = base + 'summary';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      final _globalCount = jsonResponse['Global'];
      final _countryData = jsonResponse['Countries'];

      setState(() {
        this._globalCount = _globalCount;
        this._countryData = _countryData;
      });
    }
  }

  @override
  void initState() {
    _getStats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SearchBox(),
                SizedBox(height: 10),
                _globalCount != null
                    ? WorldStats(_globalCount, 'Dados Mundiais atualizados')
                    : Text(''),
                _countryData != null ? CountriesStats(_countryData) : Text(''),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
