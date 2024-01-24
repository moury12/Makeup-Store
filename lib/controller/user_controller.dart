import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mh_core/utils/global.dart';
import 'package:perfecto/models/address_model.dart';
import 'package:perfecto/models/user_model.dart';
import 'package:perfecto/services/user_service.dart';

import '../utils.dart';

class UserController extends GetxController {
  static UserController get to => Get.find();
  UserModel get getUserInfo => userInfo.value;
  Rx<UserModel> userInfo = UserModel().obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameEditAddressController = TextEditingController();
  TextEditingController emailEditAddressController = TextEditingController();
  TextEditingController phoneEditAddressController = TextEditingController();
  TextEditingController addressEditAddressController = TextEditingController();
  TextEditingController nameAddNewAddressController = TextEditingController();
  TextEditingController emailAddNewAddressController = TextEditingController();
  TextEditingController phoneAddNewAddressController = TextEditingController();
  TextEditingController addressAddNewAddressController =
      TextEditingController();
  Rx<String?> errorName = ''.obs;
  Rx<String?> errorEmail = ''.obs;
  Rx<String?> errorPhone = ''.obs;
  Rx<String?> errorAddNewName = ''.obs;
  Rx<String?> errorAddNewEmail = ''.obs;
  Rx<String?> errorAddNewPhone = ''.obs;
  Rx<String?> errorAddNewAddress = ''.obs;
  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  Rx<File> pickedImage = File('').obs;
RxString image=''.obs;
  @override
  void onReady() async {
    await getUserInfoCall();

    super.onReady();
  }
editController(UserModel userModel){
  nameController.text = userModel.name??'';
  emailController.text = userModel.email??'';
  phoneController.text = userModel.phone??'';
  image.value=userModel.avatar??'';
}
  @override
  void onClose() async {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    nameAddNewAddressController.dispose();
    emailAddNewAddressController.dispose();
    phoneAddNewAddressController.dispose();
    addressAddNewAddressController.dispose();
    super.onReady();
  }

  Future<void> getUserInfoCall() async {
    userInfo.value = await UserService.userProfileCall();
    update();
  }

  Future<bool> updateUser(
      String name, String email, String phone, File avatar) async {
    final isUpdated = await UserService.updateProfile({
      "name": name,
      "email": email,
      "phone": phone,
      "avatar": avatar,
    });
    if (isUpdated) {
      Get.back();
      showSnackBar(msg: 'Profile Updated Successfully');
      await getUserInfoCall();
    }
    return isUpdated;
  }

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      pickedImage.value = File(pickedFile.path);
    }
  }
  Future<void> editPassword(
      String oldPassword,
      String password,
      String cPassword,
      ) async {

    bool isVerified = await UserService.editPassword({
      "old_password":oldPassword,
      "new_password": password,
      "c_password": cPassword,
    });
    if (isVerified) {
     Get.back();

    }
  }
}
