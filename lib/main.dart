import 'package:flutter/material.dart';

import 'city.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ListViews',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('ListViews')),
        body: BodyLayout(),
      ),
    );
  }
}

class BodyLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _myListView(context);
  }
}

Widget _myListView(BuildContext context) {
  final List<City> cities = [
    City(name: 'Kyiv', branchAmount: 2),
    City(name: 'Lviv', branchAmount: 5)
  ];

  return ListView.builder(
    itemCount: cities.length,
    itemBuilder: (context, index) {
      var city = cities[index];
      return ListTile(
          title: Text(city.name),
          subtitle: Text('branches: ${city.branchAmount}'),
          onTap: () => _doSomething());
    },
  );
}

_doSomething() {


}
