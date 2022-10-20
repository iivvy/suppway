import 'dart:convert';

import 'package:flutter/foundation.dart';

class PaymentListModel {
  final List<Payment> payments;
  const PaymentListModel({this.payments = const []});
  factory PaymentListModel.fromMap(List<dynamic> payments) {
    return PaymentListModel(
      payments: List<Payment>.from(payments.map((x) => Payment.fromMap(x))),
    );
  }
  factory PaymentListModel.fromJson(String source) =>
      PaymentListModel.fromMap(json.decode(source));
  @override
  String toString() => 'paymentListModel(payment: $payments)';
  Map<String, dynamic> toMap() {
    return {
      'Payment': payments.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  PaymentListModel copyWith({
    List<Payment>? payments,
  }) {
    return PaymentListModel(
      payments: payments ?? this.payments,
    );
  }

  @override
  int get hashCode => payments.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentListModel && listEquals(other.payments, payments);
  }
}

class Payment {
  final int id;
  final String name;
  final String phone;
  final String email;
  String reciept;
  final double amount;

  Payment({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.reciept,
    required this.amount,
  });
  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      id: map['id'].toInt(),
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      reciept: map['reciept'],
      amount: map['amount'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'reciept': reciept,
      'amount': amount,
    };
  }

  @override
  String toString() {
    return 'payment(id: $id, name: $name, email: $email,  phone: $phone,reciept: $reciept, amount: $amount,)';
  }

  String toJson() => json.encode(toMap());

  factory Payment.fromJson(String source) =>
      Payment.fromMap(json.decode(source));

  Payment copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? reciept,
    double? amount,
  }) {
    return Payment(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      reciept: reciept ?? this.reciept,
      amount: amount ?? this.amount,
    );
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        reciept.hashCode ^
        amount.hashCode;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Payment &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.reciept == reciept &&
        other.amount == amount;
  }
}
