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
      debugShowCheckedModeBanner: false,
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

  //vamos a crear una var de tipo "Set"
  final Set<WordPair> saved = Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    //final wordPair = WordPair.random();
    //return Text(wordPair.asPascalCase);

    return Scaffold(
      appBar: AppBar(
        title: Text("Name StartUp Gen"),
        actions: <Widget>[
          IconButton(onPressed: pushSaved, icon: Icon(Icons.library_books_outlined))
        ],
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
    //Var q controla el color del icono fav
    final bool alreadySaved = saved.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: (){
        setState(() {
          //alreadySaved ? saved.remove(pair) : saved.add(pair),
          if (alreadySaved){
            saved.remove(pair);
          }
          else{
            saved.add(pair);
          }
        });
      },
    );
  }

  void pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
          builder: (BuildContext context){
            final Iterable<ListTile> tiles = saved.map(
                (WordPair pair){
                  return ListTile(
                    title: Text(
                      pair.asPascalCase,
                      style: biggerFont,
                    ),
                  );
                },
            );
            final List<Widget> divided = ListTile.divideTiles(
                context: context,
                tiles: tiles,
            ).toList();
            return Scaffold(
              appBar: AppBar(
                title: Text("Saved suggestions!!!"),
              ),
              body: ListView(
                children: divided,
              ),
            );
          })
    );
  }
}