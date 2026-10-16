abstract class AppSectionState {}

class AppSectionInitialState extends AppSectionState {}

class AppSectionChangeTabState extends AppSectionState {
  final int currentIndex;

  AppSectionChangeTabState(this.currentIndex);
}
