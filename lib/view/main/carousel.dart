import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ABCCarousel extends StatelessWidget {
  EdgeInsets edgeInsets;
  List<AssetImage> children;
  int intervel;
  int speed;
  ABCCarousel({
    Key? key ,
    required this.edgeInsets,
    required this.children,
    this.intervel=5000,
    this.speed=500
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    CarouselController _carouselController = Get.put(CarouselController(
      childLength: children.length,
      cardWidth: Get.width-(edgeInsets.left+edgeInsets.right),
      speed: speed,
      intervel: intervel,
    ));  
    return Padding(
      padding: edgeInsets,
      child: ListView.builder(
        controller: _carouselController.scroll,
        // physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: children.length,
        itemBuilder: (BuildContext context,int index)=>Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 5.0),
          child: Container(
            // width: Get.width-(edgeInsets.left+edgeInsets.right),
            width: Get.width-60,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                image: children[index],
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2.0,
                  blurRadius: 2.0,
                  offset: const Offset(2, 2)
                )
              ]
            ),
          ),
        )
      ),
    );
  }
}

class CarouselController extends GetxController{
  int childLength;
  double cardWidth;
  double current=0.0;
  bool active = true;
  int intervel;
  int speed;
  CarouselController({required this.childLength,required this.cardWidth, this.intervel=5000,this.speed=500});
  ScrollController scroll = ScrollController();
  @override
  void onInit() {
    super.onInit();
    autoSlide();
    // scroll.addListener(()=>check());
  }
  @override
  void onClose() {
    active=false;
    super.onClose();
  }

  // void check(){
  //   if(scroll.hasClients){
  //    print(scroll.offset);
  //   }
  // }

  void autoSlide() async{
    while(true){
      if(current>=(cardWidth*3)){
        current = 0.0;
      }else{
        current += cardWidth;
      }
      await Future.delayed(Duration(milliseconds: intervel),(){
        if(scroll.hasClients){
          scroll.animateTo(
            current,
            duration: Duration(milliseconds: speed),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }
}