//pendukung program asinkron
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uts/DBHelper/dbhelper.dart';
import 'package:uts/Form/mahasiswaEntryForm.dart';
import 'package:uts/Model/mahasiswa.dart';
import 'dart:async';


class HomeMhs extends StatefulWidget {
  @override
  HomeMhsState createState() => HomeMhsState();
}

class HomeMhsState extends State<HomeMhs> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Mahasiswa> mahasiswaList;

  @override
   //menampilkan data yang sudah diinputkan ketika pertama kali membuka aplikasi
  void initState() {
    super.initState();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    if (mahasiswaList == null) {
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
      ]),
      //add data mahasiswa
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var data = await navigateToEntryForm(context, null);
          if (data != null) {
            int result = await dbHelper.insertMahasiswa(data);
            if (result > 0) {
              updateListView();
            }
          }
        },
        child: Icon(
          //membuat icon
          Icons.person_add_outlined,
          size: 50,
          color: Colors.black,
        ),
        backgroundColor: Colors.yellow[700],
      ),
    );
  }

  Future<Mahasiswa> navigateToEntryForm(
      BuildContext context, Mahasiswa mahasiswa) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(mahasiswa);
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
            //menampilkan data yang di add di home 
            title: Text(
              this.mahasiswaList[index].nim.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nama : " + this.mahasiswaList[index].nama,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  "Ambil MataKuliah : " + this.mahasiswaList[index].ambilMatkul,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  "Jenis Kelamin : " + this.mahasiswaList[index].jenisKelamin,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  "Alamat : " + this.mahasiswaList[index].alamat,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),

            //button eidt data
            // widget yang akan menampilkan setelah title
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.rate_review),
                  onPressed: () async {
                    var data = await navigateToEntryForm(
                        context, this.mahasiswaList[index]);
                    if (data != null) {
                      int result = await dbHelper.updateMahasiswa(data);
                      if (result > 0) {
                        updateListView();
                      }
                    }
                  },
                ),
                //button hapus data
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    dbHelper.deleteMahasiswa(this.mahasiswaList[index].id);
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
