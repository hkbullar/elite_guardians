
import 'package:elite_guardians/global/AA.dart';
import 'package:elite_guardians/global/AppColours.dart';
import 'package:elite_guardians/global/Constants.dart';
import 'package:elite_guardians/global/Size.dart';
import 'package:elite_guardians/screens/BookJourneyScreen.dart';
import 'package:elite_guardians/screens/HireGuardScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class HomeScreen extends StatefulWidget
{
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> securityUsersList=[];
  String dropDownValue;

  @override
  void initState()
  {
    securityUsersList.add("Steward");
    securityUsersList.add("Security Guard");
    securityUsersList.add("Door Supervisor");
    securityUsersList.add("Close Protection Officer");
    securityUsersList.add("CSAS Officer");

    dropDownValue=securityUsersList[0];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size().init(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            shrinkWrap: true,
            padding: EdgeInsets.all(0),
            physics: NeverScrollableScrollPhysics(),
            children: List.generate(3,(index){
              return _listItem(index);
            })
        )
      )
    );
  }
  payViaNewCard(BuildContext context) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();
    var response =
    await StripeService.payWithNewCard(amount: "11", currency: 'USD');
    await dialog.hide();
    print(response.message);

  }
  Widget _listItem(int index){
   return  InkWell(
     onTap: (){
       if(index==0)
       {
        // payViaNewCard(context);
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => BookJourneyScreen()));
       }

       if(index==1)
       {
         Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HireGuardScreen()));
       }

       if(index==2)
       {
         securityOfficerTypesDialogue(context);
       }
     },
     child: Card(
       color: AppColours.textFeildBG,
       child: Padding(
         padding: EdgeInsets.all(25.0),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Image.asset(index==0?"${Constants.LOCAL_IMAGE}home_car.png":index==1?"${Constants.LOCAL_IMAGE}guardians.png":"${Constants.LOCAL_IMAGE}security_officer.png",height: Size.size(50),),
             SizedBox(height: Size.size(20)),
             Text(index==0?"Book a Journey":index==1?"Hire a Guardian":"Need Security Officer",textAlign: TextAlign.center,style: TextStyle(fontSize: Size.size(14),color: AppColours.white,fontWeight: FontWeight.bold),)
           ]),
       ),
     ),
   );
  }
  securityOfficerTypesDialogue(BuildContext context) {
    Dialog alert = Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        elevation: 0.0,
        backgroundColor: Colors.black,
        child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState){
          return Container(
            child: securityOfficerTypesUI(setState),
          );
        }
        ));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
 Widget securityOfficerTypesUI(StateSetter setState){
    return   Container(
      decoration: BoxDecoration(
          color: AppColours.golden_button_bg,
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      padding: EdgeInsets.all(Size.size(15)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(child: Text("Please Select:",style: TextStyle(color: AppColours.black,fontWeight: FontWeight.bold,fontSize: Size.size(18)),)),
              InkWell(
                onTap: (){Navigator.of(context).pop();},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.close, color: Colors.black),
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
                color: AppColours.textFeildBG,
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  value: dropDownValue,
                  isExpanded: true,
                  dropdownColor: AppColours.textFeildBG,
                  focusColor: AppColours.golden_button_bg,
                  onChanged: (String newValue)
                  {
                    setState(()
                    {
                      dropDownValue=newValue;
                    });
                    Navigator.of(context).pop();
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HireGuardScreen(title: dropDownValue,)));
                  },
                  items:securityUsersList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style: TextStyle(color: AppColours.white,fontSize: Size.size(14)),),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}