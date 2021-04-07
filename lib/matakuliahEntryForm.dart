import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uts/DBHelper/dbhelper.dart';
import 'package:uts/Model/kelas.dart';
import 'package:uts/Model/mataKuliah.dart';

class EntryForm extends StatefulWidget {
  final MataKuliah mataKuliah;
  EntryForm(this.mataKuliah);
  @override
  EntryFormState createState() => EntryFormState(this.mataKuliah);
}

//class controller
class EntryFormState extends State<EntryForm> {
  MataKuliah mataKuliah;
  Kelas kelas;
  DbHelper dbHelper = DbHelper();
  EntryFormState(this.mataKuliah);
  TextEditingController kodeMatakulController = TextEditingController();
  TextEditingController namaMatkulController = TextEditingController();
  TextEditingController sksController = TextEditingController();

  List<Kelas> kelasList = List<Kelas>();
  List<String> listKelas = List<String>();

  int indexList = 0;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateListView();
  }

  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      //TODO 1 Select data dari DB
      Future<List<Kelas>> kelasListFuture = dbHelper.getKelasList();
     kelasListFuture.then((kelasList) {
        setState(() {
          for (int i = 0; i < kelasList.length; i++) {
            listKelas.add(kelasList[i].namaKelas);
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //kondisi
    if (mataKuliah != null) {
      kodeMatakulController.text = mataKuliah.kodeMatkul;
      namaMatkulController.text = mataKuliah.namaMatkul;
      sksController.text = mataKuliah.sks.toString();
    }
    //rubah
    return Scaffold(
        appBar: AppBar(
          title: mataKuliah == null ? Text('Tambah') : Text('Ubah'),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              // kode matkul
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: kodeMatakulController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Kode MataKuliah',
                    icon: Icon(Icons.qr_code),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              // nama Matakuliah
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: namaMatkulController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Nama MataKulaih',
                    icon: Icon(Icons.book),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Pilih Kelas',
                   icon: Icon(Icons.arrow_drop_down_circle),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                value: listKelas[indexList],
                items: listKelas.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String value) {
                  int i = listKelas.indexOf(value);
                  setState(() {
                    indexList = i;
                  });
                },
              ),
            ),
              // sks
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: sksController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Jumlah SKS',
                    icon: Icon(Icons.input),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              // tombol button
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                     Container(
                      child: FloatingActionButton.extended(
                        //button with an optional icon and label
                         onPressed: () {
                          if (mataKuliah == null) {
                            // tambah data
                            mataKuliah = MataKuliah(
                                kodeMatakulController.text,
                                namaMatkulController.text,
                                listKelas[indexList].toString(),
                                int.parse(sksController.text));
                          } else {
                            // ubah data
                            mataKuliah.kodeMatkul = kodeMatakulController.text;
                            mataKuliah.namaMatkul = namaMatkulController.text;
                            mataKuliah.kelas = listKelas[indexList].toString();
                            mataKuliah.sks = int.parse(sksController.text);
                          }

                          // kembali ke layar sebelumnya dengan membawa objek item
                          Navigator.pop(context, mataKuliah);
                        },
                        backgroundColor: Colors.purple,
                        icon: Icon(Icons.archive_outlined),
                        label: Text('Save',
                         style: TextStyle(fontWeight: FontWeight.bold),
                         ),
                      ),
                    ),
                    Container(
                      width: 30,
                    ),
            
                    // tombol batal
                    Container(
                      child: FloatingActionButton.extended(
                        //button with an optional icon and label
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        backgroundColor: Colors.red,
                        icon: Icon(Icons.cancel_schedule_send),
                        label: Text('Cancel',
                         style: TextStyle(fontWeight: FontWeight.bold),
                         ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
