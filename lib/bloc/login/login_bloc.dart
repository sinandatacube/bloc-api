import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_bloc_api/controller/Login_controller.dart';
import 'package:simple_bloc_api/model/login_model.dart';
import 'package:simple_bloc_api/repository/home_repositiory.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonClick>((event, emit) async {
      emit(Loading());

      if (event.id.isEmpty) {
        emit(Error(error: 'Empcode is Empty'));
      } else if (event.password.isEmpty) {
        emit(Error(error: 'Password is Empty'));
      } else {
        String? imei = await LoginController().getImei();

        if (imei != null) {
          Map<String, dynamic> responseData =
              await HomeRepository.authentication(
                  psw: event.password, id: event.id, imei: imei);

          if (responseData['success'] == 0) {
            emit(Error(error: responseData['message']));
          } else {
            AllLoginModel empDetails = AllLoginModel.fromJson(responseData);
            emit(AuthSuccess(empDetails: empDetails));
          }
        } else {
          emit(Error(error: "Failed to get imei"));
        }
      }
    });
  }
}
