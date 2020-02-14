import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:ble/auth/home.dart';


class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool _unFocus = false;

  @override
  void initState() {
    setTimeOut();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.4),

          child: Center(
             child: Column(
                children: <Widget>[
//                  Container(
//                    child: ClipRRect(
//                    borderRadius: BorderRadius.circular(50),
//                      child: Image.asset("assets/logo/kuat_point_logo.jpg", width: 100, height: 100,),
//                    ),
//                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Center(
                      child: PinPut(
                        fieldsCount: 4,
                        autoFocus: false,
                        unFocusWhen: _unFocus,
                        onSubmit: (String pin) => _authPage(pin, context),
                        onClear: (String s) => _showSnackBar(false, context),
                      ),
                    ),
                  ),
                ],
            ),
          )
        )
      ));
  }

  void _authPage(String pin, BuildContext context){
    if(pin.toString() == "1234"){
      Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext ctx) {
          return Home(pin: pin.toString(),);
        }));
    }else{
      _showSnackBar(true, context);
    }
  }

  void _showSnackBar(bool ps, BuildContext context) {
    final snackBar = SnackBar(
      content: Container(
          height: 80.0,
          child: Center(
            child: ps?Text(
              'Sorry, the password is wrong',
              style: TextStyle(fontSize: 25.0),
            ):Text(
              'Clear!',
              style: TextStyle(fontSize: 25.0),
            )
          )),
      backgroundColor: Colors.greenAccent,
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void setTimeOut() {
    Stream<void>.periodic(Duration(seconds: 5)).listen((r) {
      setState(() {
        _unFocus = !_unFocus;
      });
    });
  }
}