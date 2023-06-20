import 'package:coolwell_tech/common/model/get_profile_details_model.dart';
import 'package:coolwell_tech/screens/technician/tech_orders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/custom_widget.dart';
import '../../common/dotted_line_widget.dart';
import '../../common/localization/localizations.dart';
import '../../common/model/api_utils.dart';
import '../../common/model/get_assigned_job_list_model.dart';
import '../../common/otp_fields/otp_field_custom.dart';
import '../../common/otp_fields/style.dart';
import '../../common/ticket_design.dart';
import '../user/basics/notification.dart';

class Tech_DashBoard_Screen extends StatefulWidget {
  const Tech_DashBoard_Screen({Key? key}) : super(key: key);

  @override
  State<Tech_DashBoard_Screen> createState() => _Tech_DashBoard_ScreenState();
}

class _Tech_DashBoard_ScreenState extends State<Tech_DashBoard_Screen> {

  ScrollController _scrollController = ScrollController();
  ScrollController _scroll = ScrollController();
  bool loading = false;
  bool otp = false;
  String pinValue="";
  APIUtils apiUtils = APIUtils();
  var snackBar;
  String userName ="";
  String name ="";
  GetProfileResult? details;
  List<GetAssignedJobsResult> orderList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = true;
    profile();
    getData();
    serviceDetails();
  }

  getData()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    setState(() {
      name = preferences.getString("name").toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.24,
                  padding: EdgeInsets.only(left: 40.0,right: 30.0, bottom: 20.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/tech/tech_dash_back.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: (){
                              // Navigator.of(context).push(
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             Notification_Screen()));
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 10.0),
                              child: SvgPicture.asset("assets/tech/chat.svg", height: 22.0,),
                            ),
                          ),
                          InkWell(
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
                          )
                        ],
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Text(
                        "Hi,",
                        style: CustomWidget(context: context)
                            .CustomSizedTextStyle(
                            14.0,
                            Theme.of(context).focusColor,
                            FontWeight.w600,
                            'FontRegular'),
                        textAlign: TextAlign.end,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        // "Vinoth Kumar",
                        userName.toString(),
                        style: CustomWidget(context: context)
                            .CustomSizedTextStyle(
                            20.0,
                            Theme.of(context).focusColor,
                            FontWeight.w600,
                            'FontRegular'),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ),
                // Padding(padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),child: Container(
                //   width: MediaQuery.of(context).size.width,
                //   padding: EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 12.0),
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10.0),
                //       border: Border.all(width: 1.0,color: Theme.of(context).shadowColor,)
                //   ),
                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       SvgPicture.asset("assets/images/search.svg", height: 20.0, color: Theme.of(context).shadowColor,),
                //       SizedBox(width: 10.0,),
                //       Text(
                //         AppLocalizations.instance
                //             .text("loc_search"),
                //         style: CustomWidget(context: context)
                //             .CustomSizedTextStyle(
                //             14.0,
                //             Theme.of(context).shadowColor,
                //             FontWeight.w400,
                //             'FontRegular'),
                //         textAlign: TextAlign.end,
                //       ),
                //     ],
                //   ),
                // ),),
              ],
            ),

            Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.26),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                   Container(
                     padding: EdgeInsets.only(left: 20.0, right: 20.0),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         Text(
                           AppLocalizations.instance
                               .text("loc_let_serv"),
                           style: CustomWidget(context: context)
                               .CustomSizedTextStyle(
                               18.0,
                               Theme.of(context).primaryColor,
                               FontWeight.w600,
                               'FontRegular'),
                           textAlign: TextAlign.start,
                         ),
                         const SizedBox(height: 15.0,),
                         Container(
                           width: MediaQuery.of(context).size.width,
                           height: MediaQuery.of(context).size.height * 0.2,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(10.0),
                           // color: Theme.of(context).primaryColor,
                           ),
                           child: Row(
                             children: [
                               Flexible(child: Container(
                                 decoration: BoxDecoration(
                                   // borderRadius: BorderRadius.only(
                                   //   topLeft: Radius.circular(10.0),
                                   //   bottomLeft: Radius.circular(10.0),
                                   // ),
                                   image: DecorationImage(
                                     image: AssetImage("assets/images/cleaning.png"),
                                     fit: BoxFit.fill,
                                   ),
                                 ),
                                 // child: Image.asset("assets/images/cleaning.png",),
                               ),flex: 1,),
                               Flexible(child: Container(
                                 padding: EdgeInsets.only(left: 10.0),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                   children: [
                                     Text(
                                       AppLocalizations.instance
                                           .text("loc_dash_tech_txt1"),
                                       style: CustomWidget(context: context)
                                           .CustomSizedTextStyle(
                                           18.0,
                                           Theme.of(context).primaryColor,
                                           FontWeight.w600,
                                           'FontRegular'),
                                       textAlign: TextAlign.start,
                                     ),
                                     InkWell(
                                       onTap:(){
                                         Navigator.of(context).push(
                                             MaterialPageRoute(
                                                 builder: (context) =>
                                                     Tech_Orders_Screen()));
                                       },
                                       child: Container(
                                         padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
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
                                           crossAxisAlignment: CrossAxisAlignment.center,
                                           mainAxisAlignment: MainAxisAlignment.center,
                                           children: [
                                             SvgPicture.asset("assets/tech/assign.svg",color: Theme.of(context).focusColor, height: 15.0,),
                                             SizedBox(width: 5.0,),
                                             Text(
                                               AppLocalizations.instance
                                                   .text("loc_assign_order"),
                                               style: CustomWidget(context: context)
                                                   .CustomSizedTextStyle(
                                                   14.0,
                                                   Theme.of(context).focusColor,
                                                   FontWeight.w500,
                                                   'FontRegular'),
                                               textAlign: TextAlign.center,
                                             ),
                                           ],
                                         ),
                                       ),
                                     )
                                   ],
                                 ),
                               ), flex: 1,)
                             ],
                           ),
                         )
                       ],
                     ),
                   ),
                    const SizedBox(height: 15.0,),

                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height *0.35,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Theme.of(context).splashColor,
                                    blurRadius: 15.0,
                                    offset: Offset(0.0, 0.8)
                                ),
                              ]
                          ),
                          child: Row(
                            children: [
                              Flexible(child: Container(
                                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).focusColor,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Flexible(child: Container(
                                          decoration: BoxDecoration(
                                              color: Theme.of(context).shadowColor.withOpacity(0.5),
                                              shape: BoxShape.circle
                                          ),
                                          child: SvgPicture.asset("assets/images/tools.svg", height: 35.0, color: Theme.of(context).cardColor,),
                                        ),flex: 1,),
                                        const SizedBox(width: 15.0,),
                                        Flexible(child: Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                          AppLocalizations.instance
                                              .text("loc_resend_completed_serv"),
                                                style: CustomWidget(context: context)
                                                    .CustomSizedTextStyle(
                                                    18.0,
                                                    Theme.of(context).primaryColor,
                                                    FontWeight.w600,
                                                    'FontRegular'),
                                                textAlign: TextAlign.start,
                                              ),
                                              const SizedBox(height: 10.0,),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Flexible(child: Container(
                                                    decoration: BoxDecoration(
                                                      // color: Theme.of(context).shadowColor.withOpacity(0.5),
                                                        borderRadius: BorderRadius.circular(10.0)
                                                    ),
                                                    child: Image.asset("assets/images/notify_serv.png", height: 35.0,),
                                                  ),flex: 1,),
                                                  const SizedBox(width: 15.0,),
                                                  Flexible(child: Container(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                    AppLocalizations.instance
                                                        .text("loc_clean"),
                                                          style: CustomWidget(context: context)
                                                              .CustomSizedTextStyle(
                                                              14.0,
                                                              Theme.of(context).primaryColor,
                                                              FontWeight.w600,
                                                              'FontRegular'),
                                                          textAlign: TextAlign.start,
                                                        ),
                                                        const SizedBox(height: 5.0,),
                                                        Container(
                                                          child:  Text(
                                                            "Lorem ipsum dolor sit amet consectetur. Ac purus cum lectus odio turpis felis arcu non odio. Nunc vestibulum integer id convallis facilisi nulla sed nisl. Purus amet penatibus dui a a felis in in.",
                                                            style: CustomWidget(context: context)
                                                                .CustomSizedTextStyle(
                                                                10.0,
                                                                Theme.of(context).primaryColor,
                                                                FontWeight.w400,
                                                                'FontRegular'),
                                                            textAlign: TextAlign.start,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ), flex: 4,)
                                                ],
                                              )
                                            ],
                                          ),
                                        ),flex: 4,)
                                      ],
                                    ),
                                    const SizedBox(height: 8.0,),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Flexible(child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppLocalizations.instance
                                                  .text("loc_you_got"),
                                              style: CustomWidget(context: context)
                                                  .CustomSizedTextStyle(
                                                  9.0,
                                                  Theme.of(context).primaryColor,
                                                  FontWeight.w600,
                                                  'FontRegular'),
                                              textAlign: TextAlign.start,
                                            ),
                                            const SizedBox(height: 10.0,),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Flexible(child: Column(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.all(5.0),
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          border: Border.all(width: 1.0, color: Theme.of(context).shadowColor.withOpacity(0.5),)
                                                      ),
                                                      child: SvgPicture.asset("assets/images/star.svg", height: 15.0,),
                                                    ),
                                                    const SizedBox(height: 5.0,),
                                                    Text(
                                                      "1",
                                                      style: CustomWidget(context: context)
                                                          .CustomSizedTextStyle(
                                                          9.0,
                                                          Theme.of(context).primaryColor,
                                                          FontWeight.w600,
                                                          'FontRegular'),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ],
                                                )),

                                                Flexible(child: Column(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.all(5.0),
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          border: Border.all(width: 1.0, color: Theme.of(context).shadowColor.withOpacity(0.5),)
                                                      ),
                                                      child: SvgPicture.asset("assets/images/star.svg", height: 15.0,),
                                                    ),
                                                    const SizedBox(height: 5.0,),
                                                    Text(
                                                      "2",
                                                      style: CustomWidget(context: context)
                                                          .CustomSizedTextStyle(
                                                          9.0,
                                                          Theme.of(context).primaryColor,
                                                          FontWeight.w600,
                                                          'FontRegular'),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ],
                                                )),
                                                Flexible(child: Column(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.all(5.0),
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          border: Border.all(width: 1.0, color: Theme.of(context).shadowColor.withOpacity(0.5),)
                                                      ),
                                                      child: SvgPicture.asset("assets/images/star.svg", height: 15.0,),
                                                    ),
                                                    const SizedBox(height: 5.0,),
                                                    Text(
                                                      "3",
                                                      style: CustomWidget(context: context)
                                                          .CustomSizedTextStyle(
                                                          9.0,
                                                          Theme.of(context).primaryColor,
                                                          FontWeight.w600,
                                                          'FontRegular'),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ],
                                                )),
                                                Flexible(child: Column(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.all(5.0),
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(width: 1.0, color: Theme.of(context).cardColor,),
                                                        color: Theme.of(context).cardColor,
                                                      ),
                                                      child: SvgPicture.asset("assets/images/star.svg", height: 15.0,color: Theme.of(context).focusColor),
                                                    ),
                                                    const SizedBox(height: 5.0,),
                                                    Text(
                                                      "4",
                                                      style: CustomWidget(context: context)
                                                          .CustomSizedTextStyle(
                                                          9.0,
                                                          Theme.of(context).primaryColor,
                                                          FontWeight.w600,
                                                          'FontRegular'),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ],
                                                )),
                                                Flexible(child: Column(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.all(5.0),
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          border: Border.all(width: 1.0, color: Theme.of(context).shadowColor.withOpacity(0.5),)
                                                      ),
                                                      child: SvgPicture.asset("assets/images/star.svg", height: 15.0,),
                                                    ),
                                                    const SizedBox(height: 5.0,),
                                                    Text(
                                                      "5",
                                                      style: CustomWidget(context: context)
                                                          .CustomSizedTextStyle(
                                                          9.0,
                                                          Theme.of(context).primaryColor,
                                                          FontWeight.w600,
                                                          'FontRegular'),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ],
                                                )),
                                              ],
                                            )
                                          ],
                                        ), flex: 1,),
                                        Flexible(child: Center(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const SizedBox(height: 25.0,),
                                              Container(
                                                padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(30.0),
                                                    color: Colors.transparent,
                                                    border: Border.all(width: 1.0, color: Theme.of(context).shadowColor.withOpacity(0.2),)
                                                ),
                                                child: Text(
                                                  AppLocalizations.instance.text("loc_share_feedback"),
                                                  style: CustomWidget(context: context)
                                                      .CustomSizedTextStyle(
                                                      9.0,
                                                      Theme.of(context).shadowColor,
                                                      FontWeight.w600,
                                                      'FontRegular'),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              const SizedBox(height: 5.0,),
                                              Text(
                                                AppLocalizations.instance
                                                    .text("loc_know_more"),
                                                style: CustomWidget(context: context)
                                                    .CustomSizedTextStyle(
                                                    9.0,
                                                    Theme.of(context).dialogBackgroundColor,
                                                    FontWeight.w600,
                                                    'FontRegular'),
                                                textAlign: TextAlign.start,
                                              ),
                                            ],
                                          ),
                                        ),flex: 1,)
                                      ],
                                    )
                                  ],
                                ),
                              ), flex: 5,),
                              Flexible(child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                    colors: [
                                      const Color(0xFF0DD8FF),
                                      const Color(0xFF0FABFF),
                                      const Color(0xFF1457FF),
                                      const Color(0xFF1636FF),
                                      const Color(0xFF0E69C7),
                                    ],
                                  ),
                                ),
                              ), flex: 1,)
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: EdgeInsets.only(top: 25.0, right: 10.0),
                            child: Image.asset("assets/images/cleaning.png", height: 100.0,),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),

                    Container(
                      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Theme.of(context).focusColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.instance.text("loc_booked_serv"),
                            style: CustomWidget(context: context)
                                .CustomSizedTextStyle(
                                12.0,
                                Theme.of(context).primaryColor,
                                FontWeight.w600,
                                'FontRegular'),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                    orderList.length>0 ? ListView.builder(
                      itemCount: orderList.length,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Theme.of(context).focusColor,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap:(){
                                  viewDetails();
                                  otp = false;
                                },
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Container(
                                                height: 80.0,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(10.0),
                                                  image: DecorationImage(
                                                    image: NetworkImage(orderList[index].services!.coverImage![0].toString()),
                                                    // image: AssetImage(
                                                    //     "assets/images/serv_back_2.png"),
                                                    fit: BoxFit.cover,
                                                  ),),
                                                // child: Image.asset(
                                                //   "assets/images/cleaning.png",
                                                //   height: 80.0,
                                                // ),
                                              ),
                                              flex: 1,
                                            ),
                                            const SizedBox(
                                              width: 10.0,
                                            ),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                              orderList[index].serviceStatus ==0? AppLocalizations.instance
                                                  .text("loc_wait"): orderList[index].serviceStatus ==1?
                                                    AppLocalizations.instance
                                                .text("loc_proc"): orderList[index].serviceStatus ==3? AppLocalizations.instance
                                                  .text("loc_assign"):
                                              AppLocalizations.instance
                                                        .text("loc_comp"),

                                                    style: CustomWidget(context: context)
                                                        .CustomSizedTextStyle(
                                                        18.0,
                                                        // Theme.of(context)
                                                        //     .dialogBackgroundColor,
                                                        // Theme.of(context)
                                                        //     .disabledColor,
                                                        // Theme.of(context)
                                                        //     .selectedRowColor,
                                                        Theme.of(context)
                                                            .primaryColor,
                                                        FontWeight.w600,
                                                        'FontRegular'),
                                                    textAlign: TextAlign.start,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        // AppLocalizations.instance
                                                        //     .text("loc_deep_clean"),
                                                        orderList[index].services!.serviceName.toString(),
                                                        style: CustomWidget(context: context)
                                                            .CustomSizedTextStyle(
                                                            14.0,
                                                            Theme.of(context)
                                                                .primaryColor,
                                                            FontWeight.w600,
                                                            'FontRegular'),
                                                        textAlign: TextAlign.start,
                                                      ),

                                                      Icon(
                                                        Icons.arrow_forward_ios_rounded,
                                                        size: 15.0,
                                                        color:
                                                        Theme.of(context).primaryColor,
                                                      ),
                                                    ],
                                                  ),

                                                  const SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: orderList[index].serviceStatus ==0? Theme.of(context)
                                                              .disabledColor : orderList[index].serviceStatus ==1 ? Theme.of(context).dialogBackgroundColor: orderList[index].serviceStatus ==3 ?Theme.of(context)
                                                              .errorColor : Theme.of(context).selectedRowColor,
                                                        ),
                                                        height: 5.0,
                                                        width: 5.0,
                                                      ),
                                                      const SizedBox(
                                                        width: 3.0,
                                                      ),
                                                      Text(
                                                        "Service done on Feb 17",
                                                        style:
                                                        CustomWidget(context: context)
                                                            .CustomSizedTextStyle(
                                                            10.0,
                                                            Theme.of(context)
                                                                .primaryColor,
                                                            FontWeight.w400,
                                                            'FontRegular'),
                                                        textAlign: TextAlign.start,
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10.0,
                                                  ),
                                                ],
                                              ),
                                              flex: 3,
                                            ),
                                            // Flexible(child: Icon(
                                            //   Icons.
                                            // ))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 1.0,
                                color: Theme.of(context).shadowColor,
                              ),
                            ],
                          ),
                        );
                      },
                    ) : Container(
                      padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 10.0),
                      child: Center(
                        child: Text(
                          AppLocalizations.instance.text('loc_no_records'),
                          style: CustomWidget(context: context)
                              .CustomSizedTextStyle(
                              16.0,
                              Theme.of(context).primaryColor,
                              FontWeight.w700,
                              'FontRegular'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            loading
                ? CustomWidget(context: context).loadingIndicator(
              Theme.of(context).cardColor,
            )
                : Container(),

          ],
        ),
      ),
    );
  }


  viewDetails() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
        ),
        backgroundColor: Colors.transparent,
        enableDrag: true,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext con) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter ssetState) {
                return Container(
                  margin: EdgeInsets.only(top: 5.0),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(right: 5.0, left: 0.0,),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        topLeft: Radius.circular(30.0),
                      )
                  ),
                  child: SingleChildScrollView(
                    controller: _scroll,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 30.0,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding:EdgeInsets.all(15.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).indicatorColor,
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: Theme.of(context).focusColor,
                                  size: 55.0,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "Job completed!🤩",
                                style: CustomWidget(context: context)
                                    .CustomSizedTextStyle(
                                    18.0,
                                    Theme.of(context).primaryColor,
                                    FontWeight.w600,
                                    'FontRegular'),
                              ),
                              const SizedBox(
                                height: 25.0,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 20.0,
                                    right: 20.0,
                                    top: 0.0,
                                    bottom: 20.0),
                                child: TicketWidget(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height:
                                    MediaQuery.of(context).size.height *
                                        0.25,
                                    padding: EdgeInsets.fromLTRB(
                                        10.0, 15.0, 10.0, 5.0),
                                    decoration: BoxDecoration(
                                        color: Color(0xFF1F598E),
                                        image: DecorationImage(
                                          colorFilter: ColorFilter.mode(
                                              Color(0xFF1F598E)
                                                  .withOpacity(0.6),
                                              BlendMode.dstATop),
                                          image: AssetImage(
                                              "assets/images/serv_back_2.png"),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(15.0)),
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            right: 10.0,
                                          ),
                                          child: SvgPicture.asset(
                                            "assets/menu/cool.svg",
                                            height: 25.0,
                                            color:
                                            Theme.of(context).cardColor,
                                          ),
                                        ),
                                        DottedLine(
                                          direction: Axis.vertical,
                                          dashColor:
                                          Theme.of(context).dividerColor,
                                        ),
                                        Flexible(
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                left: 10.0,
                                                right: 10.0,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(context).size.width* 0.5,
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                // name.toString(),
                                                                "Customer name",
                                                                style: CustomWidget(context: context).CustomSizedTextStyle(
                                                                    16.0,
                                                                    Theme.of(
                                                                        context)
                                                                        .focusColor,
                                                                    FontWeight
                                                                        .w600,
                                                                    'FontRegular'),
                                                                textAlign:
                                                                TextAlign
                                                                    .start,
                                                                overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                              ),
                                                              const SizedBox(
                                                                height: 5.0,
                                                              ),
                                                              Text(
                                                                "service type",
                                                                style: CustomWidget(context: context).CustomSizedTextStyle(
                                                                    12.0,
                                                                    Theme.of(
                                                                        context)
                                                                        .focusColor,
                                                                    FontWeight
                                                                        .w600,
                                                                    'FontRegular'),
                                                                textAlign:
                                                                TextAlign
                                                                    .start,
                                                                overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5.0,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .center,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Flexible(
                                                          child: Container(
                                                            width: MediaQuery.of(context).size.width *0.5,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Row(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                                  children: [
                                                                    Icon(
                                                                      Icons.location_on_outlined,
                                                                      size: 15.0,
                                                                      color: Theme.of(
                                                                          context)
                                                                          .focusColor,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 5.0,
                                                                    ),
                                                                    Flexible(
                                                                      child:  Text(
                                                                        "Location",
                                                                        style: CustomWidget(context: context).CustomSizedTextStyle(
                                                                            8.0,
                                                                            Theme.of(context)
                                                                                .focusColor,
                                                                            FontWeight
                                                                                .w600,
                                                                            'FontRegular'),
                                                                        textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                        overflow: TextOverflow.ellipsis,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 5.0,
                                                                ),
                                                                Row(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                                  children: [
                                                                    Icon(
                                                                      Icons.access_time,
                                                                      size: 15.0,
                                                                      color: Theme.of(
                                                                          context)
                                                                          .focusColor,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 5.0,
                                                                    ),
                                                                    Text(
                                                                      "19:30 BST - 23:00 BST",
                                                                      style: CustomWidget(context: context).CustomSizedTextStyle(
                                                                          8.0,
                                                                          Theme.of(context)
                                                                              .focusColor,
                                                                          FontWeight
                                                                              .w600,
                                                                          'FontRegular'),
                                                                      textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 5.0,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          flex: 1,
                                                        ),
                                                        Flexible(
                                                          child: Container(
                                                            decoration:
                                                            BoxDecoration(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  10.0),
                                                            ),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Text(
                                                                  // day,
                                                                  "Thursday",
                                                                  style: CustomWidget(context: context).CustomSizedTextStyle(
                                                                      10.0,
                                                                      Theme.of(context)
                                                                          .focusColor,
                                                                      FontWeight
                                                                          .w700,
                                                                      'FontRegular'),
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                ),
                                                                const SizedBox(
                                                                  width: 5.0,
                                                                ),
                                                                Text(
                                                                  // dateOnly,
                                                                  "16",
                                                                  style: CustomWidget(context: context).CustomSizedTextStyle(
                                                                      20.0,
                                                                      Theme.of(context)
                                                                          .focusColor,
                                                                      FontWeight
                                                                          .w700,
                                                                      'FontRegular'),
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                ),
                                                                const SizedBox(
                                                                  width: 5.0,
                                                                ),
                                                                Text(
                                                                  // dateName,
                                                                  "March 2023",
                                                                  style: CustomWidget(context: context).CustomSizedTextStyle(
                                                                      10.0,
                                                                      Theme.of(context)
                                                                          .focusColor,
                                                                      FontWeight
                                                                          .w700,
                                                                      'FontRegular'),
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          flex: 1,
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )),
                                        DottedLine(
                                          direction: Axis.vertical,
                                          dashColor:
                                          Theme.of(context).dividerColor,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 10.0,
                                            right: 10.0,
                                          ),

                                        ),
                                      ],
                                    ),
                                  ),
                                  height: MediaQuery.of(context).size.height *
                                      0.22,
                                  width: MediaQuery.of(context).size.width,
                                  isCornerRounded: true,
                                ),
                              ),
                              const SizedBox(height: 30.0,),

                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        // Navigator.of(context).push(
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             Home_Screen()));

                                        ssetState(() {
                                          // otp = true;
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(
                                            60.0, 10.0, 60.0, 10.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(30.0),
                                          color:
                                          Theme.of(context).dialogBackgroundColor,
                                        ),
                                        child: Text(
                                          AppLocalizations.instance
                                              .text("loc_done"),
                                          style:
                                          CustomWidget(context: context)
                                              .CustomSizedTextStyle(
                                              14.0,
                                              Theme.of(context)
                                                  .focusColor,
                                              FontWeight.w800,
                                              'FontRegular'),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20.0,),
                                    Text(
                                      "Customer verification need ",
                                      style: CustomWidget(context: context)
                                          .CustomSizedTextStyle(
                                          10.0,
                                          Theme.of(context).primaryColor,
                                          FontWeight.w400,
                                          'FontRegular'),
                                    ),
                                    const SizedBox(height: 20.0,),
                                  ],
                                ),
                              ),

                              // otp ? Container(
                              //   padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              //   child:  Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Text(
                              //         AppLocalizations.instance
                              //             .text("loc_enter_code"),
                              //         style: CustomWidget(context: context)
                              //             .CustomSizedTextStyle(
                              //             16.0,
                              //             Theme.of(context).primaryColor,
                              //             FontWeight.w600,
                              //             'FontRegular'),
                              //         textAlign: TextAlign.start,
                              //       ),
                              //       const SizedBox(height: 15.0,),
                              //       OTPTextField(
                              //         length: 6,
                              //         width: MediaQuery.of(context).size.width,
                              //         fieldWidth: 45,
                              //         style: CustomWidget(context: context)
                              //             .CustomSizedTextStyle(
                              //             14.0,
                              //             Theme.of(context).primaryColor,
                              //             FontWeight.w600,
                              //             'FontRegular'),
                              //         textFieldAlignment: MainAxisAlignment.spaceAround,
                              //         fieldStyle: FieldStyle.underline,
                              //         onCompleted: (pin) {
                              //           // print("Completed: " + pin);
                              //           setState(() {
                              //
                              //             pinValue=pin;
                              //           });
                              //         },
                              //       ),
                              //       const SizedBox(height: 25.0,),
                              //       Align(
                              //         alignment: Alignment.center,
                              //         child: InkWell(
                              //           onTap: (){
                              //             if(pinValue.isEmpty || pinValue.length<6)
                              //
                              //             {
                              //               CustomWidget(context: context)
                              //                   .custombar("Jop Completed","Please enter OTP", false);
                              //             }
                              //             else{
                              //               ssetState(() {
                              //                 loading=true;
                              //                 Navigator.pop(context);
                              //               });
                              //             }
                              //
                              //
                              //           },
                              //           child: Container(
                              //             width: MediaQuery.of(context).size.width * 0.6,
                              //             padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                              //             decoration: BoxDecoration(
                              //               // border: Border.all(
                              //               //   width: 1.0,
                              //               //   color: Theme.of(context).cardColor,
                              //               // ),
                              //               borderRadius: BorderRadius.circular(6.0),
                              //               color: Theme.of(context).indicatorColor,
                              //             ),
                              //             child: Center(
                              //               child: Text(
                              //                 AppLocalizations.instance
                              //                     .text("loc_done"),
                              //                 style: CustomWidget(context: context)
                              //                     .CustomSizedTextStyle(
                              //                     16.0,
                              //                     Theme.of(context).focusColor,
                              //                     FontWeight.w800,
                              //                     'FontRegular'),
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //       const SizedBox(height: 15.0,),
                              //     ],
                              //   ),
                              // ) :
                              // Container(
                              //   child: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.center,
                              //     children: [
                              //       InkWell(
                              //         onTap: () {
                              //           // Navigator.of(context).push(
                              //           //     MaterialPageRoute(
                              //           //         builder: (context) =>
                              //           //             Home_Screen()));
                              //
                              //           ssetState(() {
                              //             otp = true;
                              //           });
                              //           // Navigator.pop(context);
                              //         },
                              //         child: Container(
                              //           padding: EdgeInsets.fromLTRB(
                              //               60.0, 10.0, 60.0, 10.0),
                              //           decoration: BoxDecoration(
                              //             borderRadius:
                              //             BorderRadius.circular(30.0),
                              //             color:
                              //             Theme.of(context).dialogBackgroundColor,
                              //           ),
                              //           child: Text(
                              //             AppLocalizations.instance
                              //                 .text("loc_gen_otp"),
                              //             style:
                              //             CustomWidget(context: context)
                              //                 .CustomSizedTextStyle(
                              //                 14.0,
                              //                 Theme.of(context)
                              //                     .focusColor,
                              //                 FontWeight.w800,
                              //                 'FontRegular'),
                              //             textAlign: TextAlign.center,
                              //           ),
                              //         ),
                              //       ),
                              //       const SizedBox(height: 20.0,),
                              //       Text(
                              //         "Customer verification need ",
                              //         style: CustomWidget(context: context)
                              //             .CustomSizedTextStyle(
                              //             10.0,
                              //             Theme.of(context).primaryColor,
                              //             FontWeight.w400,
                              //             'FontRegular'),
                              //       ),
                              //       const SizedBox(height: 20.0,),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),

                      ],
                    ),
                  ),
                );
              });
        });
  }


  profile() {
    apiUtils
        .getProfileDetails()
        .then((GetProfileDetailsModel loginData) {
      setState(() {
        if (loginData.success!) {
          setState(() {
            loading = false;
            details = loginData.result!;
            var str = loginData.result!.name!.split(".");
            userName =loginData.result!.name!.contains(".")?str[1].trim().toString():loginData.result!.name!;;
          });
          // CustomWidget(context: context).
          // custombar("Profile", loginData.message.toString(), true);

        }
        else {
          loading = false;
          CustomWidget(context: context)
              .custombar("Profile", loginData.message.toString(), false);

        }
      });

    }).catchError((Object error) {


      print(error);
      setState(() {
        loading = false;
      });
    });
  }

  serviceDetails() {
    apiUtils
        .getServiceDetails()
        .then((GetAssignedJobsListModel loginData) {
      setState(() {
        if (loginData.success!) {
          setState(() {
            loading = false;
            orderList = loginData.result!;

          });
          // CustomWidget(context: context).
          // custombar("Service", loginData.message.toString(), true);

        }
        else {
          loading = false;
          CustomWidget(context: context)
              .custombar("Service", loginData.message.toString(), false);

        }
      });

    }).catchError((Object error) {


      print(error);
      setState(() {
        loading = false;
      });
    });
  }

  storeData(String name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("name", name);
  }
}
