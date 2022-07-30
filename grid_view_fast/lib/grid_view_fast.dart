library grid_view_fast;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class GridViewFast extends StatelessWidget {
  List data;
  GridViewFast({ Key? key ,required this.data}) : super(key: key);
  TextStyle abcStyle(double size,FontWeight fontWeight,Color color) => GoogleFonts.poppins(
    fontSize: size,
    fontWeight: FontWeight.w700,
    color: color
  );
// gridView({required List data})=> 
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 5,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
    ),
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: data.length,
    itemBuilder: (context,index){
      String name = data[index]['name'];
      Function onTap = data[index]['tab'];
      if(name=='') return Container();
      return GestureDetector(
        onTap: ()=> onTap(),
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(11, 50, 28, 1),
            borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          child: Text(name,style: abcStyle(14, FontWeight.normal, Colors.white),),
          alignment: Alignment.center,
        ),
      );
    }
  );
  }
}