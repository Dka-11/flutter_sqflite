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
        title: const Text('Daftar Item \n Adika Ahmad Hanif N.| 2041720171'),
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
                    onPressed: () async {
                      Item item = await navigateToEntryForm(context, null);
                      int result = await SQLHelper.createItem(item);
                      if (result > 0) updateListView();
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
      itemCount: count,
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
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Harga : ${itemList[index].price}"),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Stock : ${itemList[index].stock}",
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(" ${itemList[index].itemCode}")
            ],
          ),
          trailing: GestureDetector(
            child: const Icon(Icons.delete),
            onTap: () async {
              SQLHelper.deleteItem(itemList[index].id!);
              updateListView();
              // 3 TODO : Delete by id
            },
          ),
          onTap: () async {
            Item item = await navigateToEntryForm(context, itemList[index]);
            SQLHelper.updateItem(item);
            updateListView();
            // 4 TODO : Edit by id
          },
        ),
      ),
    );
  }

  Future<Item> navigateToEntryForm(context, Item? item) async {
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EntryForm(
                  item: item,
                )));
    return result;
  }

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
