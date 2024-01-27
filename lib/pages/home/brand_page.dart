import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mh_core/widgets/network_image/network_image.dart';
import 'package:perfecto/constants/assets_constants.dart';
import 'package:perfecto/constants/color_constants.dart';
import 'package:perfecto/controller/home_api_controller.dart';
import 'package:perfecto/drawer/custom_drawer.dart';
import 'package:perfecto/pages/category/single_category_page.dart';
import 'package:perfecto/pages/home/controller/home_controller.dart';
import 'package:perfecto/pages/home/widgets/home_top_widget.dart';
import 'package:perfecto/pages/home/widgets/mega_deals_widget.dart';
import 'package:perfecto/shared/custom_sized_box.dart';
import 'package:perfecto/theme/theme_data.dart';

class BrandScreen extends StatefulWidget {
  const BrandScreen({super.key});
  static const String routeName = '/brand';

  @override
  State<BrandScreen> createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      drawer: const CustomDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeTopWidget(),
          const TitleTextWidget(tileText: 'Popular Brands'),
          GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shrinkWrap: true,
            primary: false,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              final popularBrand = HomeApiController.to.brandList.where((p0) => p0.isPopular == '1').toList();
              final brand = popularBrand[index];
              return GestureDetector(
                onTap: () {
                  Get.toNamed(SingleCatergoryWiseScreen.routeName);
                },
                child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: const Color(0xffF2F4F5)),
                    child: CustomNetworkImage(
                      networkImagePath: brand.image ?? '',
                      errorImagePath: AssetsConstant.brandLogo,
                      // height: 45,
                      borderRadius: 0,
                      fit: BoxFit.cover,
                    )),
              );
            },
            itemCount: HomeApiController.to.brandList.where((p0) => p0.isPopular == '1').length > 6 ? 6 : HomeApiController.to.brandList.where((p0) => p0.isPopular == '1').length,
          ),
          CustomSizedBox.space8H,
          const TitleTextWidget(tileText: 'All Brands'),
          Expanded(
            child: AzListView(
              data: HomeApiController.to.brandList,
              indexBarItemHeight: 10,
              indexBarOptions: const IndexBarOptions(
                indexHintAlignment: Alignment.centerRight,
                indexHintDecoration: BoxDecoration(color: AppColors.kPrimaryColor, shape: BoxShape.circle),
                needRebuild: true,
              ),
              itemCount: HomeApiController.to.brandList.length,
              itemBuilder: (context, index) {
                final subData = HomeApiController.to.brandList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      subData.susTag == null
                          ? SizedBox.shrink()
                          : Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text(
                                subData.susTag ?? '',
                                style: AppTheme.textStyleSemiBoldBlack16,
                              ),
                            ),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                          ),
                          child: Text(
                            subData.name ?? '',
                            style: AppTheme.textStyleMediumBlack14,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
