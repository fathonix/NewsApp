import 'package:flutter/material.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/screen/detailpage.dart';
import 'package:news_app/utility/utils.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsItem extends StatelessWidget {
  final Article article;

  const NewsItem({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(article: article),
          )),
      child: Card(
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SizedBox(
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.network(
                    article.urlToImage,
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, obj, e) {
                      return Container(
                        height: 80,
                        width: 80,
                        color: Colors.black,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: SizedBox(
                  width: 210,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: titleArticle.copyWith(fontSize: 12),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_today_outlined,
                                size: 12,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              SizedBox(
                                width: 70,
                                child: Text(
                                  time(DateTime.parse(article.publishedAt)),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      authorDateArticle.copyWith(fontSize: 12),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.person,
                                size: 12,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              SizedBox(
                                width: 70,
                                child: Text(
                                  article.author,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      authorDateArticle.copyWith(fontSize: 12),
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                )),
              ],
            )),
      ),
    );
  }

  String time(DateTime parse) {
    return timeago.format(parse, allowFromNow: true, locale: 'en');
  }
}
