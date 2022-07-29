import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_call/app/constants/color.dart';
import 'package:quran_call/app/data/models/juz.dart' as juz;
import 'package:quran_call/app/data/models/surah.dart';
import 'package:quran_call/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    if (Get.isDarkMode) {
      controller.isDark.value = true;
    }
    return Scaffold(
      appBar: AppBar(
        // elevation: Get.isDarkMode ? 0 : 4,
        title: Text('HomeView'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => Get.toNamed(Routes.SEARCH),
              icon: Icon(Icons.search))
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Assalamualaikum",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      appPurpleLight1,
                      appPurpleLight2,
                    ],
                  ),
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => Get.toNamed(Routes.LAST_READ),
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: -105,
                            right: -44,
                            child: Container(
                              height: 350,
                              width: 350,
                              child: Image.asset(
                                "assets/images/quran.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.menu_book_rounded,
                                      color: appWhite,
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      "Terakhir di baca",
                                      style: TextStyle(
                                        color: appWhite,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  "Al-Fatiha",
                                  style: TextStyle(
                                    color: appWhite,
                                  ),
                                ),
                                Text(
                                  "Ayat 1",
                                  style: TextStyle(
                                    color: appWhite,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              TabBar(
                tabs: [
                  Tab(
                    text: "Surah",
                    // child: Text(
                    //   "tes 1",
                    //   style: TextStyle(
                    //       color: appPurpleDark, fontWeight: FontWeight.bold),
                    // ),
                  ),
                  Tab(
                    text: "Juz",
                    // child: Text(
                    //   "tes 1",
                    //   style: TextStyle(
                    //       color: appPurpleDark, fontWeight: FontWeight.bold),
                    // ),
                  ),
                  Tab(
                    text: "Bookmark",
                    // child: Text(
                    //   "tes 1",
                    //   style: TextStyle(
                    //       color: appPurpleDark, fontWeight: FontWeight.bold),
                    // ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    FutureBuilder<List<Surah>>(
                      future: controller.getAllSurah(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text('tidak ada data'),
                          );
                        }
                        // print(snapshot.data);
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            Surah surah = snapshot.data![index];
                            return ListTile(
                              onTap: (() {
                                Get.toNamed(Routes.DETAIL_SURAH,
                                    arguments: surah);
                              }),
                              leading: Obx(
                                () => Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(controller.isDark.isTrue
                                          ? "assets/images/list_dark.png"
                                          : "assets/images/list_light.png"),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${surah.number}",
                                      // style: TextStyle(
                                      //     color: Get.isDarkMode
                                      //         ? appWhite
                                      //         : appPurpleDark),
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                "${surah.name?.transliteration?.id ?? 'Error...'}",
                              ),
                              subtitle: Text(
                                "${surah.numberOfVerses} Ayat | ${surah.revelation?.id ?? 'Error...'}",
                                style: TextStyle(color: Colors.grey[500]),
                              ),
                              trailing: Text(
                                "${surah.name?.short ?? 'Error...'}",
                              ),
                            );
                          },
                        );
                      },
                    ),
                    FutureBuilder<List<juz.Juz>>(
                      future: controller.getAllJuz(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            juz.Juz detailJuz = snapshot.data![index];
                            print(detailJuz.end);
                            return ListTile(
                              onTap: () {
                                Get.toNamed(Routes.DETAIL_JUZ,
                                    arguments: detailJuz);
                              },
                              leading: Obx(
                                () => Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(controller.isDark.isTrue
                                          ? "assets/images/list_dark.png"
                                          : "assets/images/list_light.png"),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${index + 1}",
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                "Juz ${index + 1}",
                              ),
                              isThreeLine: true,
                              subtitle: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Mulai dari ${detailJuz.start}",
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  Text(
                                    "Sampai ${detailJuz.end} ",
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    Center(
                      child: Text("tes 11"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.isDarkMode
              ? Get.changeTheme(themeLight)
              : Get.changeTheme(themeDark);
          controller.isDark.toggle();
        },
        child: Obx(
          () => Icon(
            Icons.color_lens,
            color: controller.isDark.isTrue ? appPurpleDark : appWhite,
          ),
        ),
      ),
    );
  }
}
