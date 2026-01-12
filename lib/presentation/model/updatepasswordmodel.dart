class ChangePasswordResponse {
  final bool success;
  final PasswordMessage message;

  ChangePasswordResponse({required this.success, required this.message});

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponse(
      success: json['success'],
      message: PasswordMessage.fromJson(json['message']),
    );
  }
}

class PasswordMessage {
   bool? success;
   String? message;
   int? recordId;

  PasswordMessage({
     this.success,
     this.message,
     this.recordId,
  });

  factory PasswordMessage.fromJson(Map<String, dynamic> json) {
    return PasswordMessage(
      success: json['success'],
      message: json['message'],
      recordId: json['recordId'],
    );
  }
}
