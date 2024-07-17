extension StringParams on String {
  String params(Map<String, dynamic> params) {
    String text = this;

    params.forEach((key, value) {
      text = text.replaceAll("{$key}", "$value");
    });

    return text;
  }
}
