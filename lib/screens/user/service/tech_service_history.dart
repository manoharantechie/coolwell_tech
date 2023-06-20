import 'package:coolwell_tech/screens/user/service/service_details.dart';
import 'package:coolwell_tech/screens/user/service/tech_service_history_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/calendar/calendar_timeline.dart';
import '../../../common/custom_widget.dart';
import '../../../common/localization/localizations.dart';
import '../../../common/model/api_utils.dart';
import '../../../common/model/date_service_history.dart';

class Tech_Service_History extends StatefulWidget {
  const Tech_Service_History({Key? key}) : super(key: key);

  @override
  State<Tech_Service_History> createState() => _Tech_Service_HistoryState();
}

class _Tech_Service_HistoryState extends State<Tech_Service_History> {

  late DateTime _selectedDate;
  APIUtils apiUtils = APIUtils();
  var snackBar;
  bool time = false;
  bool loading = false;
  ScrollController _scrollController = ScrollController();
  ScrollController _scroll = ScrollController();
  List<String> texts = ["Cleaning", "Repair", "Install"];
  List<DateServiceResult> serviceList=[];
  Services? serviceDetailsList;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDate = DateTime.now().add(const Duration(days: 0));
    loading = true;
    serviceDetails();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? CustomWidget(context: context).loadingIndicator(
        Theme.of(context).cardColor,
      ): Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Theme.of(context).focusColor,
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                  padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0, bottom: 10.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).focusColor,
                    image: DecorationImage(
                      image: AssetImage("assets/images/tech_service_back.png"),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              const Color(0xFFF4F4F4).withOpacity(0.5),
                              const Color(0xFFF4F4F4).withOpacity(0.3),
                              const Color(0xFFF4F4F4).withOpacity(0.1),
                            ],
                          ),
                        ),
                        child:  Text(
                          AppLocalizations.instance
                              .text("loc_serv_his"),
                          style: CustomWidget(context: context)
                              .CustomSizedTextStyle(
                              18.0,
                              Theme.of(context).primaryColor,
                              FontWeight.w400,
                              'FontRegular'),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      const SizedBox(height: 15.0,),
                      Container(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Thu",
                              style: CustomWidget(context: context)
                                  .CustomSizedTextStyle(
                                  16.0,
                                  Theme.of(context).focusColor,
                                  FontWeight.w400,
                                  'FontRegular'),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 5.0,),
                           Row(
                             children: [
                               Text(
                                 _selectedDate.day.toString(),
                                 style: CustomWidget(context: context)
                                     .CustomSizedTextStyle(
                                     24.0,
                                     Theme.of(context).focusColor,
                                     FontWeight.w600,
                                     'FontRegular'),
                                 textAlign: TextAlign.start,
                                 overflow: TextOverflow.ellipsis,
                               ),
                               Text(
                                 " Today",
                                 style: CustomWidget(context: context)
                                     .CustomSizedTextStyle(
                                     20.0,
                                     Theme.of(context).focusColor,
                                     FontWeight.w600,
                                     'FontRegular'),
                                 textAlign: TextAlign.start,
                                 overflow: TextOverflow.ellipsis,
                               ),
                             ],
                           )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
           Container(
             margin: EdgeInsets.only(top: 160.0),
             width: MediaQuery.of(context).size.width,
             child: Column(
               children: [
                 Container(
                     width: MediaQuery.of(context).size.width,
                     padding: EdgeInsets.only(left: 20.0),
                     child: Calen()),

                 const SizedBox(height: 5.0,),
               ],
             ),
           ),
            serviceList.length>0 ? Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.37),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: serviceList.length,
                // itemCount: texts.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                controller: _scroll,
                itemBuilder: (BuildContext context, int index) {
                  print("time"+ serviceList[index].startTime.toString());
                  var StartTime = DateTime.fromMillisecondsSinceEpoch(int.parse(serviceList[index].startTime.toString())*1000);
                  var _timeString = "${int.parse(StartTime.toString().substring(11,13))}:${StartTime.toString().substring(14,16)}  ${int.parse(StartTime.toString().substring(11,13))>= 12 ? "PM" : "AM"}";
                  var EndTime = DateTime.fromMillisecondsSinceEpoch(int.parse(serviceList[index].endTime.toString())*1000);
                  var _endtime = "${int.parse(EndTime.toString().substring(11,13))}:${EndTime.toString().substring(14,16)}  ${int.parse(EndTime.toString().substring(11,13))>= 12 ? "PM" : "AM"}";
                  return Container(
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child: Container(child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  _timeString.toString(),
                                  style: CustomWidget(context: context)
                                      .CustomSizedTextStyle(
                                      10.0,
                                      Theme.of(context).primaryColor,
                                      FontWeight.w600,
                                      'FontRegular'),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 5.0,),
                                Text(
                                  _endtime.toString(),
                                  style: CustomWidget(context: context)
                                      .CustomSizedTextStyle(
                                      8.0,
                                      Theme.of(context).primaryColor,
                                      FontWeight.w400,
                                      'FontRegular'),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            const SizedBox(width: 8.0,),
                            Container(
                              height: 15.0,
                              width: 15.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    const Color(0xFF0DD8FF),
                                    const Color(0xFF0FABFF),
                                    const Color(0xFF1457FF),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),), flex: 1,),
                        const SizedBox(width: 8.0,),
                        Flexible(child: InkWell(
                          onTap:(){
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    Service_History_Details(s_id: serviceList[index].id.toString())));
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14.0),
                                color: Theme.of(context).focusColor,
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context).splashColor,
                                      blurRadius: 10.0,
                                      offset: Offset(0.0, 0.5)
                                  ),
                                ]
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  // texts[index].toString(),
                                  serviceList[index].services!.serviceName.toString() ,
                                  style: CustomWidget(context: context)
                                      .CustomSizedTextStyle(
                                      18.0,
                                      Theme.of(context).primaryColor,
                                      FontWeight.w700,
                                      'FontRegular'),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 10.0,),
                                ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: serviceList[index].services!.checkList!.length,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  controller: _scrollController,
                                  itemBuilder: (BuildContext context,
                                      int index) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          // AppLocalizations.instance
                                          //     .text("loc_clean_foam"),
                                          serviceList[0].services!.checkList![0].toString(),
                                          // serviceDetailsList!.checkList![index].toString(),
                                          style: CustomWidget(context: context)
                                              .CustomSizedTextStyle(
                                              14.0,
                                              Theme.of(context).primaryColor,
                                              FontWeight.w400,
                                              'FontRegular'),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    );
                                  },
                                ) ,
                                // Text(
                                //   "Cleaning foam",
                                //   style: CustomWidget(context: context)
                                //       .CustomSizedTextStyle(
                                //       14.0,
                                //       Theme.of(context).primaryColor,
                                //       FontWeight.w400,
                                //       'FontRegular'),
                                //   textAlign: TextAlign.start,
                                //   overflow: TextOverflow.ellipsis,
                                // ),
                                // const SizedBox(height: 5.0,),
                                // Text(
                                //   "Power jet cleaning",
                                //   style: CustomWidget(context: context)
                                //       .CustomSizedTextStyle(
                                //       14.0,
                                //       Theme.of(context).primaryColor,
                                //       FontWeight.w400,
                                //       'FontRegular'),
                                //   textAlign: TextAlign.start,
                                //   overflow: TextOverflow.ellipsis,
                                // ),
                                // const SizedBox(height: 5.0,),
                                // Text(
                                //   "indoor & outer unit servicing",
                                //   style: CustomWidget(context: context)
                                //       .CustomSizedTextStyle(
                                //       14.0,
                                //       Theme.of(context).primaryColor,
                                //       FontWeight.w400,
                                //       'FontRegular'),
                                //   textAlign: TextAlign.start,
                                //   overflow: TextOverflow.ellipsis,
                                // ),
                                const SizedBox(height: 5.0,),
                                Text(
                                 "Duration: " + serviceList[index].services!.time.toString(),
                                  style: CustomWidget(context: context)
                                      .CustomSizedTextStyle(
                                      14.0,
                                      Theme.of(context).primaryColor,
                                      FontWeight.w400,
                                      'FontRegular'),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                ),


                              ],
                            ),
                          ),
                        ), flex: 4,)

                      ],
                    ),
                  );
                },
              ),
            ) : Center(
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

            const SizedBox(height: 10.0,),
          ],
        ),
      ),
    );
  }

  Widget Calen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CalendarTimeline(
          showYears: false,
          initialDate: _selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          onDateSelected: (date) {
            setState(() {
              _selectedDate = date;
              loading = true;
              serviceDetails();
            });
          },
          leftMargin: 0,
          monthColor: Colors.white.withOpacity(0.5),
          dayColor: Theme.of(context).primaryColor,
          dayNameColor: Theme.of(context).focusColor,
          activeDayColor: Colors.white,
          activeBackgroundDayColor: Theme.of(context).focusColor,
          dotsColor: const Color(0xFF333A47),
          selectableDayPredicate: (date) => date.day != 23,
          locale: 'en',
        ),
      ],
    );
  }


  serviceDetails() {
    apiUtils
        .serviceHistory(_selectedDate.toString())
        .then((DateServiceHistoryModel loginData) {
      setState(() {
        if (loginData.success!) {
          setState(() {
            loading = false;
            serviceList = loginData.result!;

          });
          // CustomWidget(context: context).
          // custombar("Service", loginData.message.toString(), true);

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
