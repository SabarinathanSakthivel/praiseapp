import 'package:flutter/material.dart';

class Validator {
  final formkey = GlobalKey<FormState>();

  String? validateTextField(String? value) {
    if (value == null || value == '') {
      return 'This field is required';
    } else {
      return null;
    }
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return 'This field is required';
    } else if (value.length < 2) {
      return 'Name must be more than 1 charater';
    } else {
      return null;
    }
  }

  String? validateMobile(String? values) {
// Indian Mobile number are of 10 digit only
    String pattern = r'([0-9]{10}$)';
    RegExp regExp = RegExp(pattern);
    if (values == null || values == '') {
      return 'This field is required';
    } else if (values.length != 10) {
      return 'Mobile number must be of 10 digit';
    } else if (!regExp.hasMatch(values)) {
      return 'Enter valid mobile number';
    } else {
      return null;
    }
  }

  String? validateEmail(String? value) {
    String? pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (value == null || value == '') {
      return 'This field is required';
    } else if (!regex.hasMatch(value)) {
      return 'Enter valid email';
    } else {
      return null;
    }
  }

  String? validateAddress(String value) {
    if (value.isEmpty) {
      return 'This field is required';
    } else {
      return null;
    }
  }

  String? validatePassword(String? value) {
    if (value == '' || value == null) {
      return 'This field is required';
    } else if (value.length < 5) {
      return 'Enter a minimum 5 letters!';
    } else {
      return null;
    }
  }

  String? validateZipCode(String values) {
// Indian Mobile number are of 10 digit only
    if (values.isEmpty) {
      return 'This field is required';
    } else if (values.length != 6) {
      return 'Zip code must be of 6 digit';
    } else {
      return null;
    }
  }

  String? validatePasswordMatch(String? pass1, String? pass2) {
    if (pass1 != pass2) {
      return 'Password mismatch';
    } else if (pass1 == '' || pass2 == '') {
      return 'This field is required';
    } else {
      return null;
    }
  }

  bool validate() {
    if (formkey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
}
