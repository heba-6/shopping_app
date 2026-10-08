import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/features/home/domain/use_case/get_all_product_use_case.dart.dart';
import 'package:shopping_app/features/home/presentation/view_model/home_cubit.dart';

part 'home_cubit.dart';

sealed class HomeIntent {}

class HProducts extends Cubit<HomeState> {}
