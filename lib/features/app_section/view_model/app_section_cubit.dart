import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/features/app_section/view_model/app_section_state.dart';

class AppSectionCubit extends Cubit<AppSectionState> {
  AppSectionCubit() : super(AppSectionInitialState());

  int currentIndex = 0;

  void changeTab(int index) {
    currentIndex = index;
    emit(AppSectionChangeTabState(index));
  }
}
