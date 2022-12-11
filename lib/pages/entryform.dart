import 'package:flutter/material.dart';
import 'package:flutter_sqlite/models/item.dart';

class EntryForm extends StatefulWidget {
  const EntryForm({super.key});

  @override
  EntryFormState createState() => EntryFormState();
}

class EntryFormState extends State<EntryForm> {
  // Nullable Type Item
  Item? item = Item(name: '', price: 0);

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (item != null) {
      nameController.text = item!.name;
      // Merubah tipe controller yang menyimpan data menjadi tipe item
      // yang kemudian dipanggil dengan variabel item.name, maybe ?
      priceController.text = item!.price.toString();
    }

    return Scaffold(
      appBar: AppBar(
        // The Operand can't be null, so the condition is always false, if the variable not nullable type
        // In this case make item to nullable type
        title: item == null ? const Text('Tambah') : const Text('Ubah'),
        leading: const Icon(Icons.keyboard_arrow_left),
      ),
      body: ListView(
        children: [
          // Nama Barang
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: TextField(
              controller: nameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: 'Nama Barang',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
              onChanged: (value) {
                // TODO : method untuk form nama barang
              },
            ),
          ),

          // Harga Barang
          Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Harga Barang',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {
                  // TODO : Method untuk form harga barang
                },
              )),

          // Tombol Button
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Row(
              children: [
                // Tombol Simpan
                Expanded(
                    child: ElevatedButton(
                  child: const Text(
                    'Save',
                    textScaleFactor: 1.5,
                  ),
                  onPressed: () {
                    if (item == null) {
                      // Tambah Data
                      item = Item(
                          name: nameController.text,
                          price: int.parse(priceController.text));
                    } else {
                      // Ubah Data
                      item!.name = nameController.text;
                      item!.price = int.parse(priceController.text);
                    }
                    // Kembali ke layar sebelumnya dengan membawa objek item
                    Navigator.pop(context, item);
                  },
                )),
                Container(
                  width: 5.0,
                ),
                Expanded(
                    // Tombol batal
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Cancel',
                          textScaleFactor: 1.5,
                        )))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
