import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:newsnews/src/core/config/router.dart';
import 'package:newsnews/src/core/theme/palette.dart';
import 'package:newsnews/src/domain/entities/article/article_entity.dart';
import 'package:newsnews/src/presentation/feed/cubit/news_cubit.dart';
import 'package:newsnews/src/presentation/feed/widgets/big_tag.dart';
import 'package:newsnews/src/presentation/feed/widgets/headline_card.dart';
import 'package:newsnews/src/presentation/feed/widgets/row_tag_see_more.dart';
import 'package:newsnews/src/widgets/news_card.dart';

class PageTabViewWithCategory extends StatefulWidget {
  const PageTabViewWithCategory(
      {Key? key, required this.categoryIndex, required this.category})
      : super(key: key);

  final int categoryIndex;
  final String category;

  @override
  State<PageTabViewWithCategory> createState() =>
      _PageTabViewWithCategoryState();
}

class _PageTabViewWithCategoryState extends State<PageTabViewWithCategory>
    with SingleTickerProviderStateMixin {
  late final PageController pageController;
  int currentPage = 0;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  void changePage(int value) {
    setState(() {
      currentPage = value;
    });
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < 3; i++) {
      list.add(
          i == currentPage ? _buildIndicator(true) : _buildIndicator(false));
    }
    return list;
  }

  Widget _buildIndicator(bool isChanged) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      height: 5.h,
      width: isChanged ? 35.w : 20.w,
      decoration: BoxDecoration(
        color: isChanged ? Palette.primaryHeavyColor : Palette.unSelectedColor,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<NewsCubit, NewsState, List<ArticleEntity>>(
      selector: (state) {
        return state is NewsLoaded ? state.listArticle : [];
      },
      builder: (context, listArticle) {
        final tagArticleList = listArticle
            .where((element) =>
                element.category!.toLowerCase() ==
                widget.category.toLowerCase())
            .toList();
        final listForTop = tagArticleList.getRange(0, 3).toList();
        final listForMore =
            tagArticleList.getRange(4, tagArticleList.length).toList();
        return ListView(
          children: [
            SizedBox(
              height: 24.h,
            ),
            BigTag(
              tag: "Top ${widget.category.toUpperCase()} Headlines",
              fontSize: 24.sp,
            ),
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              height: 330.h,
              child: PageView.builder(
                onPageChanged: changePage,
                itemCount: listForTop.length,
                controller: pageController,
                itemBuilder: (context, index) {
                  return HeadlineCard(
                    imageURL: listForTop[index].urlToImage,
                    newsTag: widget.category,
                    newsTitle: listForTop[index].title!,
                    onHeadlineTapFunction: () =>
                        context.push(RouteManager.detailArticle, extra: {
                      "article": listForTop[index],
                      "newsTag": widget.category,
                    }),
                  );
                },
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: _buildPageIndicator(),
            ),
            SizedBox(
              height: 14.h,
            ),
            RowTagSeeMore(
              tag: "More ${widget.category.toUpperCase()} news",
              onSeeMoreTap: () =>
                  context.push("${RouteManager.moreNews}/${widget.category}"),
            ),
            SizedBox(height: 8.h),
            SizedBox(
              height: 300.h,
              child: ListView.builder(
                itemCount: listForMore.length,
                itemBuilder: (context, index) {
                  return NewsCard(
                    imageUrl: listForMore[index].urlToImage ?? "",
                    onNewsTapFunction: () =>
                        context.push(RouteManager.detailArticle, extra: {
                      "article": listForMore[index],
                      "newsTag": widget.category,
                    }),
                    tag: widget.category,
                    time: listForMore[index].publishedAt,
                    title: listForMore[index].title!,
                    verticalMargin: 12.h,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
