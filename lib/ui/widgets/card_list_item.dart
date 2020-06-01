import 'package:finance_app/ui/widgets/alert_dialog_form.dart';
import 'package:finance_app/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class CardListItem extends StatelessWidget {
    int isPemasukan;
    String deskripsi;
    String tanggal;
    String rpFormat;

    CardListItem({
        @required this.isPemasukan,
        @required this.deskripsi,
        @required this.tanggal,
        @required this.rpFormat,
        Key key
    }) : super(key: key);

    Color getColor() {
        if (isPemasukan == 1) {
            return parsley;
        } else {
            return darkTan;
        }
    }

    final formatCurrency = new NumberFormat.simpleCurrency();

    @override
    Widget build(BuildContext context) {
        return Container(
            margin: EdgeInsets.only(bottom: 15, left: 25, right: 25),
            height: 65,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)
                ),
                boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 0),
                        blurRadius: 2,
                        spreadRadius: 0.1
                    )
                ],
            ),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                    SizedBox(
                        width: 55,
                        child: Icon(
                            (isPemasukan == 1) ? FontAwesomeIcons.arrowUp : FontAwesomeIcons.arrowDown,
                            size: 25,
                            color: getColor(),
                        ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                DefaultTextStyle(
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.title,
                                    child: Text(
                                        this.deskripsi,
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: getColor(),
                                            fontWeight: FontWeight.bold
                                        ),
                                    ),
                                ),
                                Text(
                                    this.tanggal,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w500
                                    ),
                                ),
                            ],
                        ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Container(
                            height: 30,
                            margin: EdgeInsets.only(left: 30, right: 10),
                            padding: EdgeInsets.all(5),
                            alignment: Alignment.centerRight,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(100)
                                ),
                                boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0, 0),
                                        blurRadius: 2,
                                        spreadRadius: 0.1
                                    )
                                ],
                            ),
                            child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                        // Icon(
                                        //     isPemasukan ? FontAwesomeIcons.plus : FontAwesomeIcons.minus,
                                        //     size: 13,
                                        //     color: getColor(),
                                        // ),
                                        Text(
                                            rpFormat,
                                            style: TextStyle(
                                                color: getColor(),
                                                fontWeight: FontWeight.bold
                                            ),
                                        ),
                                    ],
                                )
                            )
                        )
                    ),
                ],
            ),
        );
    }
}