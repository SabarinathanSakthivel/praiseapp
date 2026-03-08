// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

import '../../main.dart';
import '../../models/praise_types.dart';
import '../../models/praises.dart';
import '../../utils/constants/constants.dart';
import '../../utils/funtions/common_utils.dart';
import '../../utils/widgets/text_widget.dart';

class ParaiseMainPage extends StatefulWidget {
  PraiseTypes? praiseTypes = PraiseTypes();
  ParaiseMainPage({super.key, this.praiseTypes});

  @override
  State<ParaiseMainPage> createState() => _ParaiseMainPageState();
}

class _ParaiseMainPageState extends State<ParaiseMainPage> {
  double width = 0.0;
  double height = 0.0;

  List<Praises> praiseListTanglish = [];
  List<Praises> praiseListTamil = [];
  List<Praises> viewPraiseList = [];

  int pageIndex = 0;
  int pageNo = 1;
  int pageCount = 20;
  int totalPage = 122;
  int totalCount = 0;

  PageController pageController = PageController();
  ScrollController scrollController = ScrollController();
  bool isLoading = false;

  String currentLanguage = "TAMIL";
  Image? bacroundImage;

  pagewisePrasies(index) {
    int startIndex = index * pageCount;
    int endIndex = startIndex +
        (totalCount - startIndex >= pageCount
            ? pageCount
            : totalCount - startIndex);
    setState(() {
      pageIndex = index;
      pageNo = index + 1;
      viewPraiseList.clear();
      if (currentLanguage.toUpperCase() == "TAMIL") {
        viewPraiseList.addAll(praiseListTamil.sublist(startIndex, endIndex));
      } else {
        viewPraiseList.addAll(praiseListTanglish.sublist(startIndex, endIndex));
      }
      //print(viewPraiseList.length);
    });
  }

  loadData() async {
    if (widget.praiseTypes != null) {
      if (widget.praiseTypes!.id == 1) {
        praiseListTamil =
            await loadPraises('assets/data/tam_praises_MuzYut.json');
        praiseListTanglish =
            await loadPraises('assets/data/tan_praises_MuzYut.json');
      } else if (widget.praiseTypes!.id == 2) {
        praiseListTamil = await loadPraises('assets/data/tam_praises_Bel.json');
        praiseListTanglish =
            await loadPraises('assets/data/tan_praises_Bel.json');
      } else if (widget.praiseTypes!.id == 3) {
        praiseListTamil =
            await loadPraises('assets/data/tam_praises_NewBel.json');
        praiseListTanglish =
            await loadPraises('assets/data/tan_praises_NewBel.json');
      }
      totalCount = praiseListTamil.length;
    }
  }

  getPraises() async {
    isLoading = true;
    await loadData();
    setState(() {
      getTotalPage(totalCount);
      pagewisePrasies(0);
    });
    isLoading = false;
  }

  getTotalPage(listLength) {
    double pagedivide = listLength / pageCount;
    totalPage = pagedivide.ceil();
  }

  switchLanguage() {
    if (currentLanguage.toUpperCase() == "TAMIL") {
      currentLanguage = "ENGLISH";
    } else {
      currentLanguage = "TAMIL";
    }
    pagewisePrasies(pageIndex);
  }

  initSettings() {
    bacroundImage = decodeImage(MyApp.styles.backImage);
  }

  @override
  void initState() {
    super.initState();
    initSettings();
    getPraises();
    scrollController.addListener(swapPageListener);
    Wakelock.enable();
  }

  @override
  void dispose() {
    Wakelock.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.praiseTypes?.name ?? "துதி பலிகள்",
            style: const TextStyle(
                fontSize: textSizeLargeMedium, fontFamily: fontMedium)),
        actions: [
          // IconButton(
          //     onPressed: () {
          //       // Navigator.pop(context);
          //       // Navigator.push(
          //       //     context,
          //       //     MaterialPageRoute(
          //       //         builder: (context) => AudioPage(
          //       //             //praiseTypes: praiseTypes,
          //       //             )));
          //     },
          //     icon: const Icon(Icons.audiotrack)),
          IconButton(
              onPressed: () {
                switchLanguage();
              },
              icon: const Icon(Icons.switch_account)),
          Container(
            width: 40,
            margin:
                const EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 10),
            child: ClipOval(
              child: Material(
                color: const Color.fromARGB(255, 243, 33, 145), // Button color
                child: InkWell(
                  splashColor: Colors.red, // Splash color
                  onTap: () {
                    pageDialog();
                  },
                  child: Center(
                    child: text(pageNo.toString(),
                        fontSize: textSizeNormal, textColor: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        child: Container(
            decoration: MyApp.styles.backType == "color"
                ? BoxDecoration(
                    color: MyApp.styles.backColor,
                    borderRadius: BorderRadius.circular(0),
                    boxShadow: const [
                      BoxShadow(color: Colors.white),
                    ],
                  )
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    boxShadow: const [
                      BoxShadow(color: Colors.white, spreadRadius: 3),
                    ],
                    image: DecorationImage(
                        image: bacroundImage!.image, fit: BoxFit.cover)),
            child: praisePage()),
      ),
    );
  }

  pageDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text('Choose Page'),
            content: SizedBox(
              height: height / 1.5,
              width: width,
              child: GridView.count(
                crossAxisCount: 4,
                childAspectRatio: 2.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                children: [
                  for (int i = 0; i < totalPage; i++) ...{
                    ClipOval(
                      clipBehavior: Clip.antiAlias,
                      child: Material(
                        color: Colors.blue, // Button color
                        child: InkWell(
                          splashColor: Colors.red, // Splash color
                          onTap: () {
                            setState(() {
                              pagewisePrasies(i);
                              pageController.jumpToPage(i);
                              Navigator.pop(context);
                            });
                          },
                          child: Center(
                            child: text((i + 1).toString(),
                                fontSize: textSizeNormal,
                                textColor: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  },
                ],
              ),
            ));
      },
    );
  }

  Widget praisePage() {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : PageView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: totalPage,
            controller: pageController,
            onPageChanged: (int page) {
              pagewisePrasies(page);
            },
            itemBuilder: (context, index) {
              return ListView.builder(
                  //controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: viewPraiseList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item = viewPraiseList[index];
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Wrap(
                        children: [
                          text(
                            "${item.id}. ${item.praise}",
                            isLongText: true,
                            isBold: MyApp.styles.fontWeight == "Bold"
                                ? true
                                : false,
                            isItalic: MyApp.styles.fontStyle == "Italic"
                                ? true
                                : false,
                            fontFamily: MyApp.styles.fontFamily,
                            fontSize: MyApp.styles.fontSize,
                            textColor: MyApp.styles.fontColor,
                          ),
                          const SizedBox(
                            height: 5,
                          )
                        ],
                      ),
                    );
                  });
            },
          );
  }

  void swapPageListener() {
    if (scrollController.offset >
        scrollController.position.maxScrollExtent + 120) {
      if (pageIndex < totalPage - 1) {
        setState(() {
          pageIndex++;
          pagewisePrasies(pageIndex);
          pageController.jumpToPage(pageIndex);
        });
      }
    }

    if (scrollController.offset <
        scrollController.position.minScrollExtent - 120) {
      if (pageIndex > 0) {
        setState(() {
          pageIndex--;
          pagewisePrasies(pageIndex);
          pageController.jumpToPage(pageIndex);
        });
      }
    }
  }
}
