import 'package:get/get.dart';
import 'package:quran_call/app/data/models/detail_surah.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailSurahController extends GetxController {
  Future<DetailSurah> getDetailsurah(String id) async {
    Uri url = Uri.parse("https://api.quran.sutanlab.id/surah/$id");
    var res = await http.get(url);
    // print(url);
    // print(res.body);

    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)["data"];
    print(data);
    return DetailSurah.fromJson(data);
  }
}
