import 'package:coolwell_tech/common/model/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../common/custom_widget.dart';
import '../../common/dotted_line_widget.dart';
import '../../common/localization/localizations.dart';
import '../../common/model/api_utils.dart';
import '../../common/model/assigned_order_model.dart';
import '../../common/model/order_complete.dart';
import '../../common/otp_fields/otp_field_custom.dart';
import '../../common/otp_fields/style.dart';
import '../../common/ticket_design.dart';
import '../user/basics/notification.dart';
import 'Tech_Home.dart';

class Tech_Order_Details_Screen extends StatefulWidget {
  final String j_id;
  const Tech_Order_Details_Screen({Key? key,  required this.j_id}) : super(key: key);

  @override
  State<Tech_Order_Details_Screen> createState() => _Tech_Order_Details_ScreenState();
}

class _Tech_Order_Details_ScreenState extends State<Tech_Order_Details_Screen> {

  bool loading = false;
  APIUtils apiUtils = APIUtils();
  AssignedOrdersResult? OrderFullList;
  Services? ServiceList;
  String Servicename ="";
  String Serviceamount ="";
  String Servicetime ="";
  // String ServiceList ="";
  String CustomerNum ="";
  String Customername ="";
  String CustomerAdd ="";
  ScrollController _scrollController = ScrollController();
  ScrollController _scroll = ScrollController();
  bool otp = false;
  String pinValue="";
  String cdate = DateFormat("MM/dd/yyyy HH:mm").format(DateTime.now());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading= true;
    servicesDetails();
    print(cdate + " Jeeva");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  const Color(0xFF0DD8FF).withOpacity(0.3),
                  const Color(0xFF0FABFF).withOpacity(0.3),
                  const Color(0xFF1457FF).withOpacity(0.3),
                  const Color(0xFF1636FF).withOpacity(0.3),
                  const Color(0xFF0E69C7).withOpacity(0.3),
                ],
              ),
            ),
            child:loading
                ? CustomWidget(context: context).loadingIndicator(
              Theme.of(context).cardColor,
            )
                :  Stack(
              children: [
                Container(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        const SizedBox(height: 20.0,),
                        Container(
                          margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22.0),
                            color: Theme.of(context).focusColor,
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height *0.2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(22.0),
                                        topRight: Radius.circular(22.0)
                                    ),
                                    color: Color(0xFF1F598E),
                                    image: DecorationImage(
                                      colorFilter: ColorFilter.mode(
                                          Color(0xFF1F598E).withOpacity(0.6),
                                          BlendMode.dstATop),
                                      image: NetworkImage(
                                          ServiceList!.coverImage![0].toString()
                                      ),
                                      fit: BoxFit.cover,
                                    )
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(20.0, 20.0, 25.0, 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    // AppLocalizations.instance
                                                    //     .text("loc_cleaning"),
                                                    Servicename,
                                                    style: CustomWidget(
                                                        context:
                                                        context)
                                                        .CustomSizedTextStyle(
                                                        18.0,
                                                        Theme.of(
                                                            context)
                                                            .primaryColor,
                                                        FontWeight
                                                            .w600,
                                                        'FontRegular'),
                                                    textAlign:
                                                    TextAlign.start,
                                                    overflow:
                                                    TextOverflow
                                                        .ellipsis,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .center,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(
                                                      "₹"+ Serviceamount,
                                                      style: CustomWidget(
                                                          context:
                                                          context)
                                                          .CustomSizedTextStyle(
                                                          13.0,
                                                          Theme.of(
                                                              context)
                                                              .primaryColor,
                                                          FontWeight
                                                              .w800,
                                                          'FontRegular'),
                                                      textAlign:
                                                      TextAlign
                                                          .center,
                                                    ),
                                                    SizedBox(
                                                      width: 12.0,
                                                    ),
                                                    Container(
                                                      width: 3.0,
                                                      height: 3.0,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10.0),
                                                        color: Theme.of(
                                                            context)
                                                            .primaryColor,
                                                      ),
                                                    ),

                                                    SizedBox(
                                                      width: 5.0,
                                                    ),
                                                    Text(
                                                      "Target time "+ Servicetime,
                                                      style: CustomWidget(
                                                          context:
                                                          context)
                                                          .CustomSizedTextStyle(
                                                          10.0,
                                                          Theme.of(
                                                              context)
                                                              .primaryColor,
                                                          FontWeight
                                                              .w400,
                                                          'FontRegular'),
                                                      textAlign:
                                                      TextAlign
                                                          .center,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                              ],
                                            ),
                                          ),
                                          flex: 1,
                                        ),
                                        Flexible(
                                          child: Container(

                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  10.0),
                                              image: DecorationImage(

                                                image: AssetImage(
                                                  "assets/images/cleaning.png",),
                                                fit: BoxFit.cover,
                                              ),),
                                            width: 85.0,
                                            height: 80,
                                          ),
                                          flex: 1,
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 10.0,),
                                    DottedLine(
                                      direction: Axis.horizontal,
                                      dashColor: Theme.of(context).shadowColor,
                                    ),
                                    const SizedBox(height: 20.0,),
                                    Text(
                                      // "User name",
                                      Customername,
                                      style: CustomWidget(
                                          context:
                                          context)
                                          .CustomSizedTextStyle(
                                          18.0,
                                          Theme.of(
                                              context)
                                              .primaryColor,
                                          FontWeight
                                              .w700,
                                          'FontRegular'),
                                      textAlign:
                                      TextAlign.start,
                                      overflow:
                                      TextOverflow
                                          .ellipsis,
                                    ),
                                    const SizedBox(height: 5.0,),
                                    // Text(
                                    //   "User id",
                                    //   style: CustomWidget(
                                    //       context:
                                    //       context)
                                    //       .CustomSizedTextStyle(
                                    //       10.0,
                                    //       Theme.of(
                                    //           context)
                                    //           .primaryColor,
                                    //       FontWeight
                                    //           .w700,
                                    //       'FontRegular'),
                                    //   textAlign:
                                    //   TextAlign.start,
                                    //   overflow:
                                    //   TextOverflow
                                    //       .ellipsis,
                                    // ),
                                    const SizedBox(height: 20.0,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                AppLocalizations.instance
                                                    .text("loc_serv_details"),
                                                style: CustomWidget(context: context)
                                                    .CustomSizedTextStyle(
                                                    18.0,
                                                    Theme.of(context).primaryColor,
                                                    FontWeight.w700,
                                                    'FontRegular'),
                                                textAlign: TextAlign.start,
                                              ),
                                              flex: 3,
                                            ),
                                            const SizedBox(
                                              width: 2.0,
                                            ),
                                            Flexible(
                                              child: Text(
                                                "",
                                                style: CustomWidget(context: context)
                                                    .CustomSizedTextStyle(
                                                    10.0,
                                                    Theme.of(context).primaryColor,
                                                    FontWeight.w700,
                                                    'FontRegular'),
                                                textAlign: TextAlign.center,
                                              ),
                                              flex: 1,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),

                                        ListView.builder(
                                          padding: EdgeInsets.zero,
                                          itemCount: OrderFullList!.services!.checkList!.length,
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          controller: _scrollController,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        // AppLocalizations.instance
                                                        //     .text("loc_clean_foam"),
                                                        OrderFullList!.services!.checkList![index].toString(),
                                                        style: CustomWidget(context: context)
                                                            .CustomSizedTextStyle(
                                                            14.0,
                                                            Theme.of(context).primaryColor,
                                                            FontWeight.w400,
                                                            'FontRegular'),
                                                        textAlign: TextAlign.start,
                                                      ),
                                                      flex: 3,
                                                    ),
                                                    const SizedBox(
                                                      width: 2.0,
                                                    ),
                                                    Flexible(
                                                      child: Container(
                                                        child: Center(
                                                          child: Icon(
                                                            Icons.check,
                                                            color:
                                                            Theme.of(context).selectedRowColor,
                                                          ),
                                                        ),
                                                      ),
                                                      flex: 1,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          },
                                        ),

                                        // Row(
                                        //   crossAxisAlignment: CrossAxisAlignment.center,
                                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        //   children: [
                                        //     Flexible(
                                        //       child: Text(
                                        //         AppLocalizations.instance
                                        //             .text("loc_indoor_outer"),
                                        //         style: CustomWidget(context: context)
                                        //             .CustomSizedTextStyle(
                                        //             14.0,
                                        //             Theme.of(context).primaryColor,
                                        //             FontWeight.w400,
                                        //             'FontRegular'),
                                        //         textAlign: TextAlign.start,
                                        //       ),
                                        //       flex: 3,
                                        //     ),
                                        //     const SizedBox(
                                        //       width: 2.0,
                                        //     ),
                                        //     Flexible(
                                        //       child: Container(
                                        //         child: Center(
                                        //             child: Text(
                                        //               "Intence",
                                        //               style: CustomWidget(context: context)
                                        //                   .CustomSizedTextStyle(
                                        //                   12.0,
                                        //                   Theme.of(context).primaryColor,
                                        //                   FontWeight.w600,
                                        //                   'FontRegular'),
                                        //               textAlign: TextAlign.center,
                                        //             )),
                                        //       ),
                                        //       flex: 1,
                                        //     ),
                                        //   ],
                                        // ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                AppLocalizations.instance
                                                    .text("loc_duration"),
                                                style: CustomWidget(context: context)
                                                    .CustomSizedTextStyle(
                                                    14.0,
                                                    Theme.of(context).primaryColor,
                                                    FontWeight.w400,
                                                    'FontRegular'),
                                                textAlign: TextAlign.start,
                                              ),
                                              flex: 3,
                                            ),
                                            const SizedBox(
                                              width: 2.0,
                                            ),
                                            Flexible(
                                              child: Container(
                                                child: Center(
                                                    child: Text(
                                                      "-",
                                                      style: CustomWidget(context: context)
                                                          .CustomSizedTextStyle(
                                                          12.0,
                                                          Theme.of(context).primaryColor,
                                                          FontWeight.w600,
                                                          'FontRegular'),
                                                      textAlign: TextAlign.center,
                                                    )),
                                              ),
                                              flex: 1,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                "ACs serviced 5-12 months ago",
                                                style: CustomWidget(context: context)
                                                    .CustomSizedTextStyle(
                                                    12.0,
                                                    Theme.of(context).primaryColor,
                                                    FontWeight.w600,
                                                    'FontRegular'),
                                                textAlign: TextAlign.start,
                                              ),
                                              flex: 3,
                                            ),
                                            const SizedBox(
                                              width: 2.0,
                                            ),
                                            Flexible(
                                              child: Container(
                                                child: Center(
                                                    child: Text(
                                                      "",
                                                      style: CustomWidget(context: context)
                                                          .CustomSizedTextStyle(
                                                          12.0,
                                                          Theme.of(context).primaryColor,
                                                          FontWeight.w600,
                                                          'FontRegular'),
                                                      textAlign: TextAlign.center,
                                                    )),
                                              ),
                                              flex: 1,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20.0,),

                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Flexible(child: Container(
                                          child: Column(
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.location_on_outlined,
                                                    size: 20.0,
                                                    color: Theme.of(context).primaryColor,
                                                  ),
                                                  const SizedBox(width: 5.0,),
                                                  Flexible(
                                                    child:  Text(
                                                      // AppLocalizations.instance
                                                      //     .text("loc_track_location"),
                                                      CustomerAdd.toString(),
                                                      style: CustomWidget(context: context)
                                                          .CustomSizedTextStyle(
                                                          10.0,
                                                          Theme.of(context).primaryColor,
                                                          FontWeight.w600,
                                                          'FontRegular'),
                                                      textAlign: TextAlign.start,
                                                      // overflow: TextOverflow.ellipsis,
                                                    ),
                                                  )

                                                ],
                                              ),
                                              const SizedBox(height: 5.0,),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.phone,
                                                    size: 20.0,
                                                    color: Theme.of(context).primaryColor,
                                                  ),
                                                  const SizedBox(width: 5.0,),
                                                  Flexible(child: Text(
                                                    // "+91 9876543210",
                                                    CustomerNum.toString(),
                                                    style: CustomWidget(context: context)
                                                        .CustomSizedTextStyle(
                                                        12.0,
                                                        Theme.of(context).primaryColor,
                                                        FontWeight.w600,
                                                        'FontRegular'),
                                                    textAlign: TextAlign.start,
                                                    overflow: TextOverflow.ellipsis,
                                                  ))

                                                ],
                                              )
                                            ],
                                          ),
                                        ),flex: 1,),
                                        Flexible(child: Container(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: SvgPicture.asset(
                                              "assets/tech/scan.svg",
                                              height: 80.0,
                                              color: Theme.of(context).primaryColor,
                                            ),
                                          ),
                                        ), flex: 1,)

                                      ],
                                    ),
                                    const SizedBox(height: 20.0,),

                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                        const SizedBox(height: 30.0,),
                      ],
                    ),
                  ),
                ),
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: InkWell(
                //     onTap: () {
                //       setState(() {
                //         showSuccessAlertDialog("Good luck! 🤗 ",
                //             "You get your assigned task");
                //       });
                //     },
                //     child: Container(
                //       margin: EdgeInsets.only(bottom: 20.0),
                //       padding:
                //       EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(30.0),
                //         color: Theme.of(context).dialogBackgroundColor,
                //       ),
                //       child: Text(
                //         AppLocalizations.instance
                //             .text("loc_proceed_to_process"),
                //         style: CustomWidget(context: context)
                //             .CustomSizedTextStyle(
                //             14.0,
                //             Theme.of(context).focusColor,
                //             FontWeight.w800,
                //             'FontRegular'),
                //         textAlign: TextAlign.center,
                //       ),
                //     ),
                //   ),
                // ),

                OrderFullList!.complaints!.serviceStatus! ==3 ? Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        showSuccesssAlertDialog("Accept Order",
                            "Are you sure want to Accept Order ?");
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      padding:
                      EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Theme.of(context).dialogBackgroundColor,
                      ),
                      child: Text(
                        AppLocalizations.instance
                            .text("loc_accept"),
                        style: CustomWidget(context: context)
                            .CustomSizedTextStyle(
                            14.0,
                            Theme.of(context).focusColor,
                            FontWeight.w800,
                            'FontRegular'),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ) :
                Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        viewDetails();
                        otp = false;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      padding:
                      EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Theme.of(context).dialogBackgroundColor,
                      ),
                      child: Text(
                        AppLocalizations.instance
                            .text("loc_complete_order"),
                        style: CustomWidget(context: context)
                            .CustomSizedTextStyle(
                            14.0,
                            Theme.of(context).focusColor,
                            FontWeight.w800,
                            'FontRegular'),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }

  // showSuccessAlertDialog(
  //     String title,
  //     String message,
  //     ) {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Dialog(
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(14.0)), //this right here
  //           child: Container(
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(14.0),
  //               color: Theme.of(context).focusColor,
  //             ),
  //             height: MediaQuery.of(context).size.height * 0.30,
  //             child: Padding(
  //               padding: const EdgeInsets.all(12.0),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   Text(
  //                     title.toUpperCase(),
  //                     style: TextStyle(
  //                       fontSize: 17.0,
  //                       color: Theme.of(context).primaryColor,
  //                       fontWeight: FontWeight.w600,
  //                       fontFamily: 'OpenSansBold',
  //                     ),
  //                   ),
  //                   Text(
  //                     message,
  //                     style: TextStyle(
  //                       fontSize: 15.0,
  //                       color: Theme.of(context).primaryColor,
  //                       fontWeight: FontWeight.w400,
  //                       fontFamily: 'OpenSans',
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 10.0,
  //                   ),
  //                   Container(
  //                     margin: EdgeInsets.only(top: 7.0, bottom: 10.0),
  //                     height: 2.0,
  //                     color: Theme.of(context).dividerColor,
  //                   ),
  //                   GestureDetector(
  //                     onTap: (){
  //                       Navigator.of(context).pop(true);
  //                       Navigator.of(context).push(MaterialPageRoute(
  //                           builder: (context) =>
  //                               Notification_Screen()));
  //                       loading = true;
  //                     },
  //                     child: Text(
  //                       "Track process",
  //                       style: TextStyle(
  //                         fontSize: 17.0,
  //                         color: Color(0xFF007AFF),
  //                         fontWeight: FontWeight.w600,
  //                         fontFamily: 'OpenSans',
  //                       ),
  //                     ),
  //                   ),
  //                   Container(
  //                     margin: EdgeInsets.only(top: 7.0, bottom: 10.0),
  //                     height: 2.0,
  //                     color: Theme.of(context).dividerColor,
  //                   ),
  //                   InkWell(
  //                     onTap: (){
  //
  //                     },
  //                     child:  Text(
  //                       "Track order location",
  //                       style: TextStyle(
  //                         fontSize: 17.0,
  //                         color: Color(0xFF007AFF),
  //                         fontWeight: FontWeight.w400,
  //                         fontFamily: 'OpenSans',
  //                       ),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       });
  //   // show the dialog
  // }

  showSuccesssAlertDialog(
      String title,
      String message,
      ) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0)), //this right here
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.0),
                color: Theme.of(context).focusColor,
              ),
              height: MediaQuery.of(context).size.height * 0.28,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title.toUpperCase(),
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'OpenSansBold',
                      ),
                    ),
                    Text(
                      message,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 7.0, bottom: 10.0),
                      height: 2.0,
                      color: Theme.of(context).dividerColor,
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          loading = true;
                        });
                        jobDetails();
                        Navigator.of(context).pop(true);
                      },
                      child: Text(
                        "Accept Order",
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Color(0xFF007AFF),
                          fontWeight: FontWeight.w600,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 7.0, bottom: 10.0),
                      height: 2.0,
                      color: Theme.of(context).dividerColor,
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pop(true);
                      },
                      child:  Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Color(0xFF007AFF),
                          fontWeight: FontWeight.w400,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
    // show the dialog
  }

  showSuccessAlertDialog(
      String title,
      String message,
      ) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0)), //this right here
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.0),
                color: Theme.of(context).focusColor,
              ),
              height: MediaQuery.of(context).size.height * 0.30,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title.toUpperCase(),
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'OpenSansBold',
                      ),
                    ),
                    Text(
                      message,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 7.0, bottom: 10.0),
                      height: 2.0,
                      color: Theme.of(context).dividerColor,
                    ),
                    GestureDetector(
                      onTap: (){
                        CompleteOrder();
                        setState(() {
                          loading = true;
                        });
                        Navigator.of(context).pop(true);
                      },
                      child: Text(
                        "Complete Order",
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Color(0xFF007AFF),
                          fontWeight: FontWeight.w600,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 7.0, bottom: 10.0),
                      height: 2.0,
                      color: Theme.of(context).dividerColor,
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child:  Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Color(0xFF007AFF),
                          fontWeight: FontWeight.w400,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
    // show the dialog
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
                                                                // "Customer name",
                                                                Customername.toString(),
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
                                                                Servicename.toString(),
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
                                                                      .start,
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
                                                                        CustomerAdd.toString(),
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
                                                                        // overflow: TextOverflow.ellipsis,
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
                                                                      // _timeString.toString() + " - " + _endtime.toString(),
                                                                      "-",
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
                                                                  // "Thursday",
                                                                  " ",
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
                                                                  // "16",
                                                                  " ",
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
                                                                  // "March 2023",
                                                                  " ",
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
                                      0.24,
                                  width: MediaQuery.of(context).size.width,
                                  isCornerRounded: true,
                                ),
                              ),
                              const SizedBox(height: 30.0,),

                             otp ? InkWell(
                               onTap: () {
                                 ssetState(() {
                                   String cdate = DateFormat("MM/dd/yyyy HH:mm").format(DateTime.now());
                                   print(cdate +" Jeeva Subash");
                                 });
                                 // Navigator.pop(context);
                               },
                               child: Container(
                                 padding: EdgeInsets.fromLTRB(
                                     50.0, 10.0, 50.0, 10.0),
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
                             ) : InkWell(
                                onTap: () {
                                  ssetState(() {
                                    showSuccessAlertDialog("Complete Order",
                                        "Are you sure want to Complete Order ?");
                                  });
                                  // Navigator.pop(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(
                                      50.0, 10.0, 50.0, 10.0),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(30.0),
                                    color:
                                    Theme.of(context).dialogBackgroundColor,
                                  ),
                                  child: Text(
                                    AppLocalizations.instance
                                        .text("loc_complete_order"),
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



  servicesDetails() {
    apiUtils
        .getServiceFullDetails(widget.j_id)
        .then((AssignedOrdersModel loginData) {
      setState(() {
        if (loginData.success!) {
          setState(() {
            loading = false;
            OrderFullList = loginData.result![0];
            Servicename =OrderFullList!.services!.serviceName.toString();
            Serviceamount =OrderFullList!.services!.amount.toString();
            Servicetime =OrderFullList!.services!.time.toString();
            ServiceList =OrderFullList!.services!;
            CustomerNum =OrderFullList!.users!.phone.toString();
            Customername =OrderFullList!.users!.name.toString();
            CustomerAdd =OrderFullList!.complaints!.address.toString();


            // var StartTime = DateTime.fromMillisecondsSinceEpoch(int.parse(OrderFullList!.startTime.toString())*1000);
            // print(StartTime);

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

  jobDetails() {
    apiUtils
        .acceptJobService(widget.j_id.toString())
        .then((CommonModel loginData) {
      setState(() {
        if (loginData.success!) {
          setState(() {
            loading = false;
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    TechHome()));
            // serviceList = loginData.result!;

          });
          CustomWidget(context: context).
          custombar("Service", loginData.message.toString(), true);

        }
        else {
          setState(() {
            loading = false;
          });

          CustomWidget(context: context)
              .custombar("Service", loginData.message.toString(), false);

        }
      });

    }).catchError((Object error) {


      print("Err"+error.toString());
      setState(() {
        loading = false;
      });
    });
  }


  CompleteOrder() {
    apiUtils
        .jobFinishService(widget.j_id.toString(), cdate.toString())
        .then((OrderCompleteModel loginData) {
      setState(() {
        if (loginData.success!) {
          setState(() {
            loading = false;
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    TechHome()));
            // serviceList = loginData.result!;

          });
          CustomWidget(context: context).
          custombar("Service", loginData.message.toString(), true);

        }
        else {
          setState(() {
            loading = false;
          });

          CustomWidget(context: context)
              .custombar("Service", loginData.message.toString(), false);

        }
      });

    }).catchError((Object error) {


      print("Err"+error.toString());
      setState(() {
        loading = false;
      });
    });
  }

}
