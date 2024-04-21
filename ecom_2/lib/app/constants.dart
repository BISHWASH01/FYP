// var ipAddress = '192.168.30.54';
// var ipAddress = '192.168.0.15';
// var ipAddress = '192.168.100.13';
var ipAddress = '192.168.1.79';

var getImageUrl = (imageUrl) {
  return 'http://$ipAddress/ecom_api/$imageUrl';
};

var formatDate = (DateTime? date) {
  if (date == null) return '-';
  return '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}';
};
