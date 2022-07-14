import 'package:flutter/material.dart';
import 'package:flutter_grocery/data/model/response/category_model.dart';
import 'package:flutter_grocery/provider/category_provider.dart';
import 'package:provider/provider.dart';

import 'category_on_home.dart';

class CatwithSubCatonHome extends StatelessWidget {
  const CatwithSubCatonHome({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Provider.of<CategoryProvider>(context, listen: false)
                  .categoryList ==
              null
          ? SizedBox()
          : Provider.of<CategoryProvider>(context, listen: false)
                      .categoryList
                      .length ==
                  0
              ? SizedBox()
              : ListView.builder(
                  itemCount:
                      Provider.of<CategoryProvider>(context, listen: false)
                          .categoryList
                          .length,
                  primary: false,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(4.0),
                  itemBuilder: (context, index) {
                    CategoryModel _category =
                        Provider.of<CategoryProvider>(context, listen: false)
                            .categoryList[index];

                    var category =
                        Provider.of<CategoryProvider>(context, listen: false)
                            .subCategoryList;
                    print("sub categoris list $category");
                    return HomeCategory(
                      title: _category.name,
                      id: _category.id,
                    );
                  }),
    );
  }
}
