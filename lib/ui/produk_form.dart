import 'package:flutter/material.dart';
import 'package:responsi_uts/bloc/produk_bloc.dart';
import 'package:responsi_uts/model/produk.dart';
import 'package:responsi_uts/ui/produk_page.dart';
import 'package:responsi_uts/widget/warning_dialog.dart';
// ignore: must_be_immutable
class ProdukForm extends StatefulWidget {
  Produk? produk;
  ProdukForm({Key? key, this.produk}) : super(key: key);
  @override
  _ProdukFormState createState() => _ProdukFormState();
}
class _ProdukFormState extends State<ProdukForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH PENYAKIT MENTAL";
  String tombolSubmit = "SIMPAN";
  final _mental_stateTextboxController = TextEditingController();
  final _therapy_sessionsTextboxController = TextEditingController();
  final _medicationTextboxController = TextEditingController();
  @override
  void initState() {
    super.initState();
    isUpdate();
  }
  isUpdate() {
    if (widget.produk != null) {
      setState(() {
        judul = "UBAH PENYAKIT MENTAL";
        tombolSubmit = "UBAH";
        _mental_stateTextboxController.text = widget.produk!.mental_state!;
        _therapy_sessionsTextboxController.text = widget.produk!.therapy_sessions.toString();
        _medicationTextboxController.text =
            widget.produk!.medication.toString();
      });
    } else {
      judul = "TAMBAH PENYAKIT MENTAL";tombolSubmit = "SIMPAN";
    }
  } @
  override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _kodeProdukTextField(),
                _namaProdukTextField(),
                _hargaProdukTextField(),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }
//Membuat Textbox Kode Produk
  Widget _kodeProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Mental State"),
      keyboardType: TextInputType.text,
      controller: _mental_stateTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Mental State harus diisi";
        }
        return null;
      },
    );
  }//Membuat Textbox Nama Produk
  Widget _namaProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Therapy Sessions"),
      keyboardType: TextInputType.text,
      controller: _therapy_sessionsTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Therapy sessions harus diisi";
        }
        return null;
      },
    );
  }
//Membuat Textbox Harga Produk
  Widget _hargaProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Medication"),
      keyboardType: TextInputType.number,
      controller: _medicationTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Medication harus diisi";
        }
        return null;
      },
    );
  }
//Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return OutlinedButton(
        child: Text(tombolSubmit),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.produk != null) {
//kondisi update produk
                ubah();
              } else {//kondisi tambah produk
                simpan();
              }
            }
          }
        });
  }
  simpan() {
    setState(() {
      _isLoading = true;
    });
    Produk createProduk = Produk(id: null);
    createProduk.mental_state = _mental_stateTextboxController.text;
    createProduk.therapy_sessions = _therapy_sessionsTextboxController.text as int?;
    createProduk.medication = int.parse(_medicationTextboxController.text) as String?;
    ProdukBloc.addProduk(produk: createProduk).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const ProdukPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
            description: "Simpan gagal, silahkan coba lagi",
          ));
    });
    setState(() {
      _isLoading = false;
    });
  }
  ubah() {
    setState(() {
      _isLoading = true;
    });
    Produk updateProduk = Produk(id: widget.produk!.id!);
    updateProduk.mental_state = _mental_stateTextboxController.text;
    updateProduk.therapy_sessions = _therapy_sessionsTextboxController.text as int?;
    updateProduk.medication = int.parse(_medicationTextboxController.text) as String?;
    ProdukBloc.updateProduk(produk: updateProduk).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const ProdukPage()));}, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
            description: "Permintaan ubah data gagal, silahkan coba lagi",
          ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}