//pendukung program asinkron
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uts/DBHelper/dbhelper.dart';
import 'package:uts/Model/mahasiswa.dart';
import 'dart:async';
import 'mahasiswaEntryForm.dart';

class HomeMhs extends StatefulWidget {
  @override
  HomeMhsState createState() => HomeMhsState();

  }

class HomeMhsState extends State<HomeMhs> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Mahasiswa> mahasiswaList;

  @override
  void initState() {
    super.initState();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    if (mahasiswaList== null) {
      mahasiswaList = [];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar List Mahasiswa'),
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
              child: Text("Tambah Mahasiswa"),
              onPressed: () async {
                var data = await navigateToEntryForm(context, null);
                if (data != null) {
                  int result = await dbHelper.insertMahasiswa(data);
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

  Future<Mahasiswa> navigateToEntryForm(BuildContext context, Mahasiswa mahasiswa) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
   return EntryForm(mahasiswa);
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
              this.mahasiswaList[index].nim.toString(),
              style: textStyle,
            ),
            subtitle: Text(this.mahasiswaList[index].nama),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () async {
                dbHelper.deleteMahasiswa(this.mahasiswaList[index].id);
                updateListView();
              },
            ),
            onTap: () async {
              var data =
                  await navigateToEntryForm(context, this.mahasiswaList[index]);
              if (data != null) {
                int result = await dbHelper.updateMahasiswa(data);
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
      Future<List<Mahasiswa>> mahasiswaListFuture = dbHelper.getMahasiswaList();
      mahasiswaListFuture.then((mahasiswaList) {
        setState(() {
          this.mahasiswaList = mahasiswaList;
          this.count = mahasiswaList.length;
        });
      });
    });
  }
}