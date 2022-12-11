import 'package:flutter/material.dart';
import 'package:flutter_sqlite/models/item.dart';
import 'package:flutter_sqlite/pages/entryform.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_sqlite/helpers/sql_helper.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  int count = 0;
  List<Item> itemList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Item'),
      ),
      body: Column(
        children: [
          Expanded(
            child: createListView(),
          ),
          Container(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EntryForm()));
                    },
                    child: const Text('Tambah Item')),
              ))
        ],
      ),
    );
  }

  ListView createListView() {
    TextStyle? textStyle = Theme.of(context).textTheme.headline5;
    return ListView.builder(
      itemBuilder: (context, index) => Card(
        color: Colors.white,
        elevation: 2.0,
        child: ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.red,
            child: Icon(Icons.ad_units),
          ),
          title: Text(
            itemList[index].name,
            style: textStyle,
          ),
          subtitle: Text(itemList[index].price.toString()),
          trailing: GestureDetector(
            child: const Icon(Icons.delete),
            onTap: () async {
              // 3 TODO : Delete by id
            },
          ),
          onTap: () async {
            /*
            var item = await navigateToEntryForm(context, itemlist[index]);
            */
            // 4 TODO : Edit by id
          },
        ),
      ),
    );
  }
/*
Future<Item> navigateToEntryForm(context, item) async{
  var result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const EntryForm()),
    );
    return result
}
*/

  void updateListView() {
    final Future<Database> dbFuture = SQLHelper.db();
    dbFuture.then((database) {
      // TODO : Get All Item From DB
      Future<List<Item>> itemListFuture = SQLHelper.getItemList();
      itemListFuture.then((itemList) {
        setState(() {
          this.itemList = itemList;
          count = itemList.length;
        });
      });
    });
  }
}
