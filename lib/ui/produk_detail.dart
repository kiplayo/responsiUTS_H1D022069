import 'package:flutter/material.dart';
import 'package:responsi_uts/bloc/produk_bloc.dart';
import 'package:responsi_uts/model/produk.dart';
import 'package:responsi_uts/ui/produk_form.dart';
import 'package:responsi_uts/ui/produk_page.dart';
import 'package:responsi_uts/widget/warning_dialog.dart';
// ignore: must_be_immutable
class ProdukDetail extends StatefulWidget {
  Produk? produk;
  ProdukDetail({Key? key, this.produk}) : super(key: key);
  @override
  _ProdukDetailState createState() => _ProdukDetailState();
}
class _ProdukDetailState extends State<ProdukDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Penyakit Mental'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Mental State : ${widget.produk!.mental_state}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text("Therapy Sessions : ${widget.produk!.therapy_sessions}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Medication : ${widget.produk!.medication.toString()}",
              style: const TextStyle(fontSize: 18.0),
            ),
            _tombolHapusEdit()
          ],
        ),
      ),
    );
  }
  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
// Tombol Edit
        OutlinedButton(
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProdukForm(
                  produk: widget.produk!,
                ),
              ),
            );
          },
        ),
// Tombol Hapus
        OutlinedButton(
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }
  void confirmHapus() {AlertDialog alertDialog = AlertDialog(
    content: const Text("Yakin ingin menghapus data ini?"),
    actions: [
//tombol hapus
      OutlinedButton(
        child: const Text("Ya"),
        onPressed: () {
          ProdukBloc.deleteProduk(id:(widget.produk!.id!)).then(
                  (value) => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProdukPage()))
              }, onError: (error) {
            showDialog(
                context: context,
                builder: (BuildContext context) => const WarningDialog(
                  description: "Hapus gagal, silahkan coba lagi",
                ));
          });
        },
      ),
//tombol batal
      OutlinedButton(
        child: const Text("Batal"),
        onPressed: () => Navigator.pop(context),
      )
    ],
  );
  showDialog(builder: (context) => alertDialog, context: context);
  }
}