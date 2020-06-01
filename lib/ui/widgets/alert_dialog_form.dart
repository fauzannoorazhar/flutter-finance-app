import 'package:finance_app/models/finance.dart';
import 'package:finance_app/models/todo.dart';
import 'package:finance_app/ui/views/home_page.dart';
import 'package:finance_app/utilities/constant.dart';
import 'package:finance_app/utilities/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AlertDialogForm extends StatefulWidget {
    AlertDialogForm({Key key}) : super(key: key);

    @override
    _AlertDialogFormState createState() => _AlertDialogFormState();
}

enum Pilihan {
    spending, income
}

class _AlertDialogFormState extends State<AlertDialogForm> {
    final _formKey = GlobalKey<FormState>();

    Pilihan _pilihan = Pilihan.income;
    String rp;
    String deskripsi;
    String tanggal;

    TextEditingController rpController = TextEditingController();
    TextEditingController deskripsiController = TextEditingController();

    DatabaseHelper databaseHelper = DatabaseHelper();
    Finance finance;

    @override
    Widget build(BuildContext context) {
        return AlertDialog(
            backgroundColor: java,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(15)
                ),
            ),
            content: Form(
                key: _formKey,
                child: SingleChildScrollView(
                    child: Container(
                        width: 400,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                        _entyField('Rp', TextInputType.number, 1, rpController),
                                        _entyField('Deskripsi', TextInputType.text, 3, deskripsiController),
                                        Container(
                                            child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget>[
                                                    Expanded(
                                                        child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: <Widget>[
                                                                Radio(
                                                                    value: Pilihan.income,
                                                                    groupValue: _pilihan,
                                                                    onChanged: (Pilihan value) {
                                                                        setState(() {
                                                                            _pilihan = value;
                                                                        });
                                                                    }
                                                                ),
                                                                Text('Income')
                                                            ],
                                                        )
                                                    ),
                                                    Expanded(
                                                        child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: <Widget>[
                                                                Radio(
                                                                    value: Pilihan.spending,
                                                                    groupValue: _pilihan,
                                                                    onChanged: (Pilihan value) {
                                                                        setState(() {
                                                                            _pilihan = value;
                                                                        });
                                                                    }
                                                                ),
                                                                Text('Spending')
                                                            ],
                                                        )
                                                    ),
                                                ],
                                            )
                                        )
                                    ],
                                )
                            ],
                        ),
                    ),
                )
            ),
            actions: <Widget>[
                flatButton(
                    Text(
                        "Cancel",
                        style: TextStyle(fontSize: 20.0),
                    ),
                    false
                ),
                flatButton(
                    Text(
                        "Save",
                        style: TextStyle(fontSize: 20.0),
                    ),
                    true
                ),
            ],
        );
    }

    Widget _entyField(String label, TextInputType textInputType, int maxLines, TextEditingController textEditingController) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                Text('$label'),
                SizedBox(height: 5),
                TextFormField(
                    controller: textEditingController,
                    validator: (value) {
                        if (value.isEmpty) {
                            return '$label tidak boleh kosong';
                        }
                        return null;
                    },
                    maxLines: maxLines,
                    keyboardType: textInputType,
                    style: TextStyle(color: tangaroa),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                style: BorderStyle.none,
                                width: 0
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(10)
                            )
                        ),
                        fillColor: Colors.black38,
                        filled: true,
                    ),
                ),
                SizedBox(height: 15),
            ],
        );
    }

    flatButton(Widget child, bool isSave) {
        return FlatButton(
            color: tangaroa,
            textColor: Colors.white,
            padding: EdgeInsets.all(10),
            splashColor: java,
            onPressed: () {
                if (isSave) {
                    if (_formKey.currentState.validate()) {
                        _save();
                    }
                } else {
                    return Navigator.pop(context);
                }
            },
            child: child,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(12)
                ),
            ),
        );
    }

    void moveToLastScreen() {
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
        //Navigator.pop(context);
    }

    void _save() async {
        moveToLastScreen();

        String tanggal = DateFormat.yMMMd().format(DateTime.now());
        finance = new Finance(rpController.text, deskripsiController.text, tanggal, _pilihan.index);
        await databaseHelper.insertTodo(finance);
    }
}