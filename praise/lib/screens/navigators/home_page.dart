// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:oneclick/main.dart';
// import 'package:oneclick/models/services/getall_services.dart';
// import 'package:oneclick/models/services/services_categories.dart';
// import 'package:oneclick/models/users/slider_image.dart';
// import 'package:oneclick/pages/authentication/login.dart';
// import 'package:oneclick/pages/authentication/register.dart';
// import 'package:oneclick/pages/navigators/bottom_bar.dart';
// import 'package:oneclick/pages/navigators/search_page.dart';
// import 'package:oneclick/pages/profiles/profile_settings.dart';
// import 'package:oneclick/pages/request/send_request.dart';
// import 'package:oneclick/pages/services_list/service_category_grid_widget.dart';
// import 'package:oneclick/pages/services_list/service_category_list.dart';
// import 'package:oneclick/pages/services_list/service_list_widget.dart';
// import 'package:oneclick/repository/service_repository.dart';
// import 'package:oneclick/repository/user_repository.dart';
// import 'package:oneclick/utils/common_widgets/carousel_slider.dart';
// import 'package:oneclick/utils/common_widgets/colors.dart';
// import 'package:oneclick/utils/common_widgets/constants.dart';
// import 'package:oneclick/utils/common_widgets/loading_widget.dart';
// import 'package:oneclick/utils/functions/common_functions.dart';
// import 'package:oneclick/utils/functions/validator.dart';
// import 'package:shimmer/shimmer.dart';

// import 'notification_page.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<ServicesCategories> servicesCategoryNames = [];
//   List<ServicesCategories> servicesCategoryList = [];
//   List<ServicesCategories> getAllMostPopularList = [];
//   List<GetAllServiceListDetails> mostPopularListsDetails = [];
//   List<SliderImage> imageList = [];
//   final validator = Validator();
//   CommonFunctions comFun = CommonFunctions();
//   int colorSync = 0;
//   bool enableVehicle = false;
//   bool isLoading = false;
//   bool isPasswordNotMatch = false;
//   bool isLoadingImage = false;
//   LoadingAlertDialog alertLoading = LoadingAlertDialog();
//   bool isLock = false;
//   double width = 0.0;
//   double height = 0.0;
//   int pageNo = 1;
//   int countPerPage = 7;
//   int totalCount = 0;
//   DateTime now = DateTime.now();
//   String greeting = "";
//   int hours = 0;

//   timeWishes() {
//     hours = now.hour;
//     if (hours >= 1 && hours <= 12) {
//       greeting = "Good Morning";
//     } else if (hours >= 12 && hours <= 16) {
//       greeting = "Good Afternoon";
//     } else if (hours >= 16 && hours <= 21) {
//       greeting = "Good Evening";
//     } else if (hours >= 21 && hours <= 24) {
//       greeting = "Good Night";
//     }
//   }

//   String convertDate(originalDate) {
//     var date = DateFormat("dd-MM-yyyy    KK:mm:ss a")
//         .format(DateTime.parse("$originalDate"));
//     return date;
//   }

//   @override
//   initState() {
//     initPageDetails();
//     super.initState();
//   }

//   initPageDetails() {
//     getSliderImage();
//     getAllServiceCategory(pageNo, countPerPage);
//     getAllMostPopularServiceCategory();
//     getAllMostPopularServices(0, 1, 7);
//     timeWishes();
//   }

//   getAllServiceCategory(int pageNo, int countPerPage) {
//     getAllServiceCategories(page: pageNo, pageCount: countPerPage)
//         .then((value) {
//       if (value.status == 1) {
//         totalCount = value.count!;
//         setState(() {
//           if (servicesCategoryList.isNotEmpty) {
//             servicesCategoryList.removeLast();
//           }
//           servicesCategoryList.addAll(value.result!);
//           servicesCategoryList.add(ServicesCategories(
//             serviceCatName: "More",
//           ));
//         });
//       }
//     });
//   }

//   getSliderImage() {
//     try {
//       setState(() {
//         isLoadingImage = true;
//       });
//       getSliderImageApi().then((value) {
//         if (value.status == 1) {
//           setState(() {
//             imageList = value.result!;
//           });
//         }
//         setState(() {
//           isLoadingImage = false;
//         });
//       });
//     } catch (ex) {
//       setState(() {
//         isLoadingImage = false;
//       });
//     }
//   }

//   onTapForMore() {
//     pageNo++;
//     getAllServiceCategory(pageNo, countPerPage);
//   }

//   getAllMostPopularServiceCategory() {
//     getAllPopularServiceCategories().then((value) {
//       if (value.status == 1) {
//         setState(() {
//           getAllMostPopularList.add(
//               ServicesCategories(id: 0, serviceCatName: "All", isActive: true));
//           getAllMostPopularList.addAll(value.result!);
//         });
//       }
//     });
//   }

//   getAllMostPopularServices(int? categoryID, int? pageNo, int? countPerPage) {
//     setState(() {
//       isLoading = true;
//       mostPopularListsDetails.clear();
//     });
//     getAllPopularServices(categoryID, pageNo, countPerPage).then((value) {
//       if (value.status == 1) {
//         setState(() {
//           mostPopularListsDetails = value.result!;
//         });
//       } else {
//         toast("No services");
//       }
//       setState(() {
//         isLoading = false;
//       });
//     });
//   }

//   Future<void> pageRefresh() async {
//     setState(() {
//       servicesCategoryNames.clear();
//       servicesCategoryList.clear();
//       getAllMostPopularList.clear();
//       mostPopularListsDetails.clear();
//       imageList.clear();

//       comFun = CommonFunctions();
//       colorSync = 0;
//       enableVehicle = false;
//       isLoading = false;
//       isPasswordNotMatch = false;
//       isLock = false;
//       pageNo = 1;
//       countPerPage = 7;
//       totalCount = 0;
//       initPageDetails();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     width = MediaQuery.of(context).size.width;
//     height = MediaQuery.of(context).size.height;

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 2),
//       decoration: const BoxDecoration(
//         color: whiteColor,
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: RefreshIndicator(
//           onRefresh: pageRefresh,
//           child: SingleChildScrollView(
//             physics: const AlwaysScrollableScrollPhysics(),
//             child: Column(
//               // mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 Row(
//                   children: [
//                     SizedBox(
//                       width: width / 12,
//                     ),
//                     profile(),
//                     SizedBox(
//                       width: width / 40,
//                     ),
//                     Expanded(
//                       child: ListTile(
//                         title: Text(
//                           greeting,
//                           style: const TextStyle(
//                               color: liteDimGreyColor,
//                               fontSize: 17,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         subtitle: MyApp.user!.token == null
//                             ? const Text(
//                                 "User",
//                                 style: TextStyle(
//                                     color: primaryBlackColor,
//                                     fontSize: 22,
//                                     fontWeight: FontWeight.bold),
//                               )
//                             : Row(
//                                 children: [
//                                   Text(
//                                     MyApp.user!.firstName != null
//                                         ? "${MyApp.user!.firstName}"
//                                         : "",
//                                     style: const TextStyle(
//                                         color: darkBlackColor,
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   const SizedBox(
//                                     width: 4,
//                                   ),
//                                   Text(
//                                     MyApp.user!.lastName != null
//                                         ? "${MyApp.user!.lastName}"
//                                         : "",
//                                     style: const TextStyle(
//                                         color: darkBlackColor,
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               ),
//                       ),
//                     ),
//                     MyApp.user!.token != null
//                         ? IconButton(
//                             onPressed: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           const NotificationPage()));
//                             },
//                             icon: const Icon(
//                                 Icons.notifications_active_outlined,
//                                 size: 30,
//                                 color: liteDimGreyColor),
//                           )
//                         : Container(),
//                     const SizedBox(
//                       width: 11,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 searchBox(),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 viewRequestButtons(),
//                 isLoadingImage
//                     ? Shimmer.fromColors(
//                         baseColor: Colors.grey.shade400,
//                         highlightColor: Colors.grey.shade200,
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(10.0),
//                           child: Container(
//                             height: 200,
//                             width: width / 1,
//                             color: Colors.grey,
//                           ), // Container
//                         ), // ClipRRect
//                       )
//                     : CarouselSliderListWidget(imageList: imageList),
//                 servicesPopularList(),
//                 SizedBox(
//                   height: height / 50,
//                 ),
//                 Row(
//                   children: [
//                     SizedBox(
//                       width: width / 25,
//                     ),
//                     SizedBox(
//                       width: width / 1.1,
//                       child: const Divider(
//                         color: Colors.grey,
//                         height: 4.0,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: height / 30,
//                 ),
//                 popularWorkList(),
//                 mostPopularServicesDetails(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   searchBox() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//         children: [
//           InkWell(
//             onTap: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => SearchPage()));
//             },
//             child: Container(
//                 height: 47,
//                 width: width / 1.1,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   color: dimGreyColor,
//                 ),
//                 alignment: Alignment.centerLeft,
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       width: width / 22,
//                     ),
//                     const Icon(
//                       Icons.search,
//                       size: 27,
//                       color: liteDimGreyColor,
//                     ),
//                     SizedBox(
//                       width: width / 23,
//                     ),
//                     const Text(
//                       'Search',
//                       textAlign: TextAlign.start,
//                       style: TextStyle(color: liteDimGreyColor, fontSize: 22),
//                     ),
//                   ],
//                 )),
//           ),
//         ],
//       ),
//     );
//   }

//   viewRequestButtons() {
//     return Column(children: [
//       Center(
//         child: InkWell(
//           onTap: () {
//             request(context);
//             FocusScope.of(context).unfocus();
//           },
//           child: Container(
//             height: height / 17,
//             width: width / 1.1,
//             decoration: BoxDecoration(
//               border: Border.all(color: primaryBlue),
//               borderRadius: BorderRadius.circular(20),
//               color: primaryBlue,
//             ),
//             alignment: Alignment.center,
//             child: const Text(
//               'Create Request',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   color: primaryWhiteColor,
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold),
//             ),
//           ),
//         ),
//       ),
//       SizedBox(
//         height: height / 45,
//       ),
//       InkWell(
//         onTap: () {
//           viewRequest();
//           FocusScope.of(context).unfocus();
//         },
//         child: Container(
//           height: height / 20,
//           width: width / 1.1,
//           decoration: BoxDecoration(
//               border: Border.all(color: primaryBlue),
//               boxShadow: const [
//                 BoxShadow(color: primaryBlue, spreadRadius: 1),
//               ],
//               color: liteGrayColor,
//               borderRadius: BorderRadius.circular((22))),
//           alignment: Alignment.center,
//           child: const Text(
//             'View Request',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//                 color: primaryBlue, fontSize: 24, fontWeight: FontWeight.w400),
//           ),
//         ),
//       ),
//       SizedBox(
//         height: height / 30,
//       ),
//     ]);
//   }

//   servicesPopularList() {
//     return Column(
//       children: [
//         Container(
//           margin: const EdgeInsets.symmetric(horizontal: 10),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text("Services",
//                   style: TextStyle(
//                       color: darkBlackColor,
//                       fontSize: 19,
//                       fontWeight: FontWeight.bold),
//                   textAlign: TextAlign.start),
//               InkWell(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const ServiceCategoryList()));
//                 },
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 10.0, vertical: 3.0),
//                   child: const Text("See All",
//                       style: TextStyle(
//                           color: primaryBlue,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w400),
//                       textAlign: TextAlign.end),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         ServicesGridViewWidget(
//           servicesCategoryLists: servicesCategoryList,
//           onTapForMore: onTapForMore,
//         ),
//       ],
//     );
//   }

//   popularWorkList() {
//     return Column(
//       children: [
//         Container(
//           margin: const EdgeInsets.symmetric(horizontal: 10),
//           // color: gray4,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             // color: grayLinear,
//           ),

//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text("Most Popular Services",
//                   style: TextStyle(
//                       color: darkBlackColor,
//                       fontSize: 19,
//                       fontWeight: FontWeight.bold),
//                   textAlign: TextAlign.start),
//               InkWell(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const ServiceCategoryList()));
//                 },
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 10.0, vertical: 3.0),
//                   child: const Text("See All",
//                       style: TextStyle(
//                           color: primaryBlue,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w400),
//                       textAlign: TextAlign.end),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: height / 55,
//         ),
//         SizedBox(
//           height: height / 13,
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: [
//                 const SizedBox(
//                   width: 15,
//                 ),
//                 for (int i = 0; i < getAllMostPopularList.length; i++)
//                   GestureDetector(
//                     onTap: () {
//                       if (!getAllMostPopularList[i].isActive) {
//                         setState(() {
//                           getAllMostPopularList[i].isActive = true;
//                           getAllMostPopularServices(
//                               getAllMostPopularList[i].id, 1, 7);
//                         });
//                       }
//                       for (int j = 0; j < getAllMostPopularList.length; j++) {
//                         if (i != j) {
//                           if (getAllMostPopularList[j].isActive) {
//                             setState(() {
//                               getAllMostPopularList[j].isActive = false;
//                             });
//                           }
//                         }
//                       }
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.only(left: 5.0, right: 5.0),
//                       padding: const EdgeInsets.only(left: 20.0, right: 25.0),
//                       height: 38,
//                       decoration: BoxDecoration(
//                           boxShadow: const [
//                             BoxShadow(color: primaryBlue, spreadRadius: 1),
//                           ],
//                           color: getAllMostPopularList[i].isActive
//                               ? primaryBlue
//                               : liteGrayColor,
//                           border: Border.all(color: primaryBlue),
//                           borderRadius: BorderRadius.circular((20))),
//                       alignment: Alignment.center,
//                       child: Center(
//                         child: Text(
//                           getAllMostPopularList[i].serviceCatName.toString(),
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                               color: getAllMostPopularList[i].isActive
//                                   ? liteGrayColor
//                                   : primaryBlue,
//                               fontSize: textSizeMedium),
//                         ),
//                       ),
//                     ),
//                   ),
//                 const SizedBox(
//                   width: 5,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   mostPopularServicesDetails() {
//     return isLoading
//         ? SizedBox(
//             height: height / 1.8,
//             width: width / 1.1,
//             child: const Center(
//               child: SizedBox(
//                 height: 40,
//                 width: 40,
//                 child: CircularProgressIndicator(),
//               ),
//             ),
//           )
//         : SizedBox(
//             child: ServicesListViewWidget(
//               worksListsDetails: mostPopularListsDetails,
//             ),
//           );
//   }

//   viewRequest() async {
//     selectedIndex = 1;
//     if (MyApp.user!.token == null) {
//       Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
//     } else {
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (context) => BottomBar()));
//     }
//   }

//   bottomSheet() {
//     double width = MediaQuery.of(context).size.width;
//     showModalBottomSheet(
//         context: context,
//         shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(top: Radius.circular(36))),
//         builder: (context) {
//           return Stack(
//             children: [
//               SizedBox(
//                 height: 230,
//                 child: Column(
//                   children: [
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: const [
//                         Text(
//                           "Please Sign in or Register ?",
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     const Divider(
//                       indent: 10,
//                       endIndent: 10,
//                       thickness: 1.5,
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Row(
//                       children: [
//                         SizedBox(width: width / 7),
//                         SizedBox(
//                           width: width / 3,
//                           child: InkWell(
//                             onTap: () {
//                               Navigator.pop(context);
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => Login()),
//                               );
//                             },
//                             child: Container(
//                               padding: const EdgeInsets.all(fixPadding * 1.5),
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                 color: liteSkyBlueColor,
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               child: Text(
//                                 'Sign In'.toUpperCase(),
//                                 style: TextStyle(
//                                     fontSize: 17,
//                                     color: skyBlueColor,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 30,
//                         ),
//                         SizedBox(
//                           width: width / 3,
//                           child: InkWell(
//                             onTap: () {
//                               Navigator.pop(context);
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => Register()),
//                               );
//                             },
//                             child: Container(
//                               padding: const EdgeInsets.all(fixPadding * 1.5),
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                 color: skyBlueColor,
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               child: Text(
//                                 'Register'.toUpperCase(),
//                                 style: white16BoldTextStyle,
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         });
//   }

//   profile() {
//     return InkWell(
//       onTap: () {
//         if (MyApp.user!.token == null) {
//           bottomSheet();
//         } else {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => const ProfileSettings()));
//           // logoutDialog();
//         }
//       },
//       child: const Image(
//         image: AssetImage("assets/image/profileicon.png"),
//         height: 30,
//       ),
//     );
//   }

//   request(BuildContext context) async {
//     if (!isLock) {
//       isLock = true;
//       // alertLoading.onLoading(context);
//       if (MyApp.user!.token == null) {
//         // alertLoading.onStopping();
//         Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => SendRequestPage()))
//             .then((value) {
//           setState(() {
//             MyApp.user = MyApp.user;
//           });
//         });
//       } else {
//         Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => SendRequestPage()))
//             .then((value) {
//           setState(() {
//             MyApp.user = MyApp.user;
//           });
//         });
//       }
//       isLock = false;
//     }
//   }
// }
