class Produk {
  int? id;
  String? mental_state;
  int? therapy_sessions;
  String? medication;
  Produk({this.id, this.mental_state, this.therapy_sessions, this.medication});
  factory Produk.fromJson(Map<String, dynamic> obj) {
    return Produk(
        id: obj['ID'],
        mental_state: obj['Mental State'],
        therapy_sessions: obj['Therapy Sessions'],
        medication: obj['Medication']);}
}