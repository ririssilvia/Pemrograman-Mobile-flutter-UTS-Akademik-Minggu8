class MataKuliah {
  //membuat atribut untuk tabel matkul
  int _id;
  String _kodeMatkul;
  String _namaMatkul;
  int _sks;
 
 //getter akan mengambil nilai yang dimasukkan ke consturctor
 //setter ini akan dipakai untuk mengembalikan nilai yang dimasukkan dari constructor
    get id => this._id;


    get kodeMatkul => this._kodeMatkul;
    set kodeMatkul( value) => this._kodeMatkul = value;

    get namaMatkul => this._namaMatkul;
    set namaMatkul(String value) => this._namaMatkul = value;

    int get sks => this._sks;
    set sks(int value) => this._sks = value;


  // konstruktor versi 1
  MataKuliah(this._kodeMatkul, this._namaMatkul,  this._sks);

  // konstruktor versi 2: konversi dari Map ke Matkul
  MataKuliah.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._kodeMatkul = map['kodeMatkul'];
    this._namaMatkul= map['namaMatkul'];
    this._sks = map['sks'];
  }

  // konversi dari matkul ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['kodeMatkul'] = kodeMatkul;
    map['namaMatkul'] = namaMatkul;
    map['sks'] = sks;
    return map;
  }
}