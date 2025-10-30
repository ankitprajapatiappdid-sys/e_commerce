import 'package:get/get.dart';

import '../../services/constants.dart';
import '../api/api_client.dart';

class BasicRepo {
  final ApiClient apiClient;
  BasicRepo({required this.apiClient});

  //----get bussiness setting----
  Future<Response> getBussinessSettingData() async =>
      await apiClient.getData(AppConstants.businessSettingUri);
}
