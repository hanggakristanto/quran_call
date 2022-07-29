import 'package:quran_call/app/data/models/ayat.dart';
import 'package:quran_call/app/data/models/detail_surah.dart';
import 'package:http/http.dart' as http;
import 'package:quran_call/app/data/models/surah.dart';
import 'dart:convert';

void main() async {
  var res =
      await http.get(Uri.parse("https://api.quran.sutanlab.id/surah/108/1"));
  Map<String, dynamic> data = json.decode(res.body)["data"];
  // print(data);
  Map<String, dynamic> dataModel = {
    "number": data["number"],
    "meta": data["meta"],
    "text": data["text"],
    "translation": data["translation"],
    "audio": data["audio"],
    "tafsir": data["tafsir"],
  };
  Ayat ayat = Ayat.fromJson(dataModel);
  print(ayat.tafsir?.id?.short);

  // Uri url = Uri.parse("https://api.quran.sutanlab.id/surah");
  // var res = await http.get(url);

  // print(res.body);

  // print('--------------------');
  // List data = (json.decode(res.body) as Map<String, dynamic>)["data"];
  // Surah surahAnnas = Surah.fromJson(data[113]);
  // print(surahAnnas.toJson());
  // print('--------------------');
  // print(surahAnnas.name);

  //detail surah
  // Uri urlAnnas =
  //     Uri.parse("https://api.quran.sutanlab.id/surah/${surahAnnas.number}");
  // var resAnnas = await http.get(urlAnnas);

  // Map<String, dynamic> dataAnnas =
  //     (json.decode(resAnnas.body) as Map<String, dynamic>)['data'];
  // DetailSurah annas = DetailSurah.fromJson(dataAnnas);
  // print(annas.verses![0].text!.arab);
}
