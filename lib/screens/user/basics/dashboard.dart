
import 'package:coolwell_tech/common/custom_widget.dart';
import 'package:coolwell_tech/common/localization/localizations.dart';
import 'package:coolwell_tech/screens/user/service/service.dart';
import 'package:coolwell_tech/screens/user/service/service_details.dart';
import 'package:coolwell_tech/screens/user/service/service_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


import 'notification.dart';

class DashBoard_Screen extends StatefulWidget {
  const DashBoard_Screen({Key? key}) : super(key: key);

  @override
  State<DashBoard_Screen> createState() => _DashBoard_ScreenState();
}

class _DashBoard_ScreenState extends State<DashBoard_Screen> {


  List<String> titleText=["loc_side_cool","loc_side_service","loc_side_history","loc_side_account"];

  List<String> texts = ["Cleaning", "Repair", "Install","Deep clean AC Service"];
  List<String> img_texts = ["assets/images/book_service1.png", "assets/images/book_service2.png", "assets/images/book_service1.png", "assets/images/book_service2.png"];
  ScrollController _scrollController = ScrollController();
  FocusNode searchFocus = FocusNode();
  TextEditingController searchController = TextEditingController();
  int? slideIndex ;
  List<String> bannerList = [];
  bool  repair = false;
  bool  service = true;
  bool  installing = false;
  bool  help = false;
  bool  loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // loading = true;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:Stack(
          children: [
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.24,
                  padding: EdgeInsets.only(left: 40.0,right: 30.0, bottom: 20.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/dashboard_back.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: (){
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Notification_Screen()));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 30.0),
                            child: SvgPicture.asset("assets/images/notification.svg", height: 22.0,),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Text(
                        "Your are in",
                        style: CustomWidget(context: context)
                            .CustomSizedTextStyle(
                            10.0,
                            Theme.of(context).focusColor,
                            FontWeight.w400,
                            'FontRegular'),
                        textAlign: TextAlign.end,
                      ),
                      Text(
                        "Baskar Complex",
                        style: CustomWidget(context: context)
                            .CustomSizedTextStyle(
                            18.0,
                            Theme.of(context).focusColor,
                            FontWeight.w600,
                            'FontRegular'),
                        textAlign: TextAlign.end,
                      ),
                      Text(
                        "Baskar Complex, 600600.",
                        style: CustomWidget(context: context)
                            .CustomSizedTextStyle(
                            14.0,
                            Theme.of(context).focusColor,
                            FontWeight.w800,
                            'FontRegular'),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ),

                Padding(padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 12.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(width: 1.0,color: Theme.of(context).shadowColor,)
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset("assets/images/search.svg", height: 20.0, color: Theme.of(context).shadowColor,),
                      SizedBox(width: 10.0,),
                      Text(
                        AppLocalizations.instance
                            .text("loc_search"),
                        style: CustomWidget(context: context)
                            .CustomSizedTextStyle(
                            14.0,
                            Theme.of(context).shadowColor,
                            FontWeight.w400,
                            'FontRegular'),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ),),

              ],
            ),

            Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.34),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      padding: EdgeInsets.only(left: 20.0),
                      height: 160.0,
                      child:  ListView.builder(
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        controller: _scrollController,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.68,
                                    padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          const Color(0xFF0DD8FF),
                                          const Color(0xFF0FABFF),
                                          const Color(0xFF1457FF),
                                          const Color(0xFF1636FF),
                                          const Color(0xFF0E69C7),
                                        ],
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: [
                                        Flexible(child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                                              decoration: BoxDecoration(
                                                color:  Theme.of(context).hoverColor,
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft: Radius.circular(6.0),
                                                    bottomRight: Radius.circular(6.0)),
                                              ),
                                              child: Text(
                                                "Summer offer",
                                                style: CustomWidget(context: context)
                                                    .CustomSizedTextStyle(
                                                    8.0,
                                                    Theme.of(context).primaryColor,
                                                    FontWeight.w400,
                                                    'FontRegular'),
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20.0,
                                            ),
                                            Text(
                                              "Deep clean AC service at just \$59",
                                              style:
                                              CustomWidget(context: context)
                                                  .CustomSizedTextStyle(
                                                  14.0,
                                                  Theme.of(context)
                                                      .focusColor,
                                                  FontWeight.w800,
                                                  'FontRegular'),
                                            ),
                                            SizedBox(height: 10.0,),
                                            InkWell(
                                              onTap:(){

                                              },
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .hoverColor,
                                                    borderRadius: BorderRadius.circular(5.0)
                                                ),
                                                child: Text(
                                                  "Book now",
                                                  style:
                                                  CustomWidget(context: context)
                                                      .CustomSizedTextStyle(
                                                      8.0,
                                                      Theme.of(context)
                                                          .primaryColor,
                                                      FontWeight.w400,
                                                      'FontRegular'),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),flex: 1,),
                                        SizedBox(width: 5.0,),
                                        Flexible(child: Column(),flex: 1, )
                                      ],
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    ),
                                  ),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Container(width: MediaQuery.of(context).size.width * 0.28,),
                                       Image.asset("assets/images/ac.png",),
                                   ],
                                 )
                                ],
                              ),
                              SizedBox(width: 15.0,)
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.instance
                                .text("loc_our_services"),
                            style: CustomWidget(context: context)
                                .CustomSizedTextStyle(
                                18.0,
                                Theme.of(context).primaryColor,
                                FontWeight.w600,
                                'FontRegular'),
                            textAlign: TextAlign.end,
                          ),
                          SizedBox(height: 20.0,),
                          Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context).splashColor,
                                      blurRadius: 10.0,
                                      offset: Offset(0.0, 0.5)
                                  ),
                                ]
                            ),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(child: InkWell(
                                      onTap: (){
                                        setState(() {
                                          repair = false;
                                          service = true;
                                          installing = false;
                                          help = false;
                                        });
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) =>
                                                Service_Details_Screen()));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5.0),
                                        decoration: service? BoxDecoration(
                                            border: Border.all(width: 1.0,color: Theme.of(context).cardColor,),
                                            borderRadius: BorderRadius.circular(10.0),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Theme.of(context).shadowColor.withOpacity(0.5),
                                                  blurRadius: 15.0,
                                                  offset: Offset(0.0, 0.5)
                                              ),
                                            ]
                                        ) : BoxDecoration(),
                                        child: Container(
                                          height: MediaQuery.of(context).size.height *0.15,
                                          width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage("assets/images/services.png",),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius: BorderRadius.circular(10.0),

                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                                                  decoration: BoxDecoration(
                                                    color:  Theme.of(context).dialogBackgroundColor,
                                                    borderRadius: BorderRadius.only(
                                                        bottomLeft: Radius.circular(6.0),
                                                        bottomRight: Radius.circular(6.0)),
                                                  ),
                                                  child: Text(
                                                    "15% OFF",
                                                    style: CustomWidget(context: context)
                                                        .CustomSizedTextStyle(
                                                        14.0,
                                                        Theme.of(context).focusColor,
                                                        FontWeight.w800,
                                                        'FontRegular'),
                                                    textAlign: TextAlign.end,
                                                  ),
                                                ),
                                                Text(
                                                  "Services",
                                                  style: CustomWidget(context: context)
                                                      .CustomSizedTextStyle(
                                                      14.0,
                                                      Theme.of(context).focusColor,
                                                      FontWeight.w600,
                                                      'FontRegular'),
                                                  textAlign: TextAlign.end,
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ), flex: 1,),
                                    SizedBox(width: 15.0,),
                                    Flexible(child: InkWell(
                                      onTap: (){
                                        setState(() {
                                          repair = true;
                                          service = false;
                                          installing = false;
                                          help = false;
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5.0),
                                        decoration: repair ? BoxDecoration(
                                            border: Border.all(width: 1.0,color: Theme.of(context).cardColor,),
                                            borderRadius: BorderRadius.circular(10.0),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Theme.of(context).shadowColor.withOpacity(0.5),
                                                  blurRadius: 15.0,
                                                  offset: Offset(0.0, 0.5)
                                              ),
                                            ]
                                        ) : BoxDecoration(),
                                        child: Container(
                                          height: MediaQuery.of(context).size.height *0.15,
                                          width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage("assets/images/repair_1.png",),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius: BorderRadius.circular(10.0),

                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                                                  decoration: BoxDecoration(
                                                    color:  Theme.of(context).dialogBackgroundColor,
                                                    borderRadius: BorderRadius.only(
                                                        bottomLeft: Radius.circular(6.0),
                                                        bottomRight: Radius.circular(6.0)),
                                                  ),
                                                  child: Text(
                                                    "47% OFF",
                                                    style: CustomWidget(context: context)
                                                        .CustomSizedTextStyle(
                                                        14.0,
                                                        Theme.of(context).focusColor,
                                                        FontWeight.w800,
                                                        'FontRegular'),
                                                    textAlign: TextAlign.end,
                                                  ),
                                                ),
                                                Text(
                                                  "Repair",
                                                  style: CustomWidget(context: context)
                                                      .CustomSizedTextStyle(
                                                      14.0,
                                                      Theme.of(context).focusColor,
                                                      FontWeight.w600,
                                                      'FontRegular'),
                                                  textAlign: TextAlign.end,
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ), flex: 1,)
                                  ],
                                ),
                                SizedBox(height: 10.0,),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(child: InkWell(
                                      onTap: (){
                                        setState(() {
                                          repair = false;
                                          service = false;
                                          installing = true;
                                          help = false;
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5.0),
                                        decoration: installing ?BoxDecoration(
                                            border: Border.all(width: 1.0,color: Theme.of(context).cardColor,),
                                            borderRadius: BorderRadius.circular(10.0),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Theme.of(context).shadowColor.withOpacity(0.5),
                                                  blurRadius: 15.0,
                                                  offset: Offset(0.0, 0.5)
                                              ),
                                            ]
                                        ) : BoxDecoration(),
                                        child: Container(
                                          height: MediaQuery.of(context).size.height *0.15,
                                          width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage("assets/images/install_1.png",),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius: BorderRadius.circular(10.0),

                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                                                  decoration: BoxDecoration(
                                                    color:  Theme.of(context).dialogBackgroundColor,
                                                    borderRadius: BorderRadius.only(
                                                        bottomLeft: Radius.circular(6.0),
                                                        bottomRight: Radius.circular(6.0)),
                                                  ),
                                                  child: Text(
                                                    "15% OFF",
                                                    style: CustomWidget(context: context)
                                                        .CustomSizedTextStyle(
                                                        14.0,
                                                        Theme.of(context).focusColor,
                                                        FontWeight.w800,
                                                        'FontRegular'),
                                                    textAlign: TextAlign.end,
                                                  ),
                                                ),
                                                Text(
                                                  "Installation",
                                                  style: CustomWidget(context: context)
                                                      .CustomSizedTextStyle(
                                                      14.0,
                                                      Theme.of(context).focusColor,
                                                      FontWeight.w600,
                                                      'FontRegular'),
                                                  textAlign: TextAlign.end,
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ), flex: 1,),
                                    SizedBox(width: 15.0,),
                                    Flexible(child: InkWell(
                                      onTap: (){
                                        setState(() {
                                          repair = false;
                                          service = false;
                                          installing = false;
                                          help = true;
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5.0),
                                        decoration: help ?BoxDecoration(
                                            border: Border.all(width: 1.0,color: Theme.of(context).cardColor,),
                                            borderRadius: BorderRadius.circular(10.0),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Theme.of(context).shadowColor.withOpacity(0.5),
                                                  blurRadius: 15.0,
                                                  offset: Offset(0.0, 0.5)
                                              ),
                                            ]
                                        ) : BoxDecoration(),
                                        child: Container(
                                          height: MediaQuery.of(context).size.height *0.15,
                                          width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage("assets/images/help_1.png",),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius: BorderRadius.circular(10.0),

                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                                                  // decoration: BoxDecoration(
                                                  //   color:  Theme.of(context).dialogBackgroundColor,
                                                  //   borderRadius: BorderRadius.only(
                                                  //       bottomLeft: Radius.circular(6.0),
                                                  //       bottomRight: Radius.circular(6.0)),
                                                  // ),
                                                  child: Text(
                                                    "",
                                                    style: CustomWidget(context: context)
                                                        .CustomSizedTextStyle(
                                                        14.0,
                                                        Theme.of(context).focusColor,
                                                        FontWeight.w800,
                                                        'FontRegular'),
                                                    textAlign: TextAlign.end,
                                                  ),
                                                ),
                                                Text(
                                                  "Help Desk ",
                                                  style: CustomWidget(context: context)
                                                      .CustomSizedTextStyle(
                                                      14.0,
                                                      Theme.of(context).focusColor,
                                                      FontWeight.w600,
                                                      'FontRegular'),
                                                  textAlign: TextAlign.end,
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ), flex: 1,)
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    Container(
                      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFF0DD8FF),
                            const Color(0xFF0FABFF),
                            const Color(0xFF1457FF),
                            const Color(0xFF1636FF),
                            const Color(0xFF0E69C7),
                          ],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Stack(
                              children: [
                                Container(
                                  margin:EdgeInsets.only(top: 30.0),
                                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.0),
                                    color: Theme.of(context).cardColor,
                                  ),
                                  child:  Text(
                                    AppLocalizations.instance
                                        .text("loc_book"),
                                    style: CustomWidget(context: context)
                                        .CustomSizedTextStyle(
                                        12.0,
                                        Theme.of(context).focusColor,
                                        FontWeight.w400,
                                        'FontRegular'),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(height: 15.0,),
                                Container(
                                  margin:EdgeInsets.only(top: 80.0),
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.asset("assets/images/repair_2.png", fit: BoxFit.cover, height: 200.0,),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 15.0,top: 40.0),
                                    child: Image.asset("assets/images/repair_logo.png",),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15.0,)

                        ],
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Theme.of(context).splashColor,
                                blurRadius: 20.0,
                                offset: Offset(0.0, 0.5)
                            ),
                          ]
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20.0),
                            padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.instance
                                      .text("loc_recent_book"),
                                  style: CustomWidget(context: context)
                                      .CustomSizedTextStyle(
                                      18.0,
                                      Theme.of(context).primaryColor,
                                      FontWeight.w600,
                                      'FontRegular'),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 15.0,),

                                Container(
                                  height: 170.0,
                                  child:  ListView.builder(
                                    itemCount: texts.length,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    controller: _scrollController,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Image.asset(img_texts[index].toString(),),
                                                SizedBox(height: 15.0,),
                                                Container(
                                                  width: MediaQuery.of(context).size.width * 0.25,
                                                  child: Text(
                                                    texts[index].toString(),
                                                    style: CustomWidget(context: context)
                                                        .CustomSizedTextStyle(
                                                        14.0,
                                                        Theme.of(context).primaryColor,
                                                        FontWeight.w500,
                                                        'FontRegular'),
                                                    textAlign: TextAlign.start,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                SizedBox(height: 10.0,),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.star,
                                                      size: 10.0,
                                                      color: Theme.of(context).cardColor,
                                                    ),
                                                    SizedBox(width: 3.0,),
                                                    Text(
                                                      "4.81 (1.2M)",
                                                      style: CustomWidget(context: context)
                                                          .CustomSizedTextStyle(
                                                          10.0,
                                                          Theme.of(context).primaryColor,
                                                          FontWeight.w400,
                                                          'FontRegular'),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 3.0,),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "₹499",
                                                      style: CustomWidget(context: context)
                                                          .CustomSizedTextStyle(
                                                          10.0,
                                                          Theme.of(context).primaryColor,
                                                          FontWeight.w400,
                                                          'FontRegular'),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    SizedBox(width: 10.0,),
                                                    Text(
                                                      "₹649",
                                                      style: TextStyle(
                                                          fontSize: 8.0,
                                                          decoration: TextDecoration.lineThrough,
                                                          fontWeight: FontWeight.w400,
                                                          color: Theme.of(context).shadowColor,
                                                          fontStyle: FontStyle.normal
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10.0,),

                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 20.0,)
                                        ],
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ),
    );
  }

}
