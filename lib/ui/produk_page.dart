import 'package:flutter/material.dart';
import 'package:responsi_uts/bloc/logout_bloc.dart';
import 'package:responsi_uts/bloc/produk_bloc.dart';
import 'package:responsi_uts/model/produk.dart';
import 'package:responsi_uts/ui/login_page.dart';
import 'package:responsi_uts/ui/produk_detail.dart';
import 'package:responsi_uts/ui/produk_form.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({Key? key}) : super(key: key);

  @override
  _ProdukPageState createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Penyakit Mental'),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: const Icon(Icons.add, size: 26.0),
                onTap: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProdukForm()));
                },
              ))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false)
                });
              },
            )
          ],
        ),
      ),
      body: FutureBuilder<List>(
        future: ProdukBloc.getProduks(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListProduk(
            list: snapshot.data,
          )
              : const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class ListProduk extends StatelessWidget {
  final List? list;
  const ListProduk({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list!.length,
      itemBuilder: (context, i) {
        return ItemProduk(
          produk: list![i],
        );
      },
    );
  }
}

class ItemProduk extends StatelessWidget {
  final Produk produk;
  const ItemProduk({Key? key, required this.produk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProdukDetail(
                  produk: produk,
                )));
      },
      child: Card(
        color: Colors.green[100], // Set the card color to light green
        elevation: 2, // Add some elevation for depth
        child: ListTile(
          title: Text(
            produk.therapy_sessions! as String,
            style: const TextStyle(
              color: Colors.black, // Black text color for contrast
            ),
          ),
          subtitle: Text(
            produk.medication.toString(),
            style: const TextStyle(
              color: Colors.black, // Black text color for contrast
            ),
          ),
        ),
      ),
    );
  }
}
