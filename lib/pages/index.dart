import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:puja_donation/models/data.dart';
import '../theme/colors.dart';
import 'dart:async';

class IndexPage extends StatefulWidget {
  IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {


  Future<List<Data>> getData() async {
    List<Data> datalist = [];
    try {
      // This is an open REST API endpoint for testing purposes
      const apiUrl = 'https://script.google.com/macros/s/AKfycbyukUEho6jkUxpKSDCVqTTMlObbq44W5k6_0V9LnxivgwkgV_d6CVGHIykxJFIhDSE8EA/exec';

      final http.Response response = await http.get(Uri.parse(apiUrl));
      var jsonBar = jsonDecode(response.body);
      var data = jsonBar["data"];
      for (var d in data)
      {
        Data data = Data(d["name"], d["image"], d["targetdonation"], d["givendonation"]);
        datalist.add(data);
      }

    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
    return datalist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: Center(child: Text("Pronami List", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),)),
      ),
        body: FutureBuilder(
            future: getData(),
            builder: (context,AsyncSnapshot<List<Data>> snaphot)=>
            snaphot.hasData?
                ListView.builder(
                  itemCount: snaphot.data!.length,
                  itemBuilder: (context, index){
                    return Card(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: ListTile(
                          title: Row(
                            children: <Widget>[
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                    color: primary,
                                    borderRadius: BorderRadius.circular(70/2),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image:
                                        NetworkImage(snaphot.data![index].image)
                                    )
                                ),
                              ),
                              SizedBox(width: 10,),
                              Column(
                                children: <Widget>[
                                  Container(
                                      width: 200,
                                      child: Text(snaphot.data![index].name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                                  SizedBox(height: 5,),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(5,0,0,0),
                                      child: Container(
                                        width: 200,
                                        child: Row(
                                          children: <Widget>[
                                            Text("Target Pronami : ", style: TextStyle(fontSize: 16),),
                                            SizedBox(width: 5,),
                                            Text(snaphot.data![index].targetdonation.toString()+"tk", style: TextStyle(fontSize: 18),),
                                          ],
                                        ),
                                      ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(5,0,0,0),
                                    child: Container(
                                    width: 200,
                                    child: Row(
                                        children: <Widget>[
                                          Text("Given Pronami : ", style: TextStyle(fontSize: 16),),
                                          SizedBox(width: 10,),
                                          Text("${snaphot.data![index].givendonation}tk", style: TextStyle(fontSize: 18),),
                                        ]
                                    ),
                                  ),)
                                ]
                              )
                            ]
                          )
                        )
                      )
                    );
                  }):
            const Center(
              child: CircularProgressIndicator(),
            )
        )
    );
  }
}
