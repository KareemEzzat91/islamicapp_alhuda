import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:islamicapp_alhuda/Screens/HomeScreen/Hijb/Hijbwidget.dart';
import 'package:islamicapp_alhuda/Screens/HomeScreen/Pagewidget/Pagewidget.dart';
import 'package:islamicapp_alhuda/Screens/HomeScreen/Parawidget/Parawidget.dart';

import 'Surahwidget/surahwidget.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}
class _homeScreenState extends State<homeScreen> {
  int index =0;
  @override
  Widget build(BuildContext context) {
    List Screens =[
      surahwidget (),
      Parawidget(),
      Pagewidget(),
      hijbwidget(),
    ];
    return Scaffold(
      appBar:AppBar( backgroundColor: Colors.white,leading:const Icon(Icons.menu,color:Colors.grey ,) ,title: Text("AL-HUDA",style: TextStyle(color:Color(0xff672CBC),fontWeight: FontWeight.bold ),),actions: [Icon(Icons.search)],),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
         child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Container(
                width: double.infinity,
                height: 185,
                decoration:  BoxDecoration(
        
                  gradient:  const LinearGradient(colors:[
                    Color(0xffDF98FA),
        
                    Color(0xff9055FF),
        
        
                  ],begin: Alignment.topLeft ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child:  Stack(
                  children: [
                    Positioned(top: 60,right: 0,child: ClipRect(child: Image.asset("assets/images/Group.png",scale: 0.78,),)),
                    const Positioned(left: 10 ,child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Row(
                            children: [
        
                              Icon(Icons.menu_book_outlined,color: Colors.white,size: 20,),SizedBox(width: 10,),
                              Text("Last Read",style: TextStyle(fontSize: 20,color: Colors.white),),
                            ],
                          ),
        
                        ),
                        Text("Al-Fatiah",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30),),
                        Text("Ayah No: 1",style: TextStyle(color: Colors.white54,fontSize: 20),)
        
                      ],
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
        
              CustomSlidingSegmentedControl<int>(
        
                isStretch: true,
                height: 50,
                fixedWidth: 90,
                initialValue: 1,
                children: {
                  1: Text('Surah',style: TextStyle(color: index==0?Colors.white: Color(0xff8789A3),fontSize: 20,),),
                  2: Text('Para',style: TextStyle(color:index==1?Colors.white: Color(0xff8789A3),fontSize: 20)),
                  3: Text('Page',style: TextStyle(color:index==2?Colors.white: Color(0xff8789A3),fontSize: 20)),
                  4: Text('Hijb',style: TextStyle(color:index==3?Colors.white: Color(0xff8789A3),fontSize: 20)),
        
        
                },
                decoration: BoxDecoration(
        
        
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                thumbDecoration: BoxDecoration(
        
                  color: Color(0xff994EF8),
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.3),
                      blurRadius: 4.0,
                      spreadRadius: 1.0,
                      offset: const Offset(
                        0.0,
                        2.0,
                      ),
                    ),
                  ],
                ),
                duration: Duration(milliseconds: 200),
                curve: Curves.easeInToLinear,
                onValueChanged: (v) {
                  setState(() {
                    index=v-1;

                  });
                },
              ),
              const Divider(),
              Container(child:   Screens[index] )
        
        
            ],
          ),
        ),
      ),

    );
  }

}

