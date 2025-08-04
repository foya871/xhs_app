class DynamicChangeEvent {
  final int id;
  final bool? isLike;
  final int? fakeLikes;
  final bool? isFavorite;
  final int? fakeFavorites;
  final int? commentNum;

  DynamicChangeEvent.like(this.id,
      {required this.isLike, required this.fakeLikes})
      : isFavorite = null,
        fakeFavorites = null,
        commentNum = null;

  DynamicChangeEvent.favorite(this.id,
      {required this.isFavorite, required this.fakeFavorites})
      : isLike = null,
        fakeLikes = null,
        commentNum = null;

  DynamicChangeEvent.comment(this.id, {required this.commentNum})
      : isLike = null,
        fakeLikes = null,
        isFavorite = null,
        fakeFavorites = null;

  DynamicChangeEvent(
    this.id, {
    this.isLike,
    this.fakeLikes,
    this.isFavorite,
    this.fakeFavorites,
    this.commentNum,
  });
}
