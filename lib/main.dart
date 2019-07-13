import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: StarWarsData(),//https://cricapi.com/api/cricketScore?apikey=oJmzPtpZJXcIQmxAjOlP5Zss1At1&unique_id=1034809"
  ));
}

class StarWarsData extends StatefulWidget {
  @override
  StarWarsState createState() => StarWarsState();
}

class StarWarsState extends State<StarWarsData> {
  final String url = "https://cricapi.com/api/matchCalendar?apikey=oJmzPtpZJXcIQmxAjOlP5Zss1At1";
  List data;
  List<MaterialColor> colors = [
    Colors.blueGrey,
    Colors.brown,
    Colors.pink,
    Colors.grey
  ];

  Future<String> getSWData() async {
    var res =
    await http.get(Uri.parse(url), headers: {"Accept": "application/json"});

    setState(() {
      var resBody = json.decode(res.body);
      data = resBody["data"];
    });

    return "Success!";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Match Calendar"),
        backgroundColor: Colors.indigo,
      ),
      body: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            MaterialColor color = colors[index % colors.length];

            return new Card(
              margin: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  new GestureDetector(
                      child: Ink(
                        color: color,
                        child: ListTile(
                          title: Text(data[index]['name']),
                          subtitle: Text(data[index]['date'],
                              style: TextStyle(color: Colors.black87)),
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                  (new route(data,index,color)))),
                        ),
                      )
                  )


                ],
              ),
            );
          }
      ),

    );
  }

  @override
  void initState() {
    super.initState();
    this.getSWData();
  }
}
@override

  class route extends StatelessWidget{
  List data;
  MaterialColor color;
  int index;
  route(this.data,this.index,this.color);
  Widget build(BuildContext context){
  return Scaffold(
  appBar: AppBar(
  title: Text(data[index]['name']),
    backgroundColor: color,
  ),
  );
  }
  }

