// ============================================================
// APP SEARCH RANKER
// ------------------------------------------------------------
// Professional search ranking for list screens:
// exact / starts-with / contains matches first,
// then remaining related rows below.
// ============================================================

class AppSearchRanker {
  AppSearchRanker._();

  /// Rank [items] so the best query matches come first.
  /// Items with no match keep their original order at the bottom.
  static List<T> matchesThenRelated<T>({
    required List<T> items,
    required String query,
    required List<String> Function(T item) fieldsOf,
  }) {
    final q = _normalize(query);
    if (q.isEmpty) return List<T>.from(items);

    final scored = <_Scored<T>>[];
    for (var i = 0; i < items.length; i++) {
      scored.add(
        _Scored(
          item: items[i],
          score: score(q, fieldsOf(items[i])),
          index: i,
        ),
      );
    }

    scored.sort((a, b) {
      final byScore = b.score.compareTo(a.score);
      if (byScore != 0) return byScore;
      return a.index.compareTo(b.index);
    });

    return scored.map((e) => e.item).toList();
  }

  /// Merge API search hits with related rows, then rank like a search engine.
  static List<T> pinMatchesThenRelated<T>({
    required List<T> matches,
    required List<T> related,
    required String query,
    required String Function(T item) idOf,
    required List<String> Function(T item) fieldsOf,
  }) {
    final seen = <String>{};
    final merged = <T>[];
    for (final item in [...matches, ...related]) {
      if (seen.add(idOf(item))) merged.add(item);
    }
    return matchesThenRelated(
      items: merged,
      query: query,
      fieldsOf: fieldsOf,
    );
  }

  /// Append extra rows, skipping ids already on screen.
  static List<T> appendUnique<T>({
    required List<T> current,
    required List<T> extra,
    required String Function(T item) idOf,
  }) {
    final seen = current.map(idOf).toSet();
    final more = extra.where((item) => seen.add(idOf(item))).toList();
    return [...current, ...more];
  }

  /// How many items actually match [query] (score > 0).
  static int matchCount<T>({
    required List<T> items,
    required String query,
    required List<String> Function(T item) fieldsOf,
  }) {
    final q = _normalize(query);
    if (q.isEmpty) return 0;

    var count = 0;
    for (final item in items) {
      if (score(q, fieldsOf(item)) > 0) count++;
    }
    return count;
  }

  /// True when at least one item matches [query].
  static bool hasAnyMatch<T>({
    required List<T> items,
    required String query,
    required List<String> Function(T item) fieldsOf,
  }) {
    return matchCount(
          items: items,
          query: query,
          fieldsOf: fieldsOf,
        ) >
        0;
  }

  /// Higher score = better match. 0 = not a match (related).
  static int score(String normalizedQuery, List<String> fields) {
    if (normalizedQuery.isEmpty) return 0;

    var best = 0;
    for (var i = 0; i < fields.length; i++) {
      final field = _normalize(fields[i]);
      if (field.isEmpty) continue;

      var fieldScore = _scoreField(normalizedQuery, field);
      if (fieldScore == 0) continue;

      // First fields (name, etc.) rank higher than later ones.
      if (i == 0) fieldScore += 40;
      if (i == 1) fieldScore += 15;

      if (fieldScore > best) best = fieldScore;
    }
    return best;
  }

  static int _scoreField(String query, String field) {
    if (field == query) return 1000;
    if (field.startsWith(query)) return 850;

    final words = field.split(RegExp(r'\s+'));
    for (final word in words) {
      if (word == query) return 750;
      if (word.startsWith(query)) return 650;
    }

    if (field.contains(query)) return 500;

    final tokens = query.split(RegExp(r'\s+')).where((t) => t.isNotEmpty);
    if (tokens.isEmpty) return 0;

    var allPresent = true;
    var anyPresent = false;
    var prefixHits = 0;
    for (final token in tokens) {
      if (field.contains(token)) {
        anyPresent = true;
      } else {
        allPresent = false;
      }
      for (final word in words) {
        if (word.startsWith(token)) prefixHits++;
      }
    }

    if (allPresent) return 350 + (prefixHits * 10);
    if (prefixHits > 0) return 180 + (prefixHits * 10);
    if (anyPresent) return 80;
    return 0;
  }

  static String _normalize(String value) {
    return value.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
  }
}

class _Scored<T> {
  const _Scored({
    required this.item,
    required this.score,
    required this.index,
  });

  final T item;
  final int score;
  final int index;
}
