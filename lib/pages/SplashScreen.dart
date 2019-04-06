import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http_client_helper/http_client_helper.dart';
import 'package:retailapps/pages/home.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  var _visible = true;

  AnimationController animationController;
  Animation<double> animation;

  SharedPreferences sharedPreferences;

  CancellationToken cancellationToken;
  String msg = "";

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    fetchUsersFromGitHub();
    setState(() {

    });
  }

  Future<List> fetchUsersFromGitHub() async {

    sharedPreferences = await SharedPreferences.getInstance();

    String client_id = "VALRYLJl1Cx8Lh0GYAKvtAztJaLd0JtWE3To1uRypi";
    String client_secret = "Qw8vgwq1uVHrZpOlmeuWGsgOFpB8FL78rkxQ9IeOX5";
    String grant_type = "client_credentials";

    Map datas = {
      'client_id': client_id,
      'client_secret': client_secret,
      'grant_type': grant_type
    };

    var url = 'https://api.moltin.com/oauth/access_token';

    cancellationToken = new CancellationToken();

    try {
      await HttpClientHelper.post(url,
          body: datas,
          cancelToken: cancellationToken,
          timeRetry: Duration(milliseconds: 1000),
          retries: 10)
          .then((response) async {
            if (response.statusCode == 200){

              Map<String, dynamic> value = json.decode(response.body);
              String access_token = value['access_token'];

              sharedPreferences.setString("access_token", access_token);
              sharedPreferences.commit();

              print("#### Splash Screen Akses Token " + access_token);

              Navigator.pushReplacement(context, new MaterialPageRoute(builder: (BuildContext context) => new MyApp()));

            } else {
              _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Atutentikasi gagal'), duration: Duration(seconds: 3),));
            }

      });
    } on OperationCanceledError catch (e) {
      setState(() {
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Cancel'), duration: Duration(seconds: 3),));
      });
    } catch (e) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(e.toString()), duration: Duration(seconds: 3),));
    }
  }

  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));
    animation =
    new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Container(
              decoration: new BoxDecoration(color: Colors.white)
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image.asset(
                'assets/shopping.png',
                width: animation.value * 250,
                height: animation.value * 250,
              ),
            ],
          ),
        ],
      ),
    );
  }
}