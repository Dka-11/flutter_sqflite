import 'package:flutter/material.dart';
import 'package:flutter_sqlite/models/item.dart';

class EntryForm extends StatefulWidget {
  Item? item;
  EntryForm({super.key, required this.item});

  @override
  EntryFormState createState() => EntryFormState();
}

class EntryFormState extends State<EntryForm> {
  // Nullable Type Item

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.item != null) {
      nameController.text = widget.item!.name;
      // Merubah tipe controller yang menyimpan data menjadi tipe item
      // yang kemudian dipanggil dengan variabel item.name, maybe ?
      priceController.text = widget.item!.price.toString();
    }

    return Scaffold(
      appBar: AppBar(
        // The Operand can't be null, so the condition is always false, if the variable not nullable type
        // In this case make item to nullable type
        title: widget.item == null ? const Text('Tambah') : const Text('Ubah'),
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
                    if (widget.item == null) {
                      // Tambah Data
                      widget.item = Item(
                          name: nameController.text,
                          price: int.parse(priceController.text));
                    } else {
                      // Ubah Data
                      widget.item!.name = nameController.text;
                      widget.item!.price = int.parse(priceController.text);
                    }
                    // Kembali ke layar sebelumnya dengan membawa objek item
                    Navigator.pop(context, widget.item);
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
