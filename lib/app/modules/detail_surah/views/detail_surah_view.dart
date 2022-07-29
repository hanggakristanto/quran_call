import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quran_call/app/constants/color.dart';
import 'package:quran_call/app/data/models/detail_surah.dart' as detail;
import 'package:quran_call/app/data/models/surah.dart';

import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  @override
  Widget build(BuildContext context) {
    final Surah surah = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'surah ${surah.name?.translation?.id?.toUpperCase() ?? 'error'}'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          GestureDetector(
            onTap: () => Get.defaultDialog(
              contentPadding: EdgeInsets.all(20),
              title: "Tafsir ${surah.name?.transliteration?.id}",
              titleStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              content: Container(
                child: Text(
                  "${surah.tafsir?.id ?? 'Tidak ada tafsir'}",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    appPurpleLight1,
                    appPurpleLight2,
                  ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "${surah.name?.transliteration?.id?.toUpperCase() ?? 'Error...'}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: appWhite,
                      ),
                    ),
                    Text(
                      "( ${surah.name?.translation?.id?.toUpperCase() ?? 'Error...'} )",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: appWhite,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${surah.numberOfVerses ?? 'Error...'} Ayat | ${surah.revelation?.id}",
                      style: TextStyle(
                        fontSize: 16,
                        color: appWhite,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          FutureBuilder<detail.DetailSurah>(
            future: controller.getDetailsurah(surah.number.toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!snapshot.hasData) {
                return Center(
                  child: Text('tidak ada data'),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data?.verses?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  if (snapshot.data?.verses?.length == 0) {
                    return SizedBox();
                  }
                  detail.Verse? ayat = snapshot.data?.verses?[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: appPurpleLight2.withOpacity(0.3),
                        ),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(Get.isDarkMode
                                        ? "assets/images/list_dark.png"
                                        : "assets/images/list_light.png"),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                child: Center(
                                  child: Text("${index + 1}"),
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.bookmark_add_outlined),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.play_arrow),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "${ayat!.text?.arab}",
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${ayat.text?.transliteration?.en}",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: 18, fontStyle: FontStyle.italic),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        "${ayat.translation?.id}",
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
