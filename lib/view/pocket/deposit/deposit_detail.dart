import 'package:abc_maung/view/widgets/dash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:abc_maung/constants/theme_color.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class DepositDetail extends StatelessWidget {
  DepositDetail({Key? key}) : super(key: key);
  final argu = Get.arguments;
  late int amount;
  late String date;
  late String name;
  late String tranId;
  void btnContinue() {
    Get.offAllNamed('/home');
    // Get.defaultDialog(
    //     title: 'Successfully Transfered \n🎉🎉🎉',
    //     titlePadding: const EdgeInsets.only(top: 30.0, bottom: 10.0),
    //     content: Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 20.0),
    //       child: Column(
    //         children: const [
    //           Text(
    //             'Your Payment is Successfully Transfered.Your balance will be soon.',
    //           ),
    //           SizedBox(
    //             height: 40.0,
    //           )
    //         ],
    //       ),
    //     ),
    //     actions: [
    //       Padding(
    //         padding:
    //             const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
    //         child: SizedBox(
    //           height: 50.0,
    //           width: double.infinity,
    //           child: ElevatedButton(
    //             onPressed: () => Get.back(),
    //             style: ElevatedButton.styleFrom(
    //                 primary: ThemeColors.lightGreen,
    //                 shape: RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.circular(20.0))),
    //             child: Text(
    //               'Continue',
    //               style: GoogleFonts.poppins(
    //                   fontSize: 18, fontWeight: FontWeight.w700),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ]);
  }

  @override
  Widget build(BuildContext context) {
    amount = argu['deposit_amt'];
    date = argu['date'];
    name = argu['name'];
    tranId = argu['transaction_id'];
    return Scaffold(
      backgroundColor: ThemeColors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leadingWidth: 26,
        titleSpacing: 0,
        iconTheme: const IconThemeData(color: Colors.greenAccent),
        backgroundColor: ThemeColors.white,
        elevation: 0,
        title: GestureDetector(
          onTap: () => Get.back(),
          child: Row(
            children: [
              clicktoback(),
              Text(
                'Transfer'.tr,
                style: GoogleFonts.poppins(
                    color: ThemeColors.lightGreen,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
      body: _buildlayout(),
      bottomNavigationBar: navbar(),
    );
  }

  Widget navbar() => Container(
        height: 95.0,
        decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Colors.grey.withOpacity(0.5)),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: Padding(
          padding:  
              const EdgeInsets.only(top: 16, left: 30, right: 30, bottom: 30),
          child: ElevatedButton(
            onPressed: () => btnContinue(),
            style: ElevatedButton.styleFrom(
                primary: ThemeColors.lightGreen,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0))),
            child: Text(
              'Continue'.tr,
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      );
Widget _buildlayout() => Container(
      margin: const EdgeInsets.fromLTRB(30, 30, 30, 30),
      child: Column(
        children: [
          firstrow(date,name),
          const SizedBox(height: 30),
          Dash(),
          const SizedBox(height: 22),
          secondrow(amount),
          const SizedBox(height: 22),
          Dash(),
          const SizedBox(height: 50),
          Text('If Any Issue Contact Customer Support\n With Following ID'.tr,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 12, fontWeight: FontWeight.w400
            )
          ),
          const SizedBox(height: 20),
          idBox(tranId),
        ],
      ),
    );

}

Widget firstrow(String date,String name) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(date,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                )),
            const SizedBox(
              height: 4,
            ),
            Text(name,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                )),
          ],
        ),
        Container(
          width: 65,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(10),
            //image: const DecorationImage(
            //image: AssetImage('assetName'),
            //fit: BoxFit.cover,
            //),
          ),
        ),
      ],
    );

Widget secondrow(int amount) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Total Payment'.tr,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            )),
        Text(amount.toString()+' MMK',
            style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: ThemeColors.lightGreen)),
      ],
    );

Widget idBox(String id) => Column(children: [
  Text(id,
    style: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: ThemeColors.lightGreen
    )
  ),
  TextButton.icon(
    onPressed: (){
      Clipboard.setData(ClipboardData(text: id));
      // Clipboard.getData(Clipboard.kTextPlain).then((value){ 
      //     print(value!.text); //value is clipbarod data
      // });
    },
    icon: Icon(Icons.copy,color: Colors.black,),
    label: Text('copy'.tr,style: TextStyle(color: Colors.black),),
  ),
],crossAxisAlignment: CrossAxisAlignment.center,);

Widget clicktoback() => Container(
  margin: const EdgeInsets.only(right: 15, left: 35),
  child: Icon(
    Icons.arrow_back_sharp,
    color: ThemeColors.lightGreen,
  ),
);

