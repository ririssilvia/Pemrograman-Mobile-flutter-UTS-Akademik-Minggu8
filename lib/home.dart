import 'package:flutter/material.dart';
import 'package:uts/homeMahasiswa.dart';
import 'package:uts/homeMatakuliah.dart';

class Home extends StatelessWidget {
  // This widget is the root of your application.
  const Home({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Akademik'),
        leading: // membuat icon dengan menu leading
            new Icon(
          Icons.home,
          size: 30.0,
          color: Colors.white,
        ),
      ),
      body: Container(
        
        margin: EdgeInsets.only(left: 15, top: 15, right: 15),
        height: 600,
        decoration: BoxDecoration(
          color: Colors.purple[200],
          borderRadius: BorderRadius.circular(20), //membuat border radius
          boxShadow: [
            BoxShadow(
              //membuat shadow
              color: Colors.grey,
              spreadRadius: 5,
              blurRadius: 5,
            )
          ],
        ),
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Container(
            child: Image.network(
                'https://merdekabelajar.unm.ac.id/assets/img/ir.png'),
          ),
          
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 20),
                    child: RaisedButton(
                      color: Colors.yellow,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeMhs(),
                            ));
                      },
                      padding: EdgeInsets.only(
                          left: 25, top: 15, right: 25, bottom: 40),
                      child: Column(
                        //untuk menempatkan icon dan teks di setiap raised button secara vertikal
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.purple[200],
                              borderRadius: BorderRadius.circular(
                                  100), //membuat border radius
                              boxShadow: [
                                BoxShadow(
                                  //membuat shadow
                                  color: Colors.grey,
                                  spreadRadius: 5,
                                  blurRadius: 5,
                                )
                              ],
                            ),
                            child: Icon(
                              //membuat icon
                              Icons.people_outline_rounded,
                              size: 50,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              "Mahasiswa",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 20, right: 20),
                    child: RaisedButton(
                      color: Colors.yellow,
                       onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeMatkul(),
                            ));
                      },
                      padding: EdgeInsets.only(
                          left: 30, top: 15, right: 30, bottom: 40),
                      child: Column(
                        //untuk menempatkan icon dan teks di setiap raised button secara vertikal
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.purple[200],
                              borderRadius: BorderRadius.circular(
                                  100), //membuat border radius
                              boxShadow: [
                                BoxShadow(
                                  //membuat shadow
                                  color: Colors.grey,
                                  spreadRadius: 5,
                                  blurRadius: 5,
                                )
                              ],
                            ),
                            child: Icon(
                              //membuat icon
                              Icons.library_books,
                              size: 50,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              "MataKuliah",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 20),
                    child: RaisedButton(
                      color: Colors.yellow,
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => HomeMhs(),
                        //     ),
                        //     );
                      },
                      padding: EdgeInsets.only(
                          left: 25, top: 15, right: 25, bottom: 40),
                      child: Column(
                        //untuk menempatkan icon dan teks di setiap raised button secara vertikal
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.purple[200],
                              borderRadius: BorderRadius.circular(
                                  100), //membuat border radius
                              boxShadow: [
                                BoxShadow(
                                  //membuat shadow
                                  color: Colors.grey,
                                  spreadRadius: 5,
                                  blurRadius: 5,
                                )
                              ],
                            ),
                            child: Icon(
                              //membuat icon
                              Icons.person,
                              size: 60,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              "Dosen",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],

              ),
            ),
            
            
          ],
        ),
      ),
      
    );
  }
}
