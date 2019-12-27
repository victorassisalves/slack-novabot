import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());
Color novaColor = const Color(0xFF1F6BFF);
class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     debugShowCheckedModeBanner: false,
     title: 'Novaquotes',
     home: MyHomePage(),
   );
 }
}

class MyHomePage extends StatefulWidget {
 @override
 _MyHomePageState createState() {
   return _MyHomePageState();
 }
}

class _MyHomePageState extends State<MyHomePage> {
 @override
 Widget build(BuildContext context) {
   return Scaffold(

     appBar: AppBar(
       backgroundColor: novaColor,
       title: Image.asset('assets/MarcaNovatics_negativo.png', fit: BoxFit.contain, height: 20)),
        //  Text('Novaquotes')),
     body: _buildBody(context),
   );
 }

Widget _buildBody(BuildContext context) {
 return StreamBuilder<QuerySnapshot>(
   stream: Firestore.instance.collection('quotes').snapshots(),
   builder: (context, snapshot) {
     Container(child: Text("Quotes..."),);
     if (!snapshot.hasData) return LinearProgressIndicator();
     if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...');
          default:
            return _buildList(context, snapshot.data.documents);
        }
   },
 );
}

 Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
   return ListView(
     padding: const EdgeInsets.only(top: 20.0),
     children: snapshot.map((data) => _buildListItem(context, data)).toList(),
   );
 }

 Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
   final record = Record.fromSnapshot(data);

   return Padding(
     key: ValueKey(record.text),
     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
     child: Container(
       decoration: BoxDecoration(
         border: Border.all(color: Colors.grey),
         borderRadius: BorderRadius.circular(5.0),
       ),
       child: ListTile(
         title: Text("\"${record.text}\""),
         subtitle: Text("Autor: @${record.author}"),
         trailing: Icon(
           Icons.favorite,
           color: Colors.grey,
           size: 24.0,
           semanticLabel: 'Text to announce in accessibility modes',
         ),
         onTap: () => print(record),
       ),
     ),
   );
 }
}

class Record {
 final String text;
 final String author;
 final int likes;
 final DocumentReference reference;

 Record.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['text'] != null),
       assert(map['author'] != null),
       assert(map['likes'] != null),
       text = map['text'],
       author = map['author'],
       likes = map['likes'];

 Record.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);

 @override
 String toString() => "Record<$text : $author";
}