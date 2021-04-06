import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uts/DBHelper/dbhelper.dart';
import 'package:uts/Model/kelas.dart';

import 'kelasEntryForm.dart';

class HomeKelas extends StatefulWidget {
  @override
  HomeKelasState createState() => HomeKelasState();
}

class HomeKelasState extends State<HomeKelas> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Kelas> kelasList;

  @override
  void initState() {
    super.initState();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    if (kelasList == null) {
      kelasList = [];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar List Kelas '),
      ),
      body: Column(children: [
        Expanded(
          child: createListView(),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var data = await navigateToEntryForm(context, null);
          if (data != null) {
            int result = await dbHelper.insertKelas(data);
            if (result > 0) {
              updateListView();
            }
          }
        },
        child: Icon(
          //membuat icon
          Icons.add,
          size: 50,
          color: Colors.black,
        ),
        backgroundColor: Colors.yellow[700],
      ),
    );
  }

  Future<Kelas> navigateToEntryForm(
      BuildContext context, Kelas kelas) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(kelas);
    }));
    return result;
  }

  ListView createListView() {
    // ignore: unused_local_variable
    TextStyle textStyle = Theme.of(context).textTheme.headline6;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.purple[100],
          child: ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.people),
            ),
            title: Text(
              this.kelasList[index].kodeKelas,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nama Kelas: " +  this.kelasList[index].namaKelas,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  "Keterangan: " +  this.kelasList[index].keterangan,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                
              ],
            ),

            // widget yang akan menampilkan setelah title
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.rate_review),
                  onPressed: () async {
                    var data = await navigateToEntryForm(
                        context, this.kelasList[index]);
                    if (data != null) {
                      int result = await dbHelper.updateKelas(data);
                      if (result > 0) {
                        updateListView();
                      }
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    dbHelper.deleteMahasiswa(this.kelasList[index].id);
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
      Future<List<Kelas>> kelasListFuture = dbHelper.getKelasList();
      kelasListFuture.then((kelasList) {
        setState(() {
          this.kelasList = kelasList;
          this.count = kelasList.length;
        });
      });
    });
  }
}
