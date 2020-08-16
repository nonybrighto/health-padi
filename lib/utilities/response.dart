/// A response to be sent after ans async operation usually within the provider models

class Response {
  bool success;
  String message;
  Response(this.success, this.message);
}
