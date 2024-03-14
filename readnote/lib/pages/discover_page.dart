import 'package:flutter/material.dart';
import 'dart:math';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  List<String> genres = ['Mystery', 'Fantasy', 'Sci-Fi', 'Non-Fiction','Autobiographical'];
  String selectedGenre = 'Mystery';
  Map<String, List<Map<String, String>>> booksByGenre = {
    'Mystery': [
      {'name': 'And Then There Were None', 'image': 'lib/images/andthenthere.jpeg'},
      {'name': 'Gone Girl', 'image': 'lib/images/gonegirl.jpeg'},
      {'name': 'The Complete Sherlock Holmes', 'image': 'lib/images/sherlock.jpeg'},
      {'name': 'Murder on the Orient Express', 'image': 'lib/images/murder.jpeg'},
      {'name': 'The Silent Patient', 'image': 'lib/images/silent.jpeg'},
    ],
    'Fantasy': [
      {'name': 'Game of Thrones', 'image': 'lib/images/got.jpeg'},
      {'name': 'The Harry Potter', 'image': 'lib/images/harryp.jpg'},
      {'name': 'The Hobbit', 'image': 'lib/images/hobbit.jpg'},
      {'name': 'Fourth Wing', 'image': 'lib/images/fourth.jpeg'},
      {'name': 'Witch King', 'image': 'lib/images/witch.jpeg'},
    ],
    'Sci-Fi': [
      {'name': 'Frankenstein', 'image': 'lib/images/frank.jpeg'},
      {'name': 'The Giver', 'image': 'lib/images/thegiver.jpeg'},
      {'name': 'The City of Ember', 'image': 'lib/images/amber.jpeg'},
      {'name': 'A Wrinkle in Time', 'image': 'lib/images/wrinkle.jpeg'},
      {'name': 'Dune', 'image': 'lib/images/dune.jpeg'},
    ],
    'Non-Fiction': [
      {'name': 'A Brief History of Time', 'image': 'lib/images/abrief.jpeg'},
      {'name': 'In Cold Blood', 'image': 'lib/images/incoldblood.jpg'},
      {'name': 'Sapiens: A Brief History of Humankind', 'image': 'lib/images/sapiens.jpeg'},
      {'name': 'Atomic Habits', 'image': 'lib/images/atomic-habits.jpg'},
      {'name': 'The Body Keeps The Count', 'image': 'lib/images/thebodykeeps.jpg'},
    ],
    'Autobiographical': [
      {'name': 'The Diary of a Young Girl', 'image': 'lib/images/anne.jpeg'},
      {'name': 'Long Walk to Freedom', 'image': 'lib/images/mandela.jpeg'},
      {'name': 'I Am Malala', 'image': 'lib/images/malala.jpeg'},
      {'name': 'Educated', 'image': 'lib/images/educated.jpeg'},
    ],
  };
  Map<String, String> suggestedBook = {'name': '', 'image': ''};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Discover",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose a Genre you wish to read:',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedGenre,
              onChanged: (String? newValue) {
                setState(() {
                  selectedGenre = newValue!;
                  suggestedBook = _getSuggestedBook(selectedGenre);
                });
              },
              items: genres.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

            const SizedBox(height: 30),

            Text(
              'Browse more Books in ${selectedGenre} : ',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 5),

            Expanded(
              child: ListView.builder(
                itemCount: booksByGenre[selectedGenre]!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: Colors.blue[50],
                    child: Text(booksByGenre[selectedGenre]![index]['name']!),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Here's a Book recommendation for you : ",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  width: 320,
                  height: 370,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(suggestedBook['image'] ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    suggestedBook['name'] ?? '',
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Map<String, String> _getSuggestedBook(String genre) {
    List<Map<String, String>> books = booksByGenre[genre]!;
    if (books.isNotEmpty) {
      Random random = Random();
      int index = random.nextInt(books.length);
      return books[index];
    } else {
      return {'name': '', 'image': ''};
    }
  }
}
