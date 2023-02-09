import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_bloc_api/repository/home_repositiory.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FetchApi>((event, emit) async {
      try {
        emit(HomeLoading());
        var data = await HomeRepository.fetchDataFromApi();
        emit(DataLoaded(data: data));
      } catch (e) {
        emit(HomeError(error: e.toString()));
      }
    });
  }
}
