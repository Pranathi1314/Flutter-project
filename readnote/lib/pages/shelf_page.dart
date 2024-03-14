// import 'package:flutter/material.dart';

// class ShelfPage extends StatefulWidget {
//   const ShelfPage({super.key});

//   @override
//   State<ShelfPage> createState() => _ShelfPageState();
// }

// class _ShelfPageState extends State<ShelfPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Shelf Page"),),
//     );
//   }
// }

import 'package:flutter/material.dart';

class Book {
  String title;

  Book(this.title);
}

class ShelfPage extends StatefulWidget {
  const ShelfPage({Key? key}) : super(key: key);

  @override
  State<ShelfPage> createState() => _ShelfPageState();
}

class _ShelfPageState extends State<ShelfPage> {
  List<Book> toRead = [Book("A brief history of Time"), Book("The Alchemist"), Book("And then there were none")];
  List<Book> currentlyReading = [Book("The little prince"), Book("Harry Potter and the Goblet of Fire")];
  List<Book> read = [Book('Little Women'), Book("The Mountain is you")];

  TextEditingController toReadController = TextEditingController();
  TextEditingController currentlyReadingController = TextEditingController();
  TextEditingController readController = TextEditingController();

  void addBookToList(String bookTitle, List<Book> list) {
    setState(() {
      list.add(Book(bookTitle));
    });
  }

  void moveToCurrentlyReading(Book book) {
    setState(() {
      toRead.remove(book);
      currentlyReading.add(book);
    });
  }

  void moveToRead(Book book) {
    setState(() {
      currentlyReading.remove(book);
      read.add(book);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Book Shelf", 
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black, 
        iconTheme: const IconThemeData(color: Colors.white),

      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              color: Colors.blue[50],
              child: Column(
                children: [
                  Container(
                    color: Colors.grey[200],
                    child: TextField(
                      controller: toReadController,
                      decoration: const InputDecoration(
                        labelText: 'Add to List of "Want to Read" Books',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      addBookToList(toReadController.text, toRead);
                      toReadController.clear();
                    },
                    child: Text('Add'),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: toRead.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            toRead[index].title,
                            style: TextStyle(color: Colors.black),
                          ),
                          trailing: ElevatedButton(
                            onPressed: () {
                              moveToCurrentlyReading(toRead[index]);
                            },
                            child: Text('Move to Currently Reading'),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blue[50],
              child: Column(
                children: [
                  Container(
                    color: Colors.grey[200],
                    child: TextField(
                      controller: currentlyReadingController,
                      decoration: const InputDecoration(
                        labelText: 'Add to List of "Currently Reading" Books',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      addBookToList(
                          currentlyReadingController.text, currentlyReading);
                      currentlyReadingController.clear();
                    },
                    child: Text('Add'),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: currentlyReading.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            currentlyReading[index].title,
                            style: TextStyle(color: Colors.black),
                          ),
                          trailing: ElevatedButton(
                            onPressed: () {
                              moveToRead(currentlyReading[index]);
                            },
                            child: Text('Move to Finished Reading',),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blue[50],
              child: Column(
                children: [
                  Container(
                    color: Colors.grey[200],
                    child: TextField(
                      controller: readController,
                      decoration: const InputDecoration(
                        labelText: 'Add to List of "Finished Reading" Books',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      addBookToList(readController.text, read);
                      readController.clear();
                    },
                    child: Text('Add'),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: read.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            read[index].title,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ShelfPage(),
  ));
}
