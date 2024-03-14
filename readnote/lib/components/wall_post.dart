import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:readnote/components/comment_button.dart";
import "package:readnote/components/like_button.dart";
import "package:readnote/helper/helper_methods.dart";
import "package:readnote/components/comment.dart";

class WallPost extends StatefulWidget {
  final String message;
  final String user;
  final String postId;
  final List<String> likes;
  // final String time;
  const WallPost({
    super.key,
    required this.message,
    required this.user,
    required this.postId,
    required this.likes,
    // required this.time,
    });

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {

  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  final _commentTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    //access doc in firebase
    DocumentReference postRef = FirebaseFirestore.instance.collection('User Posts').doc(widget.postId);
    if(isLiked) {
      //add email to posts likes field in db
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  void addComment(String commentText) {
    FirebaseFirestore.instance
    .collection("User Posts")
    .doc(widget.postId)
    .collection("Comments")
    .add({
      "CommentText" : commentText,
      "CommentedBy" : currentUser.email,
      "CommentTime" : Timestamp.now()
    });
  }

  void showCommentDialog() {
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text("Add Comment"),
        content: TextField(
          controller: _commentTextController,
          decoration: const InputDecoration(hintText: "Write a comment..."),
        ),
        actions: [ 
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _commentTextController.clear();
            },
            child: const Text("Cancel"),
          ), 

          TextButton(
            onPressed: () { 
              addComment(_commentTextController.text);
              Navigator.pop(context);
              _commentTextController.clear();
            }, 
            child: const Text("Post"),
          ),
        ],
      ),);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration : BoxDecoration( 
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),

      ),
      margin : const EdgeInsets.only(top: 25, left: 25, right:25),
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //profile 
          // Container( 
          //   decoration : BoxDecoration( 
          //     shape: BoxShape.circle, color: Colors.grey[400]
          //   ),
          //   padding: EdgeInsets.all(10),
          //   child: const Icon(
          //     Icons.person,
          //     color: Colors.white,
          //   ),
          // ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ 
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(4),
                ),
                margin: const EdgeInsets.only(bottom: 5),
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.message),
                  ],
                ),
              ),

              const SizedBox(height:5),

              Text(
                widget.user,
                style: TextStyle(color: Colors.grey[500]),
              ),
             
            ],
          ),

          const SizedBox(width: 20,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //like button
              Column( 
                children : [
                  LikeButton(
                    isLiked: isLiked, 
                    onTap: toggleLike,
                  ),
              
                  const SizedBox(height: 5),
                  //Text(widget.likes.length.toString(),
                  //style: const TextStyle(color: Colors.grey),
                  //),
              ],),

              const SizedBox(width: 10),
              //comment button
              Column( 
                children : [
                  CommentButton(onTap: showCommentDialog),
              
                  const SizedBox(height: 5),

                  // Text(
                  //   '0',
                  //   style: const TextStyle(color: Colors.grey),
                  // ),
              ],),
            ],
          ),

          const SizedBox(height: 20,),
//display comments
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
            .collection("User Posts")
            .doc(widget.postId)
            .collection("Comments")
            .orderBy("CommentTime", descending: true)
            .snapshots(),
            builder: (context, snapshot) {
              if(!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Comments",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: snapshot.data!.docs.map((doc) {
                      final commentData = doc.data() as Map<String, dynamic>;
                      return Comment(
                        text: commentData["CommentText"],
                        user: commentData["CommentedBy"],
                        time: formatDate(commentData["CommentTime"]),
                      );
                    }).toList(),
                  ),
                ],
              );

            },
            
          )
        ],
      ),
    );
  }
}