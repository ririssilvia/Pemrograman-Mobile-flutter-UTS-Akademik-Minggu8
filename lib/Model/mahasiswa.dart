class Mahasiswa {
  int _id;
  String _nim;
  String _nama;
  String _ambilMatkul;
  String _jenisKelamin;
  String  _alamat;



  get id => this._id;

  get nim => this._nim;
  set nim(String value) => this._nim = value;

  get nama => this._nama;
  set nama( value) => this._nama = value;

  String get ambilMatkul => this._ambilMatkul;
  set ambilMatkul(String value) => this._ambilMatkul = value;

  get jenisKelamin => this._jenisKelamin;
  set jenisKelamin( value) => this._jenisKelamin = value;

  get alamat => this._alamat;
  set alamat( value) => this._alamat = value;


  // konstruktor versi 1
  Mahasiswa(this._nim, this._nama,this._ambilMatkul, this._jenisKelamin, this._alamat);

  // konstruktor versi 2: konversi dari Map ke Mapel
  Mahasiswa.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nim= map['nim'];
    this._nama= map['nama'];
    this._ambilMatkul= map['ambilMatkul'];
    this._jenisKelamin = map['jenisKelamin'];
    this._alamat = map['alamat'];
  }

  // konversi dari Mapel ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['nim'] = nim;
    map['nama'] = nama;
    map['ambilMatkul'] = ambilMatkul;
    map['jenisKelamin'] = jenisKelamin;
    map['alamat'] = alamat;
    return map;
  }
}