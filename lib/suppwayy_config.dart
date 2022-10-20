class SuppWayy {
  static const String login =
      'http://auth.ttk-test.xyz/auth/realms/SpringBootKeycloak/protocol/openid-connect/token';

  static const manufacturingBaseUrl = 'https://manufacturing.ttk-test.xyz';
  // static const manufacturingBaseUrl = 'http://192.168.1.13:8086';
  static const baseUrl = 'https://sale.ttk-test.xyz';
  // static const baseUrl = 'http://192.168.1.13:8086';

  static const baseApiUrl = '$baseUrl/api';
  static const manufacturingBaseApiUrl = '$manufacturingBaseUrl/api';
  static const String profile = '$baseApiUrl/my/';
  static const String profilePhoto = '$baseApiUrl/my/photo';
  static const String getManufacturingProducts =
      '$manufacturingBaseApiUrl/manufacturing/products/';

  static const String getProducts = '$baseApiUrl/products/';
  static const String getSalesOrder = '$baseApiUrl/sale/orders/';
  static const String getPartners = '$baseApiUrl/contacts/';
  static const String getLocations = '$baseApiUrl/locations/';
  static const String trace = '$baseApiUrl/trace/';
  static const String getDeliveries = '$baseApiUrl/sale/deliveries/';

  static const String authorize = '$baseApiUrl/my/authorize/';
  static const String deauthorize = '$baseApiUrl/my/deauthorize/';
  static const String authorizeReturn = '$baseApiUrl/my/authorize-return/';
  static const String chargeList = '$baseApiUrl/my/charge-list/';
  static const String getManufactoringOrder =
      '$manufacturingBaseApiUrl/manufacturing/orders/';

  static String getManufacturingLineUrl(int manufacturingorderId) {
    return "$manufacturingBaseApiUrl/manufacturing/orders/$manufacturingorderId/lines";
  }

  static String getLinesUrl(int saleorderId) {
    return "$baseApiUrl/sale/orders/$saleorderId/lines";
  }

  static String getOptionalLinesUrl(int saleorderId) {
    return "$baseApiUrl/sale/orders/$saleorderId/optional-lines";
  }

  static String getPrintUrl(int saleorderId) {
    return "$baseApiUrl/sale/orders/$saleorderId/print";
  }

  static String getSendUrl(int saleorderId) {
    return "$baseApiUrl/sale/orders/$saleorderId/send";
  }

  static String getLotUrl(int? productId) {
    return "$baseApiUrl/products/$productId/lots";
  }

  static String getContactsPhoto(int? partnerId) {
    return "$getPartners$partnerId/photo";
  }

  static String getProductMedias(int? productId) {
    return "$getProducts$productId/medias";
  }

  static String getProductImage(int? productId) {
    return "$getProducts$productId/image";
  }

  static String deleteLot(int productId, int lotId) {
    return "$getProducts$productId/lots/$lotId";
  }

  static String postDeliveries(int deliveryId) {
    return "$baseApiUrl/sale/deliveries/$deliveryId";
  }

  static String getDeliveryLine(int deliveryId, int deliveryLineId) {
    return "$baseApiUrl/sale/deliveries/$deliveryId/line/$deliveryLineId";
  }
}
