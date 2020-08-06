import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

const CITIES_PATH = "cities";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baby Names',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  var data;

  @override
  void initState() {
    super.initState();
    getData().then((value) {
      setState(() => data = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Baby Name Votes')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (data != null) {
      return _buildList(context, data);
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Widget _buildList(BuildContext context, QuerySnapshot qShot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children:
          qShot.documents.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final city = City.fromMap(data.data);

    return Padding(
      key: ValueKey(city.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(city.name),
          trailing: Text(city.numberOfBranches.toString()),
          onTap: () => print(city),
        ),
      ),
    );
  }
}

class City {
  final String name;
  final int numberOfBranches;
  final DocumentReference reference;

  City.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['numberOfBranches'] != null),
        name = map['name'],
        numberOfBranches = map['numberOfBranches'];

  City.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$numberOfBranches>";
}

Future<QuerySnapshot> getData() async {
  QuerySnapshot snapshot =
      await Firestore.instance.collection(CITIES_PATH).getDocuments();
  return snapshot;
}
