//reutrn today date formatted as yyyymmdd
String getTodayDate() {
  // Get today's date
  var today = DateTime.now();

  // Format the date as YYYYMMDD
  //year format to yyyy
  String year = today.year.toString();
  //Fortmat the month to MM
  String month = today.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }
  //Format the day to dd
  String day = today.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  // Combine the formatted date components
  String formattedDate = year + month + day;

  return formattedDate;
}

//Heatmpa need it as an object to store the date and the number of habits completed
DateTime createDateTimeObject(String yyymmdd) {
  // Extract year, month, and day from the string
  int year = int.parse(yyymmdd.substring(0, 4));
  int month = int.parse(yyymmdd.substring(4, 6));
  int day = int.parse(yyymmdd.substring(6, 8));

  // Create a DateTime object
  DateTime dateTime = DateTime(year, month, day);

  return dateTime;
}

//convert date obj to string
String convertDateTimeToString(DateTime dateTime) {
  String year = dateTime.year.toString();
  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }
  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  // Combine the formatted date components
  String formattedDate = year + month + day;

  return formattedDate;
}
