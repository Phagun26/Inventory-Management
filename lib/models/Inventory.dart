import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thispls/models/login_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'package:share_plus/share_plus.dart';


class inventory extends StatefulWidget {
  inventory({Key? key}) : super(key: key);

  @override
  _CarListState createState() => _CarListState();
}

class _CarListState extends State<inventory> {
  late Future<List<dynamic>> _futureCars;


  @override
  void initState() {
    super.initState();
    _futureCars = getCars();
  }
  List carlist = <dynamic>[];
  String value='';
  Future<List<dynamic>> getCars() async {

    var response = await http.get(Uri.parse("http://$localhost/dashboard/test/getitem1.php"));

    setState(() {
      carlist=json.decode(response.body);
    });

    // print(updated(carlist));
    // print(value);
    carlist=updated(carlist);
    return carlist;
  }
  List<dynamic> updated(List<dynamic> a)
  {
    List<dynamic> aa = [];
    (value.length==0)?aa=a:aa = a.where((item) =>  item['itemname'].toString().toLowerCase().contains(value.toLowerCase()) || item['rack_no'].toString().toLowerCase().contains(value.toLowerCase())) .toList();
    return aa;

  }


  // sendreq(String itemname,String rackno) async
  // {
  //   var res = await http.post(
  //     Uri.parse("http://$localhost/dashboard/test/deleteitem.php"),
  //     body: {
  //       "itemname":itemname,
  //       "rackno":rackno,
  //     },
  //   );
  //
  //
  // }
  //
  // confirmlist() async {
  //   var res = await http.post(
  //     Uri.parse("http://$localhost/dashboard/test/confirmlist.php"),
  //   );
  // }

  Future<void> exportcsv() async{
    List<List<dynamic>> rows = [];
    for(dynamic item in carlist)
      {
        List<dynamic> row = [];
        row.add(item['itemname']);
        row.add(item['quantity']);
        row.add(item['rack_no']);
        rows.add(row);
      }
    String csvString = const ListToCsvConverter().convert(rows);
    Directory? downloadsDirectory = await getExternalStorageDirectory();
    print(carlist);
    print(downloadsDirectory);
    String filePath = '/storage/emulated/0/Documents/data.csv';

    File excelFile = File(filePath);
    await excelFile.writeAsString(csvString);
    Share.shareFiles([filePath], text: 'Sharing the exported file');


  }
  List<dynamic> aa= [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Inventory',textAlign: TextAlign.center,),
        actions: [
          IconButton(onPressed: exportcsv, icon: Icon(Icons.add)),
        ],
      ),
      backgroundColor: Colors.grey[200],
      body:
      Column(
        children: [
          SizedBox(height:20),
          TextField(
            onChanged: (value){this.value=value;
            setState(() {
              _futureCars=getCars();
            });


            },

            decoration: InputDecoration(
              fillColor: Colors.blue,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 3,color: Colors.blue,
                ),
              ),

              labelText: 'Search',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          SizedBox(height:40),
          FutureBuilder<List<dynamic>>(
            future: _futureCars,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                List<dynamic> inventory = snapshot.data!;
                return
                  Expanded(
                    child: ListView.builder(
                      itemCount: inventory.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          shape:BeveledRectangleBorder(side: BorderSide(width: 2,color: Colors.black),borderRadius: BorderRadius.circular(8)),

                          title: Text('Item:'+inventory[index]['itemname'] + ' on Rack:' +inventory[index]['rack_no'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          trailing: Text('Quantity: '+inventory[index]['quantity'],style: TextStyle(
                              fontSize: 18,fontWeight: FontWeight.bold,
                          ),),


                          // trailing: ElevatedButton(
                          //     style: ElevatedButton.styleFrom(
                          //         backgroundColor: Colors.grey[400],
                          //         foregroundColor: Colors.white
                          //     ),
                          //     onPressed: (){sendreq(inventory[index]['itemname'].toString(),inventory[index]['rack_no'].toString());ScaffoldMessenger.of(context).showSnackBar(
                          //       SnackBar(content: Text('Item Deleted')),);},
                          //     child: Text('Delete Item',style: TextStyle(color: Colors.black),)),
                        );

                      },
                    ),
                  );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error fetching car list'),
                );
              } else {
                return Center(
                  child: Text('No data'),
                );
              }
            },
          ),
          // Center(child: ElevatedButton(onPressed: confirmlist, child: Text('Submit List')))
        ],
      ),
    );
  }
}
