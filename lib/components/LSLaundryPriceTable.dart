import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LSLaundryPriceTable extends StatefulWidget {
  const LSLaundryPriceTable({super.key});

  @override
  State<LSLaundryPriceTable> createState() => _LSLaundryPriceTableState();
}

class _LSLaundryPriceTableState extends State<LSLaundryPriceTable> {
  Future<List<dynamic>> getPriceList() async {
    final response = await http.get(Uri.parse(
        'http://192.168.1.12/urban_laundry/user/api/laundry_pricelist.php'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          FutureBuilder<List<dynamic>>(
            future: getPriceList(),
            builder:
                (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    debugPrint('Print testt...');

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Table(
                            defaultColumnWidth: FixedColumnWidth(110.0),
                            border: TableBorder.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 2),
                            children: [
                              TableRow(children: [
                                Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Topwear',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold)),
                                  )
                                ]),
                                Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('BottomWear',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold)),
                                  )
                                ]),
                                Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Woolen',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold)),
                                  )
                                ]),
                              ]),
                              TableRow(children: [
                                Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.currency_rupee),
                                        Text(
                                          data[index]['TopWear'],
                                          style: TextStyle(fontSize: 25),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                                Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.currency_rupee),
                                        Text(
                                          data[index]['BottomWear'],
                                          style: TextStyle(fontSize: 25),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                                Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.currency_rupee),
                                        Text(
                                          data[index]['Woolen'],
                                          style: TextStyle(fontSize: 25),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                              ]),
                            ],
                          ),
                        ),

                        // Row(
                        //   children: [
                        //     Text("Top Wear : "),
                        //     Text(data[index]['TopWear']),
                        //   ],
                        // ),
                        // SizedBox(
                        //   width: 5.0,
                        // ),
                        // Row(
                        //   children: [
                        //     Text("Top Wear : "),
                        //     Text(data[index]['BottomWear']),
                        //   ],
                        // ),
                        // SizedBox(
                        //   width: 5.0,
                        // ),
                        // Row(
                        //   children: [
                        //     Text("Top Wear : "),
                        //     Text(data[index]['Woolen']),
                        //   ],
                        // ),
                      ],
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
