import 'package:finance_app/ui/views/home_page.dart';
import 'package:finance_app/ui/views/splash_page.dart';
import 'package:finance_app/utilities/constant.dart';
import 'package:flutter/material.dart';

class Routes {
    Route<dynamic> onGenerateRoute(RouteSettings settings) {
        switch (settings.name) {
            case homePage:
                return MaterialPageRoute(builder: (context) => HomePage());
                break;
            case splashPage:
                return MaterialPageRoute(builder: (context) => SplashPage());
                break;
            
            // if you want to pass parameters to views page
            //case feedRoute:
                //var data = settings.arguments as String;
                //return MaterialPageRoute(builder: (_) => Feed(data));
                //break;
            default:
                return MaterialPageRoute(
                    builder: (context) => Scaffold(
                        body: Center(
                        child: Text('No route defined for ${settings.name}')),
                    )
                );
                break;
        }
    }

}