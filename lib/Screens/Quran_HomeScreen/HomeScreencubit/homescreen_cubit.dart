import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';


part 'homescreen_state.dart';

class HomescreenCubit extends Cubit<HomescreenState> {
  HomescreenCubit() : super(HomescreenInitial());

  String surahname ="AL-Fatiah";
  int  Ayahnum =1;
  void change (String name ,int num ){
    surahname=name ;
    Ayahnum=num ;
    emit(SuccesState());
  }
}
