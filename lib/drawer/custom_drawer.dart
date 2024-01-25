import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mh_core/utils/global.dart';
import 'package:perfecto/constants/assets_constants.dart';
import 'package:perfecto/constants/color_constants.dart';
import 'package:perfecto/controller/home_api_controller.dart';
import 'package:perfecto/drawer/drawer_controller.dart';
import 'package:perfecto/models/product_attribute_model.dart';
import 'package:perfecto/pages/auth/return_cancelation_page.dart';
import 'package:perfecto/pages/auth/terms_condition_page.dart';
import 'package:perfecto/pages/blog/blog_page.dart';
import 'package:perfecto/pages/home/brand_page.dart';
import 'package:perfecto/pages/my-cart/wish_list_page.dart';
import 'package:perfecto/pages/profile/return_and_cancelation.dart';
import 'package:perfecto/shared/custom_sized_box.dart';
import 'package:perfecto/theme/theme_data.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        HomeApiController.to.categoryList.forEach((element) {
          element.isExpanded = false;
          element.subcategory!.forEach((element) {
            element.isExpanded = false;
          });
        });
        return true;
      },
      child: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).viewPadding.top,
            ),
            CustomSizedBox.space12H,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
              child: Row(
                children: [
                  Image.asset(
                    AssetsConstant.perfectoLogo,
                    height: 18,
                  ),
                  const Spacer(),
                  InkWell(
                    borderRadius: BorderRadius.circular(360),
                    onTap: () {
                      Navigator.pop(context);
                      Get.toNamed(WishListScreen.routeName);
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Image.asset(
                            AssetsConstant.favIcon,
                            height: 25,
                            color: Colors.black,
                          ),
                          Positioned(
                            top: -2,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(2.5),
                              decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.kDarkPrimaryColor),
                              child: const Text('12', style: AppTheme.textStyleBoldWhite8),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  CustomSizedBox.space8W,
                  GestureDetector(
                    onTap: () {
                      HomeApiController.to.categoryList.forEach((element) {
                        element.isExpanded = false;
                        element.subcategory!.forEach((element) {
                          element.isExpanded = false;
                        });
                      });
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      CupertinoIcons.multiply,
                      size: 28,
                    ),
                  )
                ],
              ),
            ),
            const CustomDividerWidget(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Get.toNamed(WishListScreen.routeName);
                          },
                          child: const SaleTextWidget()),
                      const SaleTextWidget(text: 'Puja Sale', color: Color(0xffD90068)),
                      const SaleTextWidget(text: 'Buy 1 Get 1', color: Color(0xff9747FF)),
                      const SaleTextWidget(text: 'Clearance Sale', color: Color(0xff129CED)),
                      CustomSizedBox.space12H,
                      const CustomDividerWidget(),
                      CustomSizedBox.space8H,
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Get.toNamed(BrandScreen.routeName);
                        },
                        child: Container(
                          width: double.infinity,
                          color: Colors.transparent,
                          child: const SaleTextWidget(
                            text: 'Brands',
                            color: Colors.black,
                          ),
                        ),
                      ),
                      CustomSizedBox.space8H,
                      const CustomDividerWidget(),
                      CustomSizedBox.space8H,
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Get.toNamed(BlogScreen.routeName);
                        },
                        child: Container(
                          width: double.infinity,
                          color: Colors.transparent,
                          child: const SaleTextWidget(
                            text: 'Beauty Advice',
                            color: Colors.black,
                          ),
                        ),
                      ),
                      CustomSizedBox.space8H,
                      const CustomDividerWidget(),
                      CustomSizedBox.space8H,
                      const SaleTextWidget(
                        text: 'Category',
                        color: Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
                        child: Obx(() {
                          return Column(
                            children: [
                              ...List.generate(HomeApiController.to.categoryList.length, (index) {
                                final category = HomeApiController.to.categoryList[index];

                                return DrawerMenuItemWidget(
                                  title: category.name!,
                                  categoryModel: category,
                                );
                                //     Column(
                                //       children: [
                                //         GestureDetector(
                                //
                                //           child: Padding(
                                //             padding: const EdgeInsets.symmetric(vertical: 6.0),
                                //             child: Row(
                                //               children: [
                                //                 Text(
                                //                   category.name??'',
                                //                   style: AppTheme.textStyleMediumFadeBlack16,
                                //                 ),
                                //                 const Spacer(),
                                //                 Icon(
                                //                   Icons.add,
                                //                   color: Colors.black.withOpacity(.7),
                                //                   size: 25,
                                //                 )
                                //               ],
                                //             ),
                                //           ),
                                //           onTap: () {
                                //             globalLogger.d(category.subcategory!.map((e) => e.parentId));
                                //            CustomDrawerController.to.isExpanded.value= category.subcategory!.where((element) => element.parentId==category.id).isEmpty;
                                //
                                //
                                //           },
                                //         ),  CustomDrawerController.to.isExpanded.value
                                //             ? Column(
                                //           crossAxisAlignment: CrossAxisAlignment.start,
                                //           children: [
                                //             ...List.generate(category.subcategory!.length, (index) {
                                //               final subCate =
                                //               category.subcategory![index];
                                //               return Container(
                                //                 width: double.infinity,
                                //                 /*decoration: BoxDecoration(
                                // color: index == 1 ? AppColors.kAccentColor : null,
                                // border: Border(
                                //     left: BorderSide(
                                //         width: 1,
                                //         color: index == 1
                                //             ? AppColors.kPrimaryColor
                                //             : Colors.transparent)))*/
                                //                 child: Padding(
                                //                   padding: const EdgeInsets.symmetric(
                                //                       horizontal: 16, vertical: 8),
                                //                   child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                //                     children: [
                                //                       GestureDetector(
                                //
                                //                         child: Text(
                                //                           subCate.name??'',
                                //                           style: AppTheme.textStyleMediumFadeBlack16,
                                //                         ),
                                //                         onTap: () {
                                //
                                //                           CustomDrawerController.to.isExpanded2.value=!CustomDrawerController.to.isExpanded2.value;
                                //                         },
                                //                       ),
                                //                       CustomDrawerController.to.isExpanded2.value
                                //                           ?  Column(children: [...List.generate(CustomDrawerController.to.childCategory.length, (index) {
                                //                         final text =
                                //                         CustomDrawerController.to.childCategory[index];
                                //                         return Container(
                                //                           width: double.infinity,
                                //
                                //                           child: Padding(
                                //                             padding: const EdgeInsets.symmetric(
                                //                                 horizontal: 16, vertical: 8),
                                //                             child: Text(
                                //                               text,
                                //                               style: AppTheme.textStyleMediumFadeBlack16,
                                //                             ),
                                //                           ),
                                //                         );
                                //                       })],):const SizedBox.shrink()
                                //                     ],
                                //                   ),
                                //                 ),
                                //               );
                                //             })
                                //           ],
                                //         )
                                //             : const SizedBox.shrink()
                                //       ],
                                //     );
                              })
                            ],
                          );
                        }),
                      ),
                      CustomSizedBox.space8H,
                      const CustomDividerWidget(),
                      CustomSizedBox.space8H,
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Get.toNamed(TermsConditionScreen.routeName);
                        },
                        child: const SaleTextWidget(
                          text: 'Terms & Conditions',
                          color: Colors.black,
                        ),
                      ),
                      CustomSizedBox.space8H,
                      const CustomDividerWidget(),
                      CustomSizedBox.space8H,
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Get.toNamed(RefundCancelationScreen.routeName);
                        },
                        child: const SaleTextWidget(
                          text: 'Return & Refund Policy',
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DrawerMenuItemWidget extends StatelessWidget {
  final String title;
  final CategoryModel categoryModel;
  final Widget? widget;
  // final Function() onTap;
  const DrawerMenuItemWidget({
    super.key,
    required this.title,
    // required this.onTap,
    this.widget,
    required this.categoryModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        globalLogger.d("Category Tap");
        if (categoryModel.subcategory!.isNotEmpty) {
          categoryModel.isExpanded = !categoryModel.isExpanded!;
          if (!categoryModel.isExpanded!) {
            categoryModel.subcategory!.forEach((element) {
              element.isExpanded = false;
            });
          }
          HomeApiController.to.categoryList.refresh();
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Row(
              children: [
                Text(
                  title,
                  style: AppTheme.textStyleMediumFadeBlack16,
                ),
                const Spacer(),
                Icon(
                  Icons.add,
                  color: Colors.black.withOpacity(.7),
                  size: 25,
                )
              ],
            ),
          ),
          widget ?? const SizedBox.shrink(),
          categoryModel.isExpanded!
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...List.generate(categoryModel.subcategory!.length, (index) {
                      final subCate = categoryModel.subcategory![index];
                      return Container(
                        width: double.infinity,
                        /*decoration: BoxDecoration(
                              color: index == 1 ? AppColors.kAccentColor : null,
                              border: Border(
                                  left: BorderSide(
                                      width: 1,
                                      color: index == 1
                                          ? AppColors.kPrimaryColor
                                          : Colors.transparent)))*/
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                child: Text(
                                  subCate.name ?? '',
                                  style: AppTheme.textStyleMediumFadeBlack16,
                                ),
                                onTap: () {
                                  globalLogger.d("subCategory Tap");
                                  if (subCate.subcategory!.isNotEmpty) {
                                    subCate.isExpanded = !subCate.isExpanded!;
                                    HomeApiController.to.categoryList.refresh();
                                  }
                                },
                              ),
                              subCate.isExpanded!
                                  ? Column(
                                      children: [
                                        ...List.generate(subCate.subcategory!.length, (index) {
                                          final subCat = subCate.subcategory![index];
                                          return GestureDetector(
                                            onTap: () {
                                              globalLogger.d("subCategory Tap");
                                              if (subCat.subcategory!.isNotEmpty) {
                                                subCat.isExpanded = !subCat.isExpanded!;
                                                HomeApiController.to.categoryList.refresh();
                                              }
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                child: Text(
                                                  subCat.name ?? '',
                                                  style: AppTheme.textStyleMediumFadeBlack16,
                                                ),
                                              ),
                                            ),
                                          );
                                        })
                                      ],
                                    )
                                  : const SizedBox.shrink()
                            ],
                          ),
                        ),
                      );
                    })
                  ],
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}

class SaleTextWidget extends StatelessWidget {
  final String? text;
  final Color? color;
  const SaleTextWidget({
    super.key,
    this.text,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text ?? 'Anniversary Sale',
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: color ?? const Color(0xff3734E2)),
      ),
    );
  }
}

class CustomDividerWidget extends StatelessWidget {
  const CustomDividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 1.5,
      height: 0,
      color: Color(0xffECECEC),
    );
  }
}
