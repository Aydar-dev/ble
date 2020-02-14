import 'package:flutter/material.dart';
import 'package:ble/index.dart';


class Home extends StatefulWidget {
  Home({Key key, @required this.pin}) : super(key: key);
  final String pin;
  @override
  _HomeState  createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    final cols2 = [
      new DataColumn(
        label: const Text('Type'),
      ),
      new DataColumn(
        label: const Text('Value'),
      ),
    ];

    final rows2 = DataRow(
        cells: [
          new DataCell(new Text('Ток:')),
          new DataCell(new Text('12.3 A')),
        ]
    );
    final rows3 = DataRow(
        cells: [
          new DataCell(new Text('Напряжение:')),
          new DataCell(new Text('220.25 V')),
        ]
    );

    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Material(
                  elevation: 4,
                  shape:  new StadiumBorder(side: new BorderSide(
                    style: BorderStyle.solid,
                  )),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 10,),
                          child:ClipRRect(
                            borderRadius: BorderRadius.circular(75),
                            child: Image.asset("assets/logo/kuat_point_logo.jpg", width: 150, height: 150,),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text("QuatPoint", style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),),
                        )
                      ],
                    )
                  ),
                )
              ),
              Container(
                child: new DataTable(columns: cols2, rows: [rows2, rows3]),
              ),
              Container(
                child: OutlineButton(
                  child: Text("войти снова"),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext ctx) {
                        return IndexPage();
                      }));
                  }
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}