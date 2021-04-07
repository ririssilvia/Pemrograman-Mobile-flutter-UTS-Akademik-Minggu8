import 'package:flutter/material.dart';
import 'package:uts/Model/kelas.dart';

class EntryForm extends StatefulWidget{
  final Kelas kelas;

  EntryForm(this.kelas);

  @override
  EntryFormState createState() => EntryFormState(this.kelas);
}

//class controller
class EntryFormState extends State<EntryForm> {
  Kelas kelas;
  EntryFormState(this.kelas);
  TextEditingController kodeKelasController = TextEditingController();
  TextEditingController namaKelasController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //kondisi
    if (kelas != null) {
      kodeKelasController.text = kelas.kodeKelas;
      namaKelasController.text = kelas.namaKelas;
      keteranganController.text =kelas.keterangan;
    }
    //rubah
    return Scaffold(
        appBar: AppBar(
          title: kelas == null ? Text('Tambah') : Text('Ubah'),
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
                  controller: kodeKelasController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Kode Kelas',
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
                  controller: namaKelasController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Nama Kelas',
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
              // sks
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: keteranganController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Keterangan ',
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
                          if (kelas == null) {
                            // tambah data
                            kelas = Kelas(
                                kodeKelasController.text,
                                namaKelasController.text,
                                keteranganController.text
                                );
                          } else {
                            // ubah data
                            kelas.kodeKelas = kodeKelasController.text;
                            kelas.namaKelas = namaKelasController.text;
                            kelas.keterangan =  keteranganController.text;
                          }

                          // kembali ke layar sebelumnya dengan membawa objek kelas
                          Navigator.pop(context, kelas);
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
