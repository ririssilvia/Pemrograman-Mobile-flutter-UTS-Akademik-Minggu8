class MataKuliah {
  int _id;
  String _kodeMatkul;
  String _namaMatkul;
  String _kelas;
  int _sks;
 
    get id => this._id;

    String get kelas => this._kelas;
    set kelas(String value) => this._kelas = value;

    get kodeMatkul => this._kodeMatkul;
    set kodeMatkul( value) => this._kodeMatkul = value;

    String get namaMatkul => this._namaMatkul;
    set namaMatkul(String value) => this._namaMatkul = value;

    int get sks => this._sks;
    set sks(int value) => this._sks = value;


  // konstruktor versi 1
  MataKuliah(this._kodeMatkul, this._namaMatkul, this._kelas, this._sks);

  // konstruktor versi 2: konversi dari Map ke Mapel
  MataKuliah.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._kodeMatkul = map['kodeMatkul'];
    this._namaMatkul= map['namaMatkul'];
    this._kelas= map['kelas'];
    this._sks = map['sks'];
  }

  // konversi dari Mapel ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['kodeMatkul'] = kodeMatkul;
    map['namaMatkul'] = namaMatkul;
    map['kelas'] = kelas;
    map['sks'] = sks;
    return map;
  }
}