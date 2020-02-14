import 'package:flutter/material.dart';
import 'package:ble/auth/login.dart';


class IndexPage extends StatefulWidget {
  @override
  _IndexPageState  createState() {
    return _IndexPageState();
  }
}

class _IndexPageState extends State<IndexPage> {

  @override
  Widget build(BuildContext context) {
    double pad_with = (MediaQuery.of(context).size.width - 150)/2;
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: pad_with, left: pad_with, right: pad_with, bottom: pad_with),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(75),
                child: Image.asset("assets/logo/kuat_point_logo.jpg", width: 150, height: 150,),
              ),
            ),
            Container(
              child: OutlineButton(
                child: Text("Connect", style: TextStyle(
                  fontSize: 18,
                ),),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext ctx) {
                      return LoginPage();
                    }));
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}