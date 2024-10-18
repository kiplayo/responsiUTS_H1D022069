class ApiUrl {
  static const String baseUrl = 'http://103.196.155.42/api';

  static const String registrasi = '$baseUrl/registrasi';
  static const String login = '$baseUrl/login';

  // Pengeluaran endpoints
  static const String listProduk = '$baseUrl/kesehatan/kesehatan_mental';
  static const String createProduk = '$baseUrl/kesehatan/kesehatan_mental';

  static String showProduk(int id) {
    return '$baseUrl/kesehatan/kesehatan_mental/$id';
  }

  static String updateProduk(int id) {
    return '$baseUrl/kesehatan/kesehatan_mental/$id/update';
  }

  static String deleteProduk(int id) {
    return '$baseUrl/kesehatan/kesehatan_mental/$id/delete';
  }
}