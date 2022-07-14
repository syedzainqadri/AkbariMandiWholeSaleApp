import 'package:flutter/material.dart';
import 'package:akbarimandiwholesale/data/model/response/category_model.dart';
import 'package:akbarimandiwholesale/helper/route_helper.dart';
import 'package:akbarimandiwholesale/provider/category_provider.dart';
import 'package:akbarimandiwholesale/provider/localization_provider.dart';
import 'package:akbarimandiwholesale/utill/dimensions.dart';
import 'package:akbarimandiwholesale/utill/styles.dart';
import 'package:akbarimandiwholesale/view/screens/product/category_product_screen.dart';
import 'package:provider/provider.dart';
import 'sub_category_on_home.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeCategory extends StatefulWidget {
  final String title;
  final int id;
  const HomeCategory({Key key, this.title, this.id}) : super(key: key);

  @override
  State<HomeCategory> createState() => _HomeCategoryState();
}

class _HomeCategoryState extends State<HomeCategory> {
  bool isLoading = true;
  var category;

  loadData() async {
    await Provider.of<CategoryProvider>(context, listen: false)
        .getSubCategoryList(
      context,
      widget.id.toString(),
      Provider.of<LocalizationProvider>(context, listen: false)
          .locale
          .languageCode,
    );
    setState(() {
      category =
          Provider.of<CategoryProvider>(context, listen: false).subCategoryList;
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Card(
        elevation: 1.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.yellow.shade200,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 2.0),
              child: Text(
                widget.title,
                style: poppinsBold.copyWith(
                  fontSize: Dimensions.FONT_SIZE_SMALL,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              color: Colors.white,
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : category != null || category != []
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: MasonryGridView.count(
                            crossAxisCount: width > 1100
                                ? 5
                                : width > 800
                                    ? 4
                                    : width > 600
                                        ? 3
                                        : 2,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: category.length,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    RouteHelper.getCategoryProductsRoute(
                                      category[index].id,
                                    ),
                                    arguments: CategoryProductScreen(
                                        categoryModel: CategoryModel(
                                      id: category[index].id,
                                      name: category[index].name,
                                    )),
                                  );
                                },
                                child: SubCategoryItem(
                                    title: category[index].name,
                                    icon: category[index].image,
                                    isSelected: false
                                    // categoryProvider.categorySelectedIndex ==
                                    //     index,
                                    ),
                              );
                            },
                          ),
                        )
                      : Text("No Sub Categories For This Category"),
            )
          ],
        ),
      ),
    );
  }
}
