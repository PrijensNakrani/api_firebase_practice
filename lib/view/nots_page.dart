import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final _title = TextEditingController();
  final _desc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("User")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("Notes")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> notes = snapshot.data!.docs;
            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, int index) {
                return ListTile(
                  title: Text(notes[index].get("title")),
                );
              },
            );
          } else {return SizedBox();}
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Column(
                  children: [
                    Text("Add Nots"),
                    TextFormField(
                      controller: _title,
                    ),
                    TextFormField(
                      controller: _desc,
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection("User")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection("Notes")
                          .add({"title": _title.text, "desc": _desc.text});
                      Navigator.pop(context);
                    },
                    child: Text("Add"),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
