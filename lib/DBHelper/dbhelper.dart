import 'package:sqflite/sqflite.dart';
//mendukug pemrograman asinkron
import 'dart:async';
import 'dart:io';
//bekerja pada file dan directory
import 'package:path_provider/path_provider.dart';
import 'package:uts/Model/kelas.dart';
import 'package:uts/Model/mahasiswa.dart';
import 'package:uts/Model/mataKuliah.dart';


//kelass Dbhelper
class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;
  DbHelper._createObject();


  Future<Database> initDb() async {
    //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'akademik.db';
    //create, read databases
    var akademikDatabase = openDatabase(path,
        version: 1, 
        onCreate: _createDb, 
        onUpgrade: _onUpgrade
        );
    //mengembalikan nilai object sebagai hasil dari fungsinya
    return akademikDatabase;
  }

   //mengupgrade database
  void _onUpgrade(Database db, int oldVersion, int newVersion){
    _createDb(db, newVersion);
  }

  //untuk membuat tabel baru dengan nama mahasiswa dan matakuliah
  void _createDb(Database db, int version) async {
    var batch = db.batch();
    //tabel mahasiswa
   batch.execute('''
              CREATE TABLE mahasiswa (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              nim TEXT,
              nama TEXT,
              jenisKelamin TEXT,
              alamat TEXT
              )
              ''');
    // tabel Matakuliah
    batch.execute('''
              CREATE TABLE mataKuliah (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              kodeMatkul TEXT,
              namaMatkul TEXT,
              sks INTEGER
            )
              ''');
    //Tabel Kelas
    batch.execute('''
              CREATE TABLE kelas (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              kodeKelas TEXT,
              namaKelas TEXT,
              keterangan TEXT
            )
              ''');

    await batch.commit();


  }


  //select databases mahasiswa
  Future<List<Map<String, dynamic>>> selectMahasiswa() async {
    Database db = await this.initDb();
    var mapList = await db.query('mahasiswa', orderBy: 'nim');
    return mapList;
  }

  //select databases matakuliah
  Future<List<Map<String, dynamic>>> selectMataKuliah() async {
    Database db = await this.initDb();
    var mapList = await db.query('mataKuliah', orderBy: 'kodeMatkul');
    return mapList;
  }

  //select databases kelas
  Future<List<Map<String, dynamic>>> selectKelas() async {
    Database db = await this.initDb();
    var mapList = await db.query('kelas', orderBy: 'kodeKelas');
    return mapList;
  }

  //insert data pada tabel Mahasiswa
  Future<int> insertMahasiswa(Mahasiswa object) async {
    Database db = await this.initDb();
    int count = await db.insert('mahasiswa', object.toMap());
    return count;
  }

  //insert data pada tabel Matakuliah
  Future<int> insertMataKuliah(MataKuliah object) async {
    Database db = await this.initDb();
    int count = await db.insert('mataKuliah', object.toMap());
    return count;
  }

  //insert data pada tabel Kelas
  Future<int> insertKelas(Kelas object) async {
    Database db = await this.initDb();
    int count = await db.insert('kelas', object.toMap());
    return count;
  }

  //update data pada tabel Mahasiswa
  Future<int> updateMahasiswa(Mahasiswa object) async {
    Database db = await this.initDb();
    int count = await db
        .update('mahasiswa', object.toMap(), where: 'id=?', whereArgs: [object.id]);
    return count;
  }

   //update data pada tabel MataKuliah
  Future<int> updateMataKuliah(MataKuliah object) async {
    Database db = await this.initDb();
    int count = await db
        .update('mataKuliah', object.toMap(), where: 'id=?', whereArgs: [object.id]);
    return count;
  }

    //update data pada tabel kelas
  Future<int> updateKelas(Kelas object) async {
    Database db = await this.initDb();
    int count = await db
        .update('kelas', object.toMap(), where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  //delete data pada tabel Mahasiswa
  Future<int> deleteMahasiswa(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('mahasiswa', where: 'id=?', whereArgs: [id]);
    return count;
  }

  //delete data pada tabel MataKuliah
   Future<int> deleteMataKuliah(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('mataKuliah', where: 'id=?', whereArgs: [id]);
    return count;
  }

  //delete data pada tabel Kelas
   Future<int> deleteKelas(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('kelas', where: 'id=?', whereArgs: [id]);
    return count;
  }
 
 // list data dalam tabel Mahasiswa
  Future<List<Mahasiswa>> getMahasiswaList() async {
    var itemMapList = await selectMahasiswa();
    int count = itemMapList.length;
    List<Mahasiswa> itemList = List<Mahasiswa>();
    for (int i = 0; i < count; i++) {
      itemList.add(Mahasiswa.fromMap(itemMapList[i]));
    }
    return itemList;
  }

  // list data dalam tabel MataKuliah
   Future<List<MataKuliah>> getMataKuliahList() async {
    var itemMapList = await selectMataKuliah();
    int count = itemMapList.length;
    List<MataKuliah> itemList = List<MataKuliah>();
    for (int i = 0; i < count; i++) {
      itemList.add(MataKuliah.fromMap(itemMapList[i]));
    }
    return itemList;
  }

    // list data dalam tabel Kelas
   Future<List<Kelas>> getKelasList() async {
    var itemMapList = await selectKelas();
    int count = itemMapList.length;
    List<Kelas> itemList = List<Kelas>();
    for (int i = 0; i < count; i++) {
      itemList.add(Kelas.fromMap(itemMapList[i]));
    }
    return itemList;
  }

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper;
  }


  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }
}
