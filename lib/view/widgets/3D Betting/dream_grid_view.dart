import 'package:abc_maung/view/home/3d/three_d_betting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore_for_file: invalid_use_of_protected_member
// ignore: must_be_immutable
class DreamGridView extends StatelessWidget {
  Function select;
  Function getIndex;
  Function isSelected;
  Function getPercent;
  Map<String,dynamic> boxColor;
  DreamGridView({
    Key? key,
    required this.select,
    required this.getIndex,
    required this.isSelected,
    required this.getPercent,
    required this.boxColor,
  }) : super(key: key);
  ThreeDBetController _tctrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx( ()=> GridView.builder(
      itemCount: _tctrl.dreamData.value.length + (_tctrl.ctrl.value['active']>0?0:0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 20.0,
        childAspectRatio: 0.50890585,
        crossAxisCount: 3,
      ),
      itemBuilder: (context,i){
        String title = _tctrl.dreamData.value[i]['title'];
        String url = _tctrl.dreamData.value[i]['url'];
        String numL = _tctrl.dreamData.value[i]['numL'];
        int indexL = getIndex(numL);
        bool isLSelect = isSelected(indexL);
        double percentL = getPercent(indexL);
        String numR = _tctrl.dreamData.value[i]['numR'];
        int indexR = getIndex(numR);
        bool isRSelect = isSelected(indexR);
        double percentR = getPercent(indexR);
        // color
        var primary = boxColor['primary'];
        var secoundry = boxColor['secoundry'];
        var border = boxColor['border'];
        return Container(
          child: Column(children: [
            Expanded(
              flex: 70,
              child: InkWell(
                onTap: (){
                  select(indexL, percentL, isLSelect);
                  select(indexR, percentR, isRSelect);
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(38, 38, 38, 1),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(7.0),
                      topLeft: Radius.circular(7.0)
                    )
                  ),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
            ),
            Expanded(
              flex: 243,
              child: InkWell(
                onTap: (){
                  select(indexL, percentL, isLSelect);
                  select(indexR, percentR, isRSelect);
                },
                child: Container(
                  child: FadeInImage(
                    image: NetworkImage(url),
                    placeholder: AssetImage('assets/icon/dream.png'),
                  ),
                ),
              )
            ),
            Expanded(
              flex: 80,
              child: Container(
                child: Row(children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        select(indexL, percentL, isLSelect);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 4.0,
                            color: isLSelect?
                              border['select']:
                              percentL<50?border['high']:
                              percentL<=90?border['mid']:
                              percentL<100?border['low']:
                              border['close']
                          ),
                          color: isLSelect?
                            primary['select']:
                            percentL<50?primary['high']:
                            percentL<=90?primary['mid']:
                            percentL<100?primary['low']:
                            primary['close'],
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(7.0)
                          )
                        ),
                        child: Text(
                          numL,
                          style: TextStyle(
                            fontSize: 14,
                            color: isLSelect?
                              secoundry['select']:
                              percentL<50?secoundry['high']:
                              percentL<=90?secoundry['mid']:
                              percentL<100?secoundry['low']:
                              secoundry['close']
                          ),
                        ),
                      ),
                    )
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        select(indexR, percentR, isRSelect);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 4.0,
                            color: isRSelect?
                              border['select']:
                              percentR<50?border['high']:
                              percentR<=90?border['mid']:
                              percentR<100?border['low']:
                              border['close']
                          ),
                          color: isRSelect?
                            primary['select']:
                            percentR<50?primary['high']:
                            percentR<=90?primary['mid']:
                            percentR<100?primary['low']:
                            primary['close'],
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(7.0)
                          )
                        ),
                        child: Text(
                          numR,
                          style: TextStyle(
                            fontSize: 14,
                            color: isRSelect?
                              secoundry['select']:
                              percentR<50?secoundry['high']:
                              percentR<=90?secoundry['mid']:
                              percentR<100?secoundry['low']:
                              secoundry['close']
                          ),
                        ),
                      ),
                    )
                  )
                ],),
              )
            ),
          ],),
        );
      }
    ));
  }
}