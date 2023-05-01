import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LSDrycleanRequestComponents extends StatefulWidget {
  const LSDrycleanRequestComponents({super.key});

  @override
  State<LSDrycleanRequestComponents> createState() =>
      _LSDrycleanRequestComponentsState();
}

class _LSDrycleanRequestComponentsState
    extends State<LSDrycleanRequestComponents> {
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

                    return Column(
                      children: [
                        Text(data[index]['TopWear']),
                        Text(data[index]['BottomWear']),
                        Text(data[index]['Woolen']),
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
