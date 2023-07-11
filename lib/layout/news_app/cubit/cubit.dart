import 'package:bloc/bloc.dart';
import 'package:firstapi_flutter/layout/news_app/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../modules/news_app/bussiness/bussiness_screen.dart';
import '../../../modules/news_app/science/science_screen.dart';
import '../../../modules/news_app/sports/sport_screen.dart';
import '../../../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business_sharp), label: 'Bisnis'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Olahraga'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Sains'),
  ];
  List<Widget> Screens = [
    BusinessScreen(),
    SportScreen(),
    ScienceScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;

    emit(NewsBottomNavstate());
  }

  List<dynamic> business = [];
  void getBusiness() {
    emit(NewsLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'id',
        'category': 'business',
        'apiKey': '6ea9bd7592da4c33bd7432f097894e4c',
      },
    ).then((value) {
      // print(value?.data.toString());
      business = value?.data['articles'];
      // print(business[0]['author']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      emit(NewsGetBusinessErrorState(error.toString()));
      print(error.toString());
    });
  }

  List<dynamic> sports = [];
  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'id',
          'category': 'sport',
          'apiKey': '6ea9bd7592da4c33bd7432f097894e4c',
        },
      ).then((value) {
        // print(value?.data.toString());
        sports = value?.data['articles'];
        // print(business[0]['author']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        emit(NewsGetSportsErrorState(error.toString()));
        print(error.toString());
      });
    } else {
      emit((NewsGetSportsSuccessState()));
    }
  }

  List<dynamic> science = [];
  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'id',
          'category': 'science',
          'apiKey': '6ea9bd7592da4c33bd7432f097894e4c',
        },
      ).then((value) {
        // print(value?.data.toString());
        science = value?.data['articles'];
        // print(business[0]['author']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        emit(NewsGetScienceErrorState(error.toString()));
        print(error.toString());
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];
  void getSearch(String value) {
    emit(NewsGetScienceLoadingState());
    search = [];
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': '6ea9bd7592da4c33bd7432f097894e4c',
      },
    ).then((value) {
      search = value?.data['articles'];
      // print(search[0]['author']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      emit(NewsGetScienceErrorState(error.toString()));
      print(error.toString());
    });

    emit(NewsGetSearchSuccessState());
  }
}
