import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uts/DBHelper/dbhelper.dart';
import 'package:uts/Model/mataKuliah.dart';
import 'dart:async';
import 'matakuliahEntryForm.dart';

class HomeMatkul extends StatefulWidget {
  @override
  HomeMatkulState createState() =>HomeMatkulState();

  }

class HomeMatkulState extends State<HomeMatkul> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<MataKuliah> mataKulihList;

  @override
  void initState() {
    super.initState();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    if (mataKulihList== null) {
      mataKulihList = [];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar List MataKulaih'),
      ),
      body: Column(children: [
        Expanded(
          child: createListView(),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              child: Text("Tambah MataKuliah"),
              onPressed: () async {
                var data = await navigateToEntryForm(context, null);
                if (data != null) {
                  int result = await dbHelper.insertMataKuliah(data);
                  if (result > 0) {
                    updateListView();
                  }
                }
              },
            ),
          ),
        ),
      ]),
    );
  }

  Future<MataKuliah> navigateToEntryForm(BuildContext context, MataKuliah mataKuliah) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
   return EntryForm(mataKuliah);
    }));
    return result;
  }

  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.headline5;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.ad_units),
            ),
            title: Text(
              this.mataKulihList[index].kodeMatkul.toString(),
              style: textStyle,
            ),
            subtitle: Text(this.mataKulihList[index].namaMatkul),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () async {
                dbHelper.deleteMataKuliah(this.mataKulihList[index].id);
                updateListView();
              },
            ),
            onTap: () async {
              var data =
                  await navigateToEntryForm(context, this.mataKulihList[index]);
              if (data != null) {
                int result = await dbHelper.updateMataKuliah(data);
                if (result > 0) {
                  updateListView();
                }
              }
            },
          ),
        );
      },
    );
  }

//update List
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      Future<List<MataKuliah>> mataKuliahListFuture = dbHelper.getMataKuliahList();
     mataKuliahListFuture.then((mataKuliahList) {
        setState(() {
          this.mataKulihList = mataKuliahList;
          this.count = mataKuliahList.length;
        });
      });
    });
  }
}