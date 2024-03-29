import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:readnote/components/text_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final currentUser = FirebaseAuth.instance.currentUser!;
  final usersCollection = FirebaseFirestore.instance.collection("Users");

  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog( 
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          "Edit $field",
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration( 
            hintText: "Enter new $field",
            hintStyle: const TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          TextButton( 
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.of(context).pop(newValue),
            ),

            TextButton( 
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.of(context).pop(newValue),
            ),
        ]
      ),
    );

    //update firestore
    if(newValue.trim().isNotEmpty) {
      await usersCollection.doc(currentUser.email).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text(
          "Profile Page",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream : FirebaseFirestore.instance.collection("Users").doc(currentUser.email).snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              final userData = snapshot.data!.data() as Map<String, dynamic>;
              return ListView(
                children: [ 
                  const SizedBox(height: 50),

                  //profile pic
                  const Icon(
                    Icons.person,
                    size:72,
                  ),

                  const SizedBox(height: 10),

                  //user email
                  Center(
                    child: Text (
                      currentUser.email!,
                      //textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),

                  const SizedBox(height: 50),

                  //user details
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child : Text(
                      'My details',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),

                  //username
                  MyTextBox(
                    text: userData['username'], 
                    sectionName: 'username',
                    onPressed: () => editField('username'), 
                  ),
                  //bio
                    MyTextBox(
                    text: userData['bio'], 
                    sectionName: 'bio',
                    onPressed: () => editField('bio'), 
                  ),

                  const SizedBox(height: 50),

                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child : Text(
                      '',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),

                ],
              );
            } else if(snapshot.hasError) {
              return Center(child: Text('Error${snapshot.error}'),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
    );
  }
}
