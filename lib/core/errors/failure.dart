

import 'package:equatable/equatable.dart';
import 'package:weather_app/core/errors/exceptions.dart';

abstract class Failure extends Equatable{
  final String message;
  final int statusCode;

  const Failure({required this.message, required this.statusCode});

  String get errorMessage => '$statusCode Error: $message';

  @override
  List<Object> get props => [message, statusCode];
}

class ApiFailure extends  Failure{
  const ApiFailure({required super.message, required super.statusCode});
  ApiFailure.fromException(ApiException apiException): this(message: apiException.message, statusCode:  apiException.statusCode);
}