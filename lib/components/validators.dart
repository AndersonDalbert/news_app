class Validators {
  /*
    Validator for email. Requires that the field is not null or empty. Uses a
    regular expression to grant that the email is valid.
  */
  static String emailValidator(String value) {
    if (value == null) return 'Campo obrigatório';
    if (value.length == 0) return 'Campo obrigatório';
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Formato de e-mail inválido';
    } else {
      return null;
    }
  }

  /*
    Validator for passwords. Requires that the field is not null or empty,
    and asks for length greater or equal 8.
  */
  static String pwdValidator(String value) {
    if (value == null) return 'Campo obrigatório';
    if (value.length == 0) return 'Campo obrigatório';

    if (value.length < 8) {
      return 'A senha precisa ter mais de 8 caracteres';
    } else {
      return null;
    }
  }
}
