import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit/cubit/app_cubit_states.dart';
import 'package:flutter_cubit/cubit/app_cubits.dart';
import 'package:flutter_cubit/pages/detail_page.dart';
import 'package:flutter_cubit/pages/navpages/main_page.dart';
import 'package:flutter_cubit/pages/welcome_page.dart';
import 'package:flutter_cubit/widgets/app_large_text.dart';

class AppCubitLogics extends StatefulWidget {
  const AppCubitLogics({Key? key}) : super(key: key);

  @override
  _AppCubitLogicsState createState() => _AppCubitLogicsState();
}

class _AppCubitLogicsState extends State<AppCubitLogics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubits, CubitStates>(
        builder: (context, state){
          if(state is DetailState){
            return const DetailPage();
          }else if(state is WelcomeState){
            return const WelcomePage();
          }else if(state is LoadedState){
            return const MainPage();
          }else if(state is LoadingState){
            return const Center(child: CircularProgressIndicator(),);
          }else if (state is ErrorState) {
            return Center(child: AppLargeText(text: state.message));
          }else{
            return Center(child: AppLargeText(text: 'BLoC Failed'));
          }
        },
      ),
    );
  }
}