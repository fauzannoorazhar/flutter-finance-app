import 'package:finance_app/config/routes.dart';
import 'package:finance_app/ui/widgets/hex_color.dart';
import 'package:finance_app/utilities/constant.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primaryColor: java,
            ),
            onGenerateRoute: Routes().onGenerateRoute,
            initialRoute: homePage,
        );
    }
}