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
import 'package:intl/intl.dart';



class history extends StatefulWidget {
  history({Key? key}) : super(key: key);

  @override
  _CarListState createState() => _CarListState();
}

class _CarListState extends State<history> {
  late Future<List<dynamic>> _futureCars;

  List carlist = <dynamic>[];
  String value='';
  DateTime noww = DateTime.now();
  DateTime selectedStartDate=DateTime.now();

  DateTime selectedEndDate=DateTime.now();
  @override
  void initState() {
    super.initState();
    initializedates();
    _futureCars = getCars();
  }


  // @override
  // void setState(VoidCallback fn) {
  //   initializedates();
  //   //
  //   super.setState(fn);
  // }

  void initializedates()
  {
    selectedStartDate=DateTime(noww.year, noww.month, noww.day,0,0,0);
    selectedEndDate=DateTime(noww.year, noww.month, noww.day,0,0,0);

  }

  Future<List<dynamic>> getCars() async {

    var response = await http.get(Uri.parse("http://$localhost/dashboard/test/gethistory.php"));

    setState(() {
      carlist=json.decode(response.body);
      carlist=updated(carlist);
    });

    // print(updated(carlist));
    // print(value);

    // filterCarsByDateRange();
    if(selectedStartDate==selectedEndDate)
    {
      filterCarsByDateRangesingle();
    }
    else
    {
      filterCarsByDateRange();
    }

    return carlist;
  }
  List<dynamic> updated(List<dynamic> a)
  {
    List<dynamic> aa = [];
    (value.length==0)?aa=a:aa = a.where((item) =>  item['itemname'].toString().toLowerCase().contains(value.toLowerCase()) || item['rack_no'].toString().toLowerCase().contains(value.toLowerCase())|| item['scanner'].toString().toLowerCase().contains(value.toLowerCase())) .toList();




    return aa;

  }
  void updateCars() {
    setState(() {
      _futureCars = getCars();
    });
  }
  // void updatedate()
  // {
  //
  //   List<dynamic>  aa = carlist.where((item) {
  //     DateTime itemDate = DateTime.parse(item['date']);
  //
  //    // Assuming the date is stored in the 'date' field
  //     return itemDate.isAfter(selectedStartDate) && itemDate.isBefore(selectedEndDate);
  //   }).toList();
  //   setState(() {
  //     carlist=updated(carlist);
  //   });
  //
  // }

  void filterCarsByDateRange() {
    carlist = carlist.where((item) {
      DateTime itemDate = DateTime.parse(item['date']);
      return itemDate.isAfter(selectedStartDate.subtract(Duration(days: 1))) &&
          itemDate.isBefore(selectedEndDate.add(Duration(days: 1)));
    }).toList();
  }

  void filterCarsByDateRangesingle() {
    carlist = carlist.where((item) {
      DateTime itemDate = DateTime.parse(item['date']);
      return itemDate.year == selectedStartDate.year &&
          itemDate.month == selectedStartDate.month &&
          itemDate.day == selectedStartDate.day;
    }).toList();
  }


  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
     DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? selectedStartDate : selectedEndDate ?? DateTime.now(),
      firstDate: DateTime(2023, 1, 1), // Replace with your desired range
      lastDate: DateTime(2040, 12, 31), // Replace with your desired range
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          selectedStartDate = picked;
        } else {
          selectedEndDate = picked;
        }
      });
    }
    if(selectedStartDate==selectedEndDate)
      {
        filterCarsByDateRangesingle();
      }
    else
      {
        filterCarsByDateRange();
      }

     updateCars();

    print(selectedEndDate);
    print(selectedStartDate);
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
      rows.add(['Item Name', 'Quantity', 'Rack Number','Scanned By','Type','Date']);
      List<dynamic> row = [];
      row.add(item['itemname']);
      row.add(item['quantity']);
      row.add(item['rack_no']);
      row.add(item['scanner']);
      row.add(item['type']);
      row.add(item['date']);

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
        title: Text('history',textAlign: TextAlign.center,),
        actions: [
          IconButton(
            icon: Icon(Icons.date_range),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Select Dates'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          child: Text(selectedStartDate != null ? DateFormat('yyyy-MM-dd').format(selectedStartDate) : 'Select Start Date'),
                          onPressed: () => _selectDate(context, true),
                        ),
                        TextButton(
                          child: Text(selectedEndDate != null ? DateFormat('yyyy-MM-dd').format(selectedEndDate) : 'Select End Date'),
                          onPressed: () => _selectDate(context, false),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      TextButton(
                        child: Text('Apply'),
                        onPressed: () {
                          filterCarsByDateRange();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
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
                List<dynamic> history = snapshot.data!;
                return
                  Expanded(
                    child: ListView.builder(
                      itemCount: history.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          shape:BeveledRectangleBorder(side: BorderSide(width: 2,color: Colors.black),borderRadius: BorderRadius.circular(8)),

                          title: Text('Item:'+history[index]['itemname'] + ' on Rack:' +history[index]['rack_no'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          subtitle: Text('Scanner: '+history[index]['scanner'] +' Type: '+history[index]['type']+' On: '+history[index]['date'],style: TextStyle(
                            fontSize: 15,
                          ), ),
                          trailing: Text('Quantity: '+history[index]['quantity'],style: TextStyle(
                            fontSize: 18,fontWeight: FontWeight.bold,
                          ),),


                          // trailing: ElevatedButton(
                          //     style: ElevatedButton.styleFrom(
                          //         backgroundColor: Colors.grey[400],
                          //         foregroundColor: Colors.white
                          //     ),
                          //     onPressed: (){sendreq(history[index]['itemname'].toString(),history[index]['rack_no'].toString());ScaffoldMessenger.of(context).showSnackBar(
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
