import 'package:finance_app/models/finance.dart';
import 'package:finance_app/ui/widgets/alert_dialog_form.dart';
import 'package:finance_app/ui/widgets/appbar_custome.dart';
import 'package:finance_app/ui/widgets/bottom_custome.dart';
import 'package:finance_app/ui/widgets/card_list_item.dart';
import 'package:finance_app/utilities/constant.dart';
import 'package:finance_app/utilities/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class HomePage extends StatefulWidget {
    HomePageState createState() {
        return HomePageState();
    }
}

class HomePageState extends State<HomePage> {

    DatabaseHelper databaseHelper = DatabaseHelper();
    List<Finance> listFinance;
    int count = 0;
    int _total = 0;
    String _tanggal;

    @override
    Widget build(BuildContext context) {
        if (listFinance == null) {
            updateList();
        }

        return Scaffold(
            body: _bodyHomePage(),
            bottomNavigationBar: BottomCustome(),
            floatingActionButton: FloatingActionButton(
                child: FaIcon(FontAwesomeIcons.plus),
                backgroundColor: tangaroa,
                mini: false,
                onPressed: () async {
                    return showDialog(
                        context: context,
                        builder: (context) => AlertDialogForm()
                    );
                }
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        );
    }

    Widget _bodyHomePage() {
        return Column(
            children: <Widget>[
                AppBarCustome(
                    rpTotal: _total.toString(),
                    tanggal: _tanggal ?? 'belum ada transaksi',
                ),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(top: 20),
                        child: (count != 0) ? ListView.builder(
                            itemCount: count,
                            itemBuilder: (BuildContext context, int posisition) {
                                return InkWell(
                                    onTap: () {
                                        _delete(context, this.listFinance[posisition]);
                                    },
                                    child: CardListItem(
                                        isPemasukan: this.listFinance[posisition].status,
                                        deskripsi: this.listFinance[posisition].deskripsi,
                                        tanggal:  this.listFinance[posisition].tanggal,
                                        rpFormat: this.listFinance[posisition].getRpFormater(),
                                    )
                                );
                            }
                        ) : Container(
                            alignment: Alignment.center,
                            child: Text('Data Tidak Ditemukan'),
                        )
                    )
                )
            ],
        );
    }

    void updateList() {
        final Future<Database> dbFuture = databaseHelper.initializeDatabase();
        dbFuture.then((database) {
            Future<List<Finance>> financeListFuture = databaseHelper.getTodoList();
            Future<int> calculateInt = databaseHelper.calculate();
            Future<List<Map<String, dynamic>>> getTanggalTerakhir = databaseHelper.getTanggalTerakhir();

            financeListFuture.then((financeList) {
                setState(() {
                    this.listFinance = financeList;
                    this.count = financeList.length;
                });
            });

            calculateInt.then((calculate) {
                setState(() {
                    this._total = calculate;
                });
            });

            getTanggalTerakhir.then((tanggal) {
                setState(() {
                    this._tanggal = tanggal[0]['tanggal'];
                });
            });
        });
    }

    void _delete(BuildContext context, Finance future) async {
        showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text('Hapus Data'),
                    content: Text('Apakah Anda yakin untuk menghapus data berikut?'),
                    actions: <Widget>[
                        FlatButton(
                            child: Text('Kembali'),
                            onPressed: () {
                                Navigator.pop(context);
                            },
                        ),
                        FlatButton(
                            child: Text('Hapus'),
                            onPressed: () async {
                                int result = await databaseHelper.deleteTodo(future.id);
                                    if (result != 0) {
                                    //_showSnackBar(context, 'Todo Deleted Successfully');
                                    updateList();
                                }
                                Navigator.pop(context);
                            },
                        ),
                    ],
                );
            }
        );
    }
}