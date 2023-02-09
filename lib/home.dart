import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application/models/data_model.dart';
import 'package:flutter_application/services/remote_services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Model>? dataSource = [];

  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    dataSource = await RemoteService.getData();

    if (dataSource != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: 1600,
              child: isLoaded
                  ? ListView.builder(
                      itemCount: dataSource!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 200,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.network(
                                      dataSource![index].avatar.toString(),
                                      fit: BoxFit.cover),
                                  ClipRRect(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 10, sigmaY: 10),
                                      child: Container(
                                        color: Colors.grey.withOpacity(0.1),
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CircleAvatar(
                                              radius: 60,
                                              backgroundImage: NetworkImage(
                                                  dataSource![index]
                                                      .avatar
                                                      .toString()),
                                              // child: Image.network(
                                              //   dataSource![index].avatar.toString(),
                                              //   height: 100,
                                              //   width: 100,
                                              // ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                    "${dataSource![index].first_name} ${dataSource![index].last_name}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20)),
                                                Text(
                                                    dataSource![index]
                                                        .mail
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontSize: 12)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        );
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            )
          ],
        )));
  }
}
