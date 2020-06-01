import 'package:finance_app/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomCustome extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return BottomAppBar(
            shape: CircularNotchedRectangle(),
            color: tangaroa,
            child: Container(
                height: 60,
                child: Row(
                    children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: Container(
                                child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                        IconButton(
                                            icon: FaIcon(
                                                Icons.home,
                                                color: white,
                                            ),
                                            onPressed: null,
                                            iconSize: 30,
                                        ),
                                        Container(
                                            padding: EdgeInsets.only(top: 5),
                                            child: Text(
                                                'Home',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: white,
                                                    fontWeight: FontWeight.bold
                                                ),
                                            )
                                        )
                                    ],
                                )
                            )
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                                child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                        Container(
                                            padding: EdgeInsets.only(top: 5),
                                            child: Text(
                                                'History',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: white,
                                                    fontWeight: FontWeight.bold
                                                ),
                                            )
                                        ),
                                        IconButton(
                                            icon: FaIcon(
                                                Icons.history,
                                                color: white,
                                            ),
                                            onPressed: null,
                                            iconSize: 30,
                                        ),
                                    ],
                                )
                            )
                        ),
                    ],
                ),
            )
        );
    }
}