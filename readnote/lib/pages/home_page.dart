import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:readnote/components/my_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:readnote/components/wall_post.dart';
import 'package:readnote/components/drawer.dart';
import 'package:readnote/pages/profile_page.dart';
import 'package:readnote/pages/shelf_page.dart';
import 'package:readnote/pages/discover_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  final textController = TextEditingController();

  //sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void postMessage() {
    if(textController.text.isNotEmpty) {
      // store post in firestore
      FirebaseFirestore.instance.collection("User Posts").add({
        'UserEmail' : currentUser.email,
        'Message' : textController.text,
        'TimeStamp' : Timestamp.now(),
        'Likes' : [],
      });
    }

    //clear the textfield
    setState(() {
      textController.clear();
    });
  }

  void goToProfilePage() {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage(),
    ),
    );
  }

  void goToShelfPage() {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => ShelfPage(),
    ),
    );
  }

  void goToDiscoverPage() {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => DiscoverPage(),
    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('ReadNote', style: TextStyle(color : Colors.white),),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
        IconButton(
          onPressed: signUserOut, 
          icon: Icon(Icons.logout),
          ),
        ],  
      ),
      drawer: MyDrawer(
        onProfileTap: goToProfilePage,
        onSignOut: signUserOut,
        onShelfTap: goToShelfPage,
        onDiscoverTap: goToDiscoverPage,
        
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder( 
                stream: FirebaseFirestore.instance
                .collection("User Posts")
                .orderBy(
                  "TimeStamp", 
                  descending: false,
                )
                .snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final post = snapshot.data!.docs[index];
                        return WallPost(
                          message: post['Message'], 
                          user: post['UserEmail'], 
                          postId : post['Message'],
                          likes: List<String>.from(post['Likes'] ?? []),
                          // time: post['Time']
                        );
                      },
                    );
                  } else if(snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                  }
                  return const Center(child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
              children: [ 
                Expanded(
                  child: MyTextField(
                    controller: textController, 
                    hintText: "Write a post...",
                    obscureText: false,
                  ),
                  ),
                //post button
                IconButton(onPressed: postMessage, icon: const Icon(Icons.arrow_circle_up),)
              ],),
            ),
            Text(
              'Logged in as : ' + currentUser.email!,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 50,),
          ],
        ),
      ),
    );
  }
}