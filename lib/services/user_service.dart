import 'package:mh_core/services/api_service.dart';
import 'package:mh_core/utils/global.dart';
import 'package:perfecto/models/address_model.dart';

import '../models/user_model.dart';
import '../utils.dart';

class UserService{
  static Future<UserModel> userProfileCall() async{
    UserModel userModel =UserModel();
    final response = await ServiceAPI.genericCall(url: '${ServiceAPI.apiUrl}profile', httpMethod: HttpMethod.get);
    globalLogger.d(response,"Profile route");
    if (response['status'] != null && response['status']) {
      userModel = UserModel.fromJson(response['data']);
    } else if (response['status'] != null && !response['status']) {
      ServiceAPI.showAlert(response['message']);
    }
    return userModel;
  }
  static Future<bool> updateProfile (dynamic body)async{
    final response = await ServiceAPI.genericCall(url: '${ServiceAPI.apiUrl}edit', httpMethod: HttpMethod.multipartFilePost,allInfoField: body,isLoadingEnable: true);
    globalLogger.d(response, "Profile Update Route");
    if (response['status'] != null && response['status']) {
      return response['status'];
    } else if (response['status'] != null && !response['status']) {
      ServiceAPI.showAlert(response['message']);
    }
    return false;
  }
  static Future<Map<DataType, List<dynamic>>> getAreaData() async {
    List<DistrictModel> dislist = [];
    List<CityModel> areaList = [];
    final response = await ServiceAPI.genericCall(
      url: '${ServiceAPI.apiUrl}district',
      httpMethod: HttpMethod.get,
      noNeedAuthToken: false,
    );
    final response2 = await ServiceAPI.genericCall(
      url: '${ServiceAPI.apiUrl}city?district_id=1/*${dislist.map((e) => e.id)}*/',
      httpMethod: HttpMethod.get,
      noNeedAuthToken: false,
    );
    globalLogger.d(response, "Get District Route");
    globalLogger.d(response2, "Get Area Route");
    // Get.back();
    if (response['status'] != null && response['status']) {
      response['data']['Districts'].forEach((dis) {
        dislist.add(DistrictModel.fromJson(dis));
      });
    } else if (response['status'] != null && !response['status']) {
      ServiceAPI.showAlert(response['message']);
    }
    if (response2['status'] != null && response2['status']) {
      response2['data']['Cities'].forEach((course) {
        areaList.add(CityModel.fromJson(course));
      });
    } else if (response2['status'] != null && !response2['status']) {
      ServiceAPI.showAlert(response2['message']);
    }
    return {
      DataType.district: dislist,
      DataType.area: areaList,
    };
  }

  static Future<List<AddressModel>> userAddressCall() async{
   List<AddressModel> addressModel =[];
    final response = await ServiceAPI.genericCall(url: '${ServiceAPI.apiUrl}get_address', httpMethod: HttpMethod.get);
    globalLogger.d(response,"AddressModel route");
    if (response['status'] != null && response['status']) {
      response['data'].forEach((dis) {
        addressModel.add(AddressModel.fromJson(dis));
      });
    } else if (response['status'] != null && !response['status']) {
      ServiceAPI.showAlert(response['message']);
    }
    return addressModel;
  }
}