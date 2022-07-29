import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quran_call/app/constants/color.dart';
import 'package:quran_call/app/data/models/juz.dart' as juz;

import '../controllers/detail_juz_controller.dart';

class DetailJuzView extends GetView<DetailJuzController> {
  final juz.Juz detailJuz = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JUZ ${detailJuz.juz}'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: detailJuz.verses?.length ?? 0,
        itemBuilder: (context, index) {
          if (detailJuz.verses == null || detailJuz.verses?.length == 0) {
            return Center(
              child: Text("tidak ada data"),
            );
          }
          juz.Verses ayat = detailJuz.verses![index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: appPurpleLight2.withOpacity(0.3),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(Get.isDarkMode
                                ? "assets/images/list_dark.png"
                                : "assets/images/list_light.png"),
                            fit: BoxFit.contain,
                          ),
                        ),
                        child: Center(
                          child: Text("${ayat.number?.inSurah}"),
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
                  "${ayat.text?.arab}",
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
                style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
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
      ),
    );
  }
}
