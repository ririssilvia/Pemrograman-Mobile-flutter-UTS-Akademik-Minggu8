import 'package:flutter/material.dart';
import 'package:uts/Model/mahasiswa.dart';

class EntryForm extends StatefulWidget {
  final Mahasiswa mahasiswa;
  EntryForm(this.mahasiswa);
  @override
  EntryFormState createState() => EntryFormState(this.mahasiswa);
}

//class controller
class EntryFormState extends State<EntryForm> {
  Mahasiswa mahasiswa;
  EntryFormState(this.mahasiswa);
  TextEditingController nimController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController jenisKelaminController = TextEditingController();
  TextEditingController alamatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //kondisi
    if (mahasiswa != null) {
      nimController.text = mahasiswa.nim;
      namaController.text = mahasiswa.nama;
      jenisKelaminController.text = mahasiswa.jenisKelamin;
      alamatController.text = mahasiswa.alamat;
    }
    //rubah
    return Scaffold(
        appBar: AppBar(
          title: mahasiswa == null ? Text('Tambah') : Text('Ubah'),
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
              // NIM
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: nimController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'NIM',
                    icon: Icon(Icons.format_list_numbered_rtl),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              // nama
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: namaController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Nama Mahasiswa',
                    icon: Icon(Icons.portrait),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              // jenisKelamain
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: jenisKelaminController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Jenis Kelamin',
                    icon: Icon(Icons.nature),
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
                child: TextField(
                  controller: alamatController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Alamat',
                    icon: Icon(Icons.location_city),
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
                  children: <Widget>[
                    // tombol simpan
                    Expanded(
                      child: ElevatedButton(
                        child: Text(
                          'Save',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          if (mahasiswa == null) {
                            // tambah data
                            mahasiswa = Mahasiswa(
                                nimController.text,
                                namaController.text,
                                jenisKelaminController.text,
                                alamatController.text);
                          } else {
                            // ubah data
                            mahasiswa.nim = nimController.text;
                            mahasiswa.nama = namaController.text;
                            mahasiswa.jenisKelamin =
                            jenisKelaminController.text;
                            mahasiswa.alamat = alamatController.text;
                          }

                          // kembali ke layar sebelumnya dengan membawa objek item
                          Navigator.pop(context, mahasiswa);
                        },
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    // tombol batal
                    Expanded(
                      child: ElevatedButton(
                        child: Text(
                          'Cancel',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.purple,
                            textStyle: TextStyle(fontWeight: FontWeight.bold)),
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
