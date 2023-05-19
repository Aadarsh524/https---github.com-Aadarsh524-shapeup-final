import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Events

abstract class RegisterEvent {}

class RegisterTextChangedEvent extends RegisterEvent {
  final String firstName;
  final String lastName;
  final String phone;
  RegisterTextChangedEvent(
    this.firstName,
    this.lastName,
    this.phone,
  );
}

class RegisterSubmitEvent extends RegisterEvent {
  final String firstName;
  final String lastName;
  final String phone;
  RegisterSubmitEvent(
    this.firstName,
    this.lastName,
    this.phone,
  );
}

//States

abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterValidState extends RegisterState {}

class RegisterFirstNameErrorState extends RegisterState {
  final String errorMessage;
  RegisterFirstNameErrorState(this.errorMessage);
}

class RegisterLastNameErrorState extends RegisterState {
  final String errorMessage;
  RegisterLastNameErrorState(this.errorMessage);
}

class RegisterPhoneErrorState extends RegisterState {
  final String errorMessage;
  RegisterPhoneErrorState(this.errorMessage);
}

class RegisterCubit extends Cubit<RegisterState> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  RegisterCubit() : super(RegisterInitialState());

  bool validateFirstName(String firstName) {
    if (firstName == '') {
      emit(RegisterFirstNameErrorState("First Name cannot be Empty"));
      return false;
    }
    return true;
  }

  bool validateLastName(String lastName) {
    if (lastName == '') {
      emit(RegisterLastNameErrorState("Last Name cannot be Empty"));
      return false;
    }
    return true;
  }

  bool validatePhone(String phone) {
    if (phone == '') {
      emit(RegisterPhoneErrorState("Phone cannot be Empty"));
      return false;
    } else if (phone.length < 10) {
      emit(RegisterPhoneErrorState("Invalid phone number"));
      return false;
    }
    return true;
  }

  void validate(String firstName, String lastName, String phone) {
    bool validate = validateFirstName(firstName.toString()) &&
        validateLastName(lastName.toString()) &&
        validatePhone(phone);

    if (validate == false) {
    } else {
      emit(RegisterValidState());
    }
  }
}
