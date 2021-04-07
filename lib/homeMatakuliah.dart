import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uts/DBHelper/dbhelper.dart';
import 'package:uts/Model/mataKuliah.dart';
import 'dart:async';
import 'matakuliahEntryForm.dart';

class HomeMatkul extends StatefulWidget {
  @override
  HomeMatkulState createState() => HomeMatkulState();
}

class HomeMatkulState extends State<HomeMatkul> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<MataKuliah> mataKulihList;

  @override
   //menampilkan data yang sudah diinputkan ketika pertama kali membuka aplikasi
  void initState() {
    super.initState();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    if (mataKulihList == null) {
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
      ]),
      //button add data matakuliah
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var data = await navigateToEntryForm(context, null);
          if (data != null) {
            int result = await dbHelper.insertMataKuliah(data);
            if (result > 0) {
              updateListView();
            }
          }
        },
        child: Icon(
          //membuat icon
          Icons.note_add,
          size: 50,
          color: Colors.black,
        ),
        backgroundColor: Colors.yellow[700],
      ),
    );
  }

  Future<MataKuliah> navigateToEntryForm(
      BuildContext context, MataKuliah mataKuliah) async {
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
          color: Colors.purple[100],
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.book),
            ),
            //menampilkan data yang telah di add di home 
            title: Text(
              this.mataKulihList[index].kodeMatkul.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nama Matakuliah : " + this.mataKulihList[index].namaMatkul,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  "Kelas : " + this.mataKulihList[index].kelas,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  "SKS : " + this.mataKulihList[index].sks.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),

            //button untuk edit data
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.rate_review),
                  onPressed: () async {
                    var data = await navigateToEntryForm(
                        context, this.mataKulihList[index]);
                    if (data != null) {
                      int result = await dbHelper.updateMataKuliah(data);
                      if (result > 0) {
                        updateListView();
                      }
                    }
                  },
                ),

                //button untuk hapus data
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    dbHelper.deleteMataKuliah(this.mataKulihList[index].id);
                    updateListView();
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

//update List
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      Future<List<MataKuliah>> mataKuliahListFuture =
          dbHelper.getMataKuliahList();
      mataKuliahListFuture.then((mataKuliahList) {
        setState(() {
          this.mataKulihList = mataKuliahList;
          this.count = mataKuliahList.length;
        });
      });
    });
  }
}
