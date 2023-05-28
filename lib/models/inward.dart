import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thispls/models/login_page.dart';
import 'package:barcode/barcode.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:toast/toast.dart';


class inward extends StatefulWidget {
  inward({Key? key}) : super(key: key);

  @override
  _inwardstate createState() => _inwardstate();
}

class _inwardstate extends State<inward> {
  late Future<List<dynamic>> _futureeq;

  @override
  void initState() {
    super.initState();
    _futureeq = getCars();
  }
  List reqlist = <dynamic>[];

  Future<List<dynamic>> getCars() async {

    var response = await http.post(Uri.parse("http://$localhost/dashboard/test/inward.php"),
        body:{
          "itemname":pname,
          "rack_no":rackno,
          "scanner":logged_name,

        });
    Fluttertoast.showToast(msg: 'The entries are added');
    // Toast.show("Added", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);


    setState(() {
      reqlist=json.decode(response.body);
    });

    return reqlist;
  }



  String? pname;
  String? rackno;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Inwards"),
      actions: [
        IconButton(onPressed: resetdata, icon: Icon(Icons.add))
      ],
      ),
      backgroundColor: Colors.grey[400],
      body: Center(
        child: Column(

          children: <Widget>[
            Text('Product Scan', style: TextStyle(
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
            fontFamily: 'Times New Roman',
            fontSize: 50),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 60,
            ),
            ElevatedButton(onPressed: scanprod, child: Text('Scan the product',style: TextStyle(
              fontSize: 25,
            ),),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(240, 80),
            )),
            Text('Product: $pname',style: TextStyle(
                fontWeight: FontWeight.w900,

                fontFamily: 'Open Sans',
                fontSize: 30),),
            SizedBox(height: 60),
            ElevatedButton(onPressed: scanrack, child: Text('Scan the rack_no',style: TextStyle(
            fontSize: 25,
            ),),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(240, 80),
                )),
            Text('Product: $rackno',style: TextStyle(
                fontWeight: FontWeight.w900,

                fontFamily: 'Open Sans',
                fontSize: 30),),
            SizedBox(height:100),
            ElevatedButton(onPressed: (pname!=null && rackno!=null) ? getCars : ()=>Fluttertoast.showToast(msg: 'The Fields are empty') , child: Text('Submit',style: TextStyle(
              fontSize: 35,
            ),),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(200, 80),
                )),
            // ElevatedButton(onPressed: resetdata, child: Text('New Entry')),

            ],

        ),
      )
    );
  }
  // void showtoast()
  // {
  //   Toast.show("Fields Not completed", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
  //
  // }
  Future scanprod() async
  {
String pname;
pname= await FlutterBarcodeScanner.scanBarcode(
  "#ff6666",
  "Cancel",
  true,
  ScanMode.BARCODE,
);

setState(() {
  this.pname=pname.startsWith("]C1") ? pname.substring(2) : pname;
});

  }
  Future scanrack() async
  {
    String rackno;
    rackno= await FlutterBarcodeScanner.scanBarcode(
      "#ff6666",
      "Cancel",
      true,
      ScanMode.DEFAULT,
    );
    print(rackno);

    setState(() {
      this.rackno = rackno.startsWith("]C1") ? rackno.substring(2) : rackno;
    });

  }
  resetdata()
  {
    Fluttertoast.showToast(msg: 'Now you can add new entries');
    setState(() {
      this.rackno=null;
      this.pname=null;
    });
  }
}
