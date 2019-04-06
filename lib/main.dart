import 'package:flutter/material.dart';
import 'package:retailapps/pages/SplashScreen.dart';


String ANIMATED_SPLASH = '/pages/SplashScreen';

void main() => runApp(MaterialApp(
  theme: ThemeData(fontFamily: "Quicksand", primaryColor: Color(0xff215AED)),
  debugShowCheckedModeBanner: false,
  home: SplashScreen(),
  routes: getRoutes(),
));

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    ANIMATED_SPLASH: (BuildContext context) => new SplashScreen(),
  };
}