import 'package:json_annotation/json_annotation.dart';
import 'package:news_app/values/enumeration.dart';

part 'article.g.dart';

@JsonSerializable()
class Article {
  @JsonKey(defaultValue: '')
  String? title;
  @JsonKey(defaultValue: '')
  String? author;
  @JsonKey(name: 'published_date', fromJson: _fromStringDateToDateTime)
  DateTime? publishedDate;
  @JsonKey(name: 'published_date_precision')
  String? publishedDatePrecision;
  String? link;
  @JsonKey(name: 'clean_url')
  String? cleanUrl;
  String? excerpt;
  String? summary;
  String? rights;
  int? rank;
  String? topic;
  String? country;
  Language? language;
  String? authors;
  @JsonKey(defaultValue: '')
  String? media;

  @JsonKey(name: 'is_opinion')
  bool? isOpinion;
  @JsonKey(name: 'twitter_account')
  String? twitterAccount;
  @JsonKey(name: '_score')
  dynamic score;
  @JsonKey(name: '_id')
  String? id;

  Article({
    this.title,
    this.author,
    this.publishedDate,
    this.publishedDatePrecision,
    this.link,
    this.cleanUrl,
    this.excerpt,
    this.summary,
    this.rights,
    this.rank,
    this.topic,
    this.country,
    this.language,
    this.authors,
    this.media,
    this.isOpinion,
    this.twitterAccount,
    this.score,
    this.id,
  });

  static DateTime? _fromStringDateToDateTime(String? dateString) {
    if (dateString == null || dateString.isEmpty) return null;
    return DateTime.parse(dateString);
  }

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
