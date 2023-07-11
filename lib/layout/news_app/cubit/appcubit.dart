
import 'package:bloc/bloc.dart';
import 'package:firstapi_flutter/layout/news_app/cubit/states.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/network/remote/dio_helper.dart';
import 'app_states.dart';
class AppCubit extends Cubit<AppStates> {

  AppCubit() : super(AppInintState());
  static AppCubit get(context) => BlocProvider.of(context);
  bool isDark = false;
  void changeAppMode({ bool? fromShared})
  {
    if(fromShared != null) {
      isDark = fromShared;
      emit(ChangeThemeData());

    }
    else{
      isDark = !isDark;
    CacheHelper.putData(key:'isDark', value: isDark);
    emit(ChangeThemeData());
  }
  }
}