import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:praise/routes/common_route_functions.dart';

import '../../models/praise_types.dart';
import '../../routes/route_paths.dart';
import '../../utils/constants/colors.dart';
import '../../utils/widgets/drawer.dart';
import '../../utils/widgets/text_widget.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  double width = 0.0;
  double height = 0.0;
  List<PraiseTypes> praiseTypeList = [
    PraiseTypes(
        id: 1,
        name: 'துதி பலிகள்',
        url:
            'https://drive.google.com/uc?export=view&id=1mD2kjg9aRPqPDkcx-DeS1cKhwMiupa96'),
    PraiseTypes(
        id: 2,
        name: 'ஆவிக்குரிய ஆசீர்வாததிற்காக',
        url:
            'https://drive.google.com/uc?export=view&id=1SLtmbmukR7U3A6P6JtVeeRF1bBHhUaPX'),
    PraiseTypes(
        id: 3,
        name: 'விடுதலைக்காக',
        url:
            'https://drive.google.com/uc?export=view&id=185fxDsqSw3PK6x9fPwcBkjKoO4iV5ZFr'),
  ];
  List<Color> cardColor = [Colors.teal, Colors.blueAccent, Colors.blueGrey];
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
        color: whiteColor,
      ),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.transparent,
        drawer: BaseDrawer(),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Stack(
            children: <Widget>[
              Center(
                  child: Column(
                children: const <Widget>[],
              )),
              Positioned(
                left: 10,
                top: 40,
                child: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    scaffoldKey.currentState!.openDrawer();
                  },
                ),
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 120,
                  ),
                  text("துதி பலிகள்",
                      isBold: true,
                      isItalic: true,
                      fontFamily: 'ArimaMadurai',
                      fontSize: 25.0,
                      textColor: darkBlackColor,
                      isCentered: true,
                      isLongText: true),
                  const SizedBox(
                    height: 20,
                  ),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 6,
                            childAspectRatio: 1.2),
                    itemCount: praiseTypeList.length,
                    itemBuilder: (context, index) {
                      var item = praiseTypeList[index];
                      return Column(
                        children: [
                          Card(
                            color: cardColor[index],
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                routePage(routePraises,
                                    arguments: {'praiseTypes': item});
                              },
                              child: SizedBox(
                                height: 150,
                                width: width / 1.2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    text(item.name!,
                                        isBold: true,
                                        isItalic: true,
                                        fontFamily: 'ArimaMadurai',
                                        fontSize: 15.0,
                                        textColor: whiteColor,
                                        isCentered: true,
                                        isLongText: true),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 1,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
