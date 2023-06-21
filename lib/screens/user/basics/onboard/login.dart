import 'package:coolwell_tech/common/country.dart';
import 'package:coolwell_tech/common/model/api_utils.dart';
import 'package:coolwell_tech/common/model/login.dart';
import 'package:coolwell_tech/common/text_field_custom_prefix.dart';
import 'package:coolwell_tech/common/theme/custom_theme.dart';
import 'package:coolwell_tech/screens/technician/Tech_Home.dart';
import 'package:coolwell_tech/screens/user/profile/location_Screen.dart';
import 'package:coolwell_tech/screens/user/service/service.dart';
import 'package:coolwell_tech/screens/user/basics/dashboard.dart';
import 'package:coolwell_tech/screens/user/basics/onboard/forgot_pass.dart';
import 'package:country_calling_code_picker/country.dart';
import 'package:country_calling_code_picker/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:coolwell_tech/common/custom_widget.dart';
import 'package:coolwell_tech/common/localization/localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home.dart';

class SignUp_Screen extends StatefulWidget {
  const SignUp_Screen({Key? key}) : super(key: key);

  @override
  State<SignUp_Screen> createState() => _SignUp_ScreenState();
}

class _SignUp_ScreenState extends State<SignUp_Screen> {

  APIUtils apiUtils = APIUtils();
  bool loading = false;
  var snackBar;
  Country? _selectedCountry;
  bool mobileUIdesign = true;
  FocusNode mobileFocus = FocusNode();
  bool mobileVerify = true;
  TextEditingController mobile = TextEditingController();
  bool countryB = false;
  bool passVisible = false;
  bool checkHide=false;
  FocusNode nameFocus = FocusNode();
  FocusNode passFocus = FocusNode();
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  final emailformKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController=TextEditingController(text: "raju@mailinator.com");
    passController=TextEditingController(text: "Raju@123");
  }

  void initCountry() async {
    final country = await getDefaultCountry(context);
    setState(() {
      _selectedCountry = country;
      countryB = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(

        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Image.asset("assets/images/back.png", fit: BoxFit.fill,width: MediaQuery.of(context).size.width,),

            contentUI(),
            loading
                ? CustomWidget(context: context).loadingIndicator(
              Theme.of(context).cardColor,
            )
                : Container()

          ],
        ),
      ),
    );
  }

  Widget contentUI(){
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  AppLocalizations.instance
                      .text("loc_hey"),
                  style: CustomWidget(context: context)
                      .CustomSizedTextStyle(
                      18.0,
                      Theme.of(context).focusColor,
                      FontWeight.w600,
                      'FontRegular'),
                ),
                SizedBox(height: 5.0,),
                Text(
                  AppLocalizations.instance
                      .text("loc_welcome_txt"),
                  style: CustomWidget(context: context)
                      .CustomSizedTextStyle(
                      30.0,
                      Theme.of(context).focusColor,
                      FontWeight.w600,
                      'FontRegular'),
                ),
                SizedBox(height: 30.0,),

                TextFormCustom(
                  onEditComplete: () {
                    nameFocus.unfocus();
                    FocusScope.of(context).requestFocus(passFocus);
                  },
                  radius: 6.0,
                  error: "Enter Username or mail",
                  textColor: Theme.of(context).primaryColor,
                  borderColor: Theme.of(context).dividerColor,
                  fillColor: Theme.of(context).focusColor,
                  hintStyle: CustomWidget(context: context).CustomSizedTextStyle(
                      14.0, Theme.of(context).primaryColor.withOpacity(0.3), FontWeight.w500, 'FontRegular'),
                  textStyle: CustomWidget(context: context).CustomSizedTextStyle(
                      14.0, Theme.of(context).primaryColor, FontWeight.w500, 'FontRegular'),
                  textInputAction: TextInputAction.next,
                  focusNode: nameFocus,
                  maxlines: 1,
                  text: '',
                  hintText: "Username or mail",
                  obscureText: false,
                  textChanged: (value) {},
                  onChanged: () {},
                  suffix: Container(
                    width: 0.0,
                  ),
                  prefix: Container(
                    child: Icon(
                      Icons.person,
                      color: Theme.of(context).primaryColor.withOpacity(0.3),
                    ),
                  ),
                  validator: (value) {
                    if(nameController.text.isEmpty) {
                      return "Please Enter Email Details";
                    } else if(!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(nameController.text)) {
                      return "Please enter valid email format";
                    }
                  },
                  enabled: true,
                  textInputType: TextInputType.name,
                  controller: nameController,
                ),
                SizedBox(height: 15.0,),
                TextFormCustom(
                  onEditComplete: () {
                    passFocus.unfocus();
                    // FocusScope.of(context).requestFocus(newPassFocus);
                  },
                  radius: 6.0,
                  error: "Enter Password",
                  textColor: Theme.of(context).primaryColor,
                  borderColor: Theme.of(context).dividerColor,
                  fillColor: Theme.of(context).focusColor,
                  hintStyle: CustomWidget(context: context).CustomSizedTextStyle(
                      14.0, Theme.of(context).primaryColor.withOpacity(0.3), FontWeight.w500, 'FontRegular'),
                  textStyle: CustomWidget(context: context).CustomSizedTextStyle(
                      14.0, Theme.of(context).primaryColor, FontWeight.w500, 'FontRegular'),
                  textInputAction: TextInputAction.next,
                  focusNode: passFocus,
                  maxlines: 1,
                  text: '',
                  hintText: "Password",
                  obscureText: !passVisible,
                  textChanged: (value) {},
                  onChanged: () {},
                  suffix: IconButton(

                    icon: Icon(
                      passVisible ? Icons.visibility : Icons.visibility_off,
                      color: Theme.of(context).primaryColor.withOpacity(0.3),
                    ),
                    onPressed: () {
                      setState(() {
                        passVisible = !passVisible;
                      });
                    },
                  ),
                  prefix: Container(
                    child: Icon(
                      Icons.lock,
                      color: Theme.of(context).primaryColor.withOpacity(0.3),
                    ),
                  ),
                  validator: (value) {
                    if(passController.text.isEmpty) {
                      return "Please Enter Password ";
                    }
                    // else if( passController.text.length< 8 ) {
                    //   return "Please enter must not be less than 8 character";
                    // } else if(passController.text.length> 14){
                    //   return "Please enter must not be greater than 14 character";
                    // }
                  },
                  enabled: true,
                  textInputType: TextInputType.text,
                  controller: passController,
                ),
                SizedBox(height: 20.0,),


              ],
            ),
            key: emailformKey,
          ),


          const SizedBox(height: 25.0,),
          Align(
              alignment: Alignment.center,
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [


                  InkWell(
                    onTap: (){
                      if (emailformKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                          verifyMail();
                        });
                      }
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) =>
                      //         Home_Screen()));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                      decoration: BoxDecoration(
                        // border: Border.all(
                        //   width: 1.0,
                        //   color: Theme.of(context).cardColor,
                        // ),
                        borderRadius: BorderRadius.circular(20.0),
                        color: Theme.of(context).dialogBackgroundColor,
                      ),
                      child: Center(
                        child: Text(
                          AppLocalizations.instance
                              .text("loc_login"),
                          style: CustomWidget(context: context)
                              .CustomSizedTextStyle(
                              17.0,
                              Theme.of(context).focusColor,
                              FontWeight.w600,
                              'FontRegular'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25.0,),
                ],
              )
          ),
        ],
      ),
    );
  }


  Widget mobileUI(){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.instance
                .text("loc_hey"),
            style: CustomWidget(context: context)
                .CustomSizedTextStyle(
                18.0,
                Theme.of(context).focusColor,
                FontWeight.w600,
                'FontRegular'),
          ),
          SizedBox(height: 5.0,),
          Text(
            AppLocalizations.instance
                .text("loc_welcome_txt"),
            style: CustomWidget(context: context)
                .CustomSizedTextStyle(
                30.0,
                Theme.of(context).focusColor,
                FontWeight.w600,
                'FontRegular'),
          ),
          SizedBox(height: 30.0,),



          Row(
            children: [
              Container(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 13.0, bottom: 13.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).dividerColor,
                        width: 1.0),
                    color: CustomTheme.of(context)
                        .focusColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      bottomLeft: Radius.circular(5.0),
                    ),
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: _onPressedShowBottomSheet,
                        child: Row(
                          children: [
                            countryB
                                ? Image.asset(
                              _selectedCountry!.flag
                                  .toString(),
                              package:
                              "country_calling_code_picker",
                              height: 15.0,
                              width: 25.0,
                            )
                                : Container(
                              width: 0.0,
                            ),
                            Text(
                              countryB
                                  ? _selectedCountry!.callingCode.toString()
                                  : "+1",
                              style: CustomWidget(context: context)
                                  .CustomTextStyle(
                                  Theme.of(context).disabledColor,
                                  FontWeight.normal,
                                  'FontRegular'),
                            ),
                            const SizedBox(
                              width: 3.0,
                            ),
                            // Icon(
                            //   Icons.keyboard_arrow_down_outlined,
                            //   size: 15.0,
                            //   color: Theme.of(context).shadowColor,
                            // )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                    ],
                  )),
              Flexible(
                child: TextFormField(
                  controller: mobile,
                  focusNode: mobileFocus,
                  maxLines: 1,
                  enabled: mobileVerify,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  style: CustomWidget(context: context).CustomSizedTextStyle(
                      14.0,
                      Theme.of(context).primaryColor,
                      FontWeight.w500,
                      'FontRegular'),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(
                        left: 12, right: 0, top: 2, bottom: 2),
                    hintText: "9876543210",
                    hintStyle: CustomWidget(context: context).CustomSizedTextStyle(
                        14.0,
                        Theme.of(context).primaryColor.withOpacity(0.5),
                        FontWeight.w500,
                        'FontRegular'),
                    filled: true,
                    fillColor: Theme.of(context).errorColor.withOpacity(0.7),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0),
                      ),
                      borderSide: BorderSide(
                          color: Theme.of(context).dividerColor,
                          width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0),
                      ),
                      borderSide: BorderSide(
                          color: CustomTheme.of(context)
                              .splashColor
                              .withOpacity(0.5),
                          width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0),
                      ),
                      borderSide: BorderSide(
                          color: CustomTheme.of(context)
                              .splashColor
                              .withOpacity(0.5),
                          width: 1.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0),
                      ),
                      borderSide: BorderSide(
                          color: CustomTheme.of(context)
                              .splashColor
                              .withOpacity(0.5),
                          width: 1.0),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 30.0,),
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>
                            Forgot_Password()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                decoration: BoxDecoration(
                  // border: Border.all(
                  //   width: 1.0,
                  //   color: Theme.of(context).cardColor,
                  // ),
                  borderRadius: BorderRadius.circular(20.0),
                  color: Theme.of(context).dialogBackgroundColor,
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.instance
                        .text("loc_login_signin"),
                    style: CustomWidget(context: context)
                        .CustomSizedTextStyle(
                        17.0,
                        Theme.of(context).focusColor,
                        FontWeight.w600,
                        'FontRegular'),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 25.0,),
        ],
      ),
    );
  }


  verifyMail() {
    apiUtils
        .doLoginEmail(
      nameController.text.toString(),
      passController.text.toString(),)
        .then((Login loginData) {
      setState(() {
        if (loginData.success!) {
          setState(() {
            loading = false;
          });
          CustomWidget(context: context).
          custombar("Login", loginData.message.toString(), true);

          storeData(
              loginData.result!.token.toString(),
              loginData.result!.user!.id.toString(),
              loginData.result!.user!.email.toString(),
              loginData.result!.user!.role.toString(),
              loginData.result!.user!.name.toString());

          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) =>
                  TechHome()));

          nameController.clear();
          passController.clear();

        } else {

          loading = false;
          CustomWidget(context: context)
              .custombar("Login", loginData.message.toString(), false);

        }
      });

    }).catchError((Object error) {


      print(error);
      setState(() {
        loading = false;
      });
    });
  }


  void _onPressedShowBottomSheet() async {
    final country = await showCountryPickerSheets(
      context,
    );
    if (country != null) {
      setState(() {
        _selectedCountry = country;
      });
    }
  }

  storeData(String token, String userId, String email,String role, String name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("token", token);
    preferences.setString("userId", userId);
    preferences.setString("email", email);
    preferences.setString("roleType", role);
    preferences.setString("name", name);
  }

}
