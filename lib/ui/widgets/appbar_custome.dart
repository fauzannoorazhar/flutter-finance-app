import 'package:finance_app/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class AppBarCustome extends StatelessWidget {
    String rpTotal;
    String tanggal;

    AppBarCustome({
        @required this.rpTotal,
        @required this.tanggal,
        Key key
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Stack(
                children: <Widget>[
                    Positioned(
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        child: Container(
                            color: java,
                            padding: EdgeInsets.fromLTRB(25, 20, 10, 0),
                            child: SafeArea(
                                child: Stack(
                                    children: <Widget>[
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: FaIcon(
                                                FontAwesomeIcons.bars,
                                                size: 30,
                                                color: tangaroa
                                            )
                                        ),
                                        Positioned(
                                            top: 60,
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                    Text(
                                                        nameApp,
                                                        style: TextStyle(
                                                            fontSize: 30,
                                                            fontWeight: FontWeight.bold,
                                                            color: tangaroa
                                                        ),
                                                    ),
                                                    Text(
                                                        tagLineApp,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.bold,
                                                            color: tangaroa
                                                        ),
                                                    ),
                                                ],
                                            ),
                                        ),
                                        Align(
                                            alignment: Alignment.bottomRight,
                                            child: Image.asset(
                                                'lib/assets/images/images_header.png'
                                            ),
                                        )
                                    ],
                                )
                            )
                        )
                    ),
                    Positioned(
                        top: 180,
                        left: 20,
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 130,
                        child: Card(
                            semanticContainer: true,
                            elevation: 3,
                            child: Container(
                                padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                                'Total',
                                                style: TextStyle(
                                                    letterSpacing: 1,
                                                    fontSize: 15,
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.bold
                                                ),
                                            ),
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                        Container(
                                                            margin: EdgeInsets.only(right: 10),
                                                            child: Icon(
                                                                FontAwesomeIcons.wallet,
                                                                size: 45,
                                                                color: tangaroa,
                                                            ),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Text(
                                                            '${getRpFormater()}',
                                                            textAlign: TextAlign.right,
                                                            style: TextStyle(
                                                                fontSize: 45,
                                                                fontWeight: FontWeight.bold,
                                                                color: tangaroa
                                                            ),
                                                        ),
                                                    ],
                                                )
                                            )
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Align(
                                                alignment: Alignment.bottomRight,
                                                child: Text(
                                                    tanggal,
                                                    style: TextStyle(
                                                        letterSpacing: 1,
                                                        fontSize: 15,
                                                        color: Colors.black54,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                ),
                                            )
                                        ),
                                    ],
                                ),
                            )
                        )
                    ),
                ],
            ),
        );
    }

    final formatCurrency = new NumberFormat.currency(locale: "id_ID", symbol: "", decimalDigits: 0);
    String getRpFormater() {
        int total = int.parse(this.rpTotal);

        return this.formatCurrency.format(total);
    }
}