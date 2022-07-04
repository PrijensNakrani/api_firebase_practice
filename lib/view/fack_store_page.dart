import 'package:api_firebase_practice/api_service/api_service.dart';
import 'package:flutter/material.dart';

import '../model/fake_store_model.dart';

class FakeStorePage extends StatefulWidget {
  const FakeStorePage({Key? key}) : super(key: key);

  @override
  State<FakeStorePage> createState() => _FakeStorePageState();
}

class _FakeStorePageState extends State<FakeStorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ApiService.getData(),
        builder:
            (BuildContext context, AsyncSnapshot<List<FackModel>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final fake = snapshot.data![index];
                return ListTile(title: Text("${fake.title}"));
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
