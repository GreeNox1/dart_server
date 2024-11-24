class ApiResponse<T> {
  String? message;
  T? data;

  ApiResponse({this.message, this.data});

  Map<String, Object?> toJson() {
    return {
      'message': message,
      'data': data,
    };
  }

  @override
  String toString() {
    return "ApiResponse(message: $message, data: $data)\n";
  }
}