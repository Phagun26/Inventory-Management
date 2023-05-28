import 'dart:convert';
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thispls/models/login_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class confirmm extends StatefulWidget {
  confirmm({Key? key}) : super(key: key);

  @override
  _CarListState createState() => _CarListState();
}

class _CarListState extends State<confirmm> {
  late Future<List<dynamic>> _futureCars;


  @override
  void initState() {
    super.initState();
    _futureCars = getCars();
  }
  List carlist = <dynamic>[];
  String value='';
  Future<List<dynamic>> getCars() async {

    var response = await http.get(Uri.parse("http://$localhost/dashboard/test/getitem.php"));

    setState(() {
      carlist=json.decode(response.body);
    });

    print(updated(carlist));
    print(value);
    return updated(carlist);
  }
  List<dynamic> updated(List<dynamic> a)
  {
    List<dynamic> aa = [];
    (value.length==0)?aa=a:aa = a.where((item) =>  item['itemname'].toString().toLowerCase().contains(value.toLowerCase()) || item['rack_no'].toString().toLowerCase().contains(value.toLowerCase())) .toList();
    return aa;

  }


  sendreq(String itemname,String rackno) async
  {
    var res = await http.post(
      Uri.parse("http://$localhost/dashboard/test/deleteitem.php"),
      body: {
        "itemname":itemname,
        "rackno":rackno,
      },
    );
    setState(() {
      _futureCars=getCars();
    });


  }

  confirmlist() async {
    String datee = DateFormat('dd-MM-yy').format(DateTime.now());

    var res = await http.post(
      Uri.parse("http://$localhost/dashboard/test/confirmlist.php"),
    );
    Fluttertoast.showToast(msg: 'Your Entries have been submitted');
    print(datee);
    var response = await http.post(Uri.parse("http://$localhost/dashboard/test/history.php"),
    body:{
        'date':datee,
        }

    );
    setState(() {
      _futureCars=getCars();
    });
  }




  List<dynamic> aa= [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Temporary List"),
      ),
      backgroundColor: Colors.grey[200],
      body:
      logged_name=='phagunn'
      ?Column(
        children: [
          SizedBox(height: 20,),
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
          SizedBox(height: 40,),
          FutureBuilder<List<dynamic>>(
            future: _futureCars,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                List<dynamic> confirmm = snapshot.data!;
                return
                  Expanded(
                    child: ListView.builder(
                      itemCount: confirmm.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          shape:BeveledRectangleBorder(side: BorderSide(width: 2,color: Colors.black),borderRadius: BorderRadius.circular(8)),

                          title: Text('Item:'+confirmm[index]['itemname'] + ' on Rack:' +confirmm[index]['rack_no'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          subtitle: Text(' Scanned By: '+confirmm[index]['scanner'] + ' Type:'+confirmm[index]['type'],style: TextStyle(fontSize: 12),),

                          trailing: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[400],
                                  foregroundColor: Colors.white
                              ),
                              onPressed: (){sendreq(confirmm[index]['itemname'].toString(),confirmm[index]['rack_no'].toString());ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Item Deleted')),);},
                              child: Text('Delete Item',style: TextStyle(color: Colors.black),)),
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
          Center(child: ElevatedButton(onPressed: confirmlist, child: Text('Submit List',style: TextStyle(
            fontSize: 20,
            fontFamily: 'Arial',
          ),),
              style: ElevatedButton.styleFrom(
            fixedSize: Size(150, 60),
          )),
          ),
          SizedBox(height: 20,),
        ],
      ):
          Container(
            child: Text("You are not authorised",style: TextStyle(
              fontSize: 50,
            ),),
          ),
    );
  }
}
