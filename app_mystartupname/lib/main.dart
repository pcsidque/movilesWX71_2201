import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final wordPair = WordPair.random();
    return MaterialApp(
      home: RandomWord(),
    );
  }
}

class RandomWord extends StatefulWidget {
  const RandomWord({Key? key}) : super(key: key);

  @override
  State<RandomWord> createState() => _RandomWordState();
}

class _RandomWordState extends State<RandomWord> {
  final List<WordPair> suggestions = <WordPair>[];
  final TextStyle biggerFont = TextStyle(fontSize: 16);

  @override
  Widget build(BuildContext context) {
    //final wordPair = WordPair.random();
    //return Text(wordPair.asPascalCase);

    return Scaffold(
      appBar: AppBar(
        title: Text("Name StartUp Gen"),
      ),
      body: buildSggestions(),
    );
  }

  Widget buildSggestions(){
    return ListView.builder(
        padding: EdgeInsets.all(5),
        itemBuilder: (BuildContext context, int i){
          if (i.isOdd){
            return Divider(
              thickness: 2,
            );
    }
          final int index = i ~/ 2;
          print(i);

          if (index >= suggestions.length){
            suggestions.addAll(generateWordPairs().take(10));
    }
          return buildRow(suggestions[index]);
    }
    );
  }

  Widget buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: biggerFont,
      ),
    );
  }
}