import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firstapi_flutter/layout/news_app/cubit/cubit.dart';
import 'package:firstapi_flutter/shared/componenets/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/news_app/cubit/states.dart';

class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        var list= NewsCubit.get(context).business;
        return articleBuilder(list , context);

      },
    );
  }
}
