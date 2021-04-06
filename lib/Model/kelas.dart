class Kelas {
  int _id;
  String _kodeKelas;
  String _namaKelas;
  String _keterangan;

  
  get id => this._id;

   String get kodeKelas => this._kodeKelas;
   set kodeKelas(String value) => this._kodeKelas = value;

   String get namaKelas => this._namaKelas;
   set namaKelas(String value) => this._namaKelas = value;

  String get keterangan => this._keterangan;
  set keterangan(String value) => this._keterangan = value;

  

  // konstruktor versi 1
  Kelas(this._kodeKelas, this._namaKelas, this._keterangan);

  // konstruktor versi 2: konversi dari Map ke Mapel
  Kelas.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._kodeKelas= map['kodeKleas'];
    this._namaKelas= map['namaKelas'];
    this._keterangan = map['keterangan'];
  }

  // konversi dari Mapel ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['kodeKelas'] = kodeKelas;
    map['namaKelas'] = namaKelas;
    map['keterangan'] = keterangan;
    return map;
  }
}