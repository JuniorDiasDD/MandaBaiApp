import 'package:email_validator/email_validator.dart';

const noSpecialCharactersRegex = r'[!@#$%^&*?":{}|<>]';
const noSpecialCharactersStrictRegex = r'[!@#$%^&*(),?":{}|<>]';
const noNumberCharactersStrictRegex = r'[0-9]';



bool validateEmail(String email) => EmailValidator.validate(email);
