// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:rxdart/rxdart.dart';

// class RegisterBloc {
//   final _firstNameController = BehaviorSubject<String>();
//   final _lastNameController = BehaviorSubject<String>();
//   final _phoneController = BehaviorSubject<String>();

//   // Input streams
//   Function(String) get changeFirstName => _firstNameController.sink.add;
//   Function(String) get changeLastname => _lastNameController.sink.add;
//   Function(String) get changePhone => _phoneController.sink.add;

//   // Validators
//   Stream<String> get firstName =>
//       _firstNameController.stream.transform(validateFirstName);
//   Stream<String> get lastName =>
//       _lastNameController.stream.transform(validateLastName);
//   Stream<String> get phone => _phoneController.stream.transform(validatePhone);

//   Stream<bool> get isValid =>
//       Rx.combineLatest3(firstName, lastName, phone, (n, e, p) => true);

//   // Submit button
//   Stream<bool> get submitValid =>
//       Rx.combineLatest3(firstName, lastName, phone, (n, e, p) => true);

//   // Validators
//   final validateFirstName = StreamTransformer<String, String>.fromHandlers(
//       handleData: (firstName, sink) {
//     if (firstName.isEmpty) {
//       sink.addError('Please enter your name');
//     } else {
//       sink.add(firstName);
//     }
//   });

//   final validateLastName = StreamTransformer<String, String>.fromHandlers(
//       handleData: (lastName, sink) {
//     if (lastName.isEmpty) {
//       sink.addError('Please enter your email address');
//     } else {
//       sink.add(lastName);
//     }
//   });

//   final validatePhone =
//       StreamTransformer<String, String>.fromHandlers(handleData: (phone, sink) {
//     if (phone.isEmpty) {
//       sink.addError('Please enter your password');
//     } else if (phone.length < 10) {
//       sink.addError('Invalid Phone Number characters');
//     } else {
//       sink.add(phone);
//     }
//   });

//   dispose() {
//     _firstNameController.close();
//     _lastNameController.close();
//     _phoneController.close();
//   }
// }
