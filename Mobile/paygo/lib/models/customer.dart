import 'package:intl/intl.dart';

class Customer {
  late int id, phoneNumber;
  late String username,region,coordinates;
  late double amountRepaid,loanAmount,arrearsPrepayment;
  late DateTime expectedPayDate;

  Customer({
    required this.id,
    required this.username,
    required this.amountRepaid,
    required this.arrearsPrepayment,
    required this.coordinates,
    required this.expectedPayDate,
    required this.loanAmount,
    required this.phoneNumber,
    required this.region
  });

  factory Customer.fromJSON(Map<String, dynamic> parseJson){
    return Customer(
        id: parseJson['id'] ,
        username: parseJson['username'] as String,
        amountRepaid: parseJson['amount_repaid'] as double,
        arrearsPrepayment: parseJson['arrears_prepayment'] as double,
        coordinates: parseJson['coordinates'] as String,
        expectedPayDate: DateTime.tryParse(parseJson['expected_pay_date']) as DateTime,
        loanAmount: parseJson['loan_amount'] as double,
        phoneNumber: int.tryParse(parseJson['phone_number']) as int,
        region: parseJson['region'] as String,
    );
  }


}