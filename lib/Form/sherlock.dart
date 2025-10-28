import 'dart:async';
import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:moonspace/helper/extensions/color.dart';
import 'package:moonspace/helper/extensions/theme_ext.dart';
import 'package:moonspace/helper/stream/cached_stream.dart';
import 'package:moonspace/helper/stream/debounce.dart';

class Sherlock<T> extends StatefulWidget {
  const Sherlock({
    super.key,
    required this.onFetch,
    this.onSubmit,
    required this.builder,
    this.hint,
    this.isFullScreen = false,
    this.actions = const [],
    this.textStyle,
    this.debounceMilliseconds = 200,
    this.icon,
    this.elevation = 0,
    required this.bar,
    this.border,
    this.barColor,
  });

  final Future<List<T>> Function(String query) onFetch;
  final Future<List<T>> Function(String query)? onSubmit;
  final Widget Function(List<T> data, SearchController controller) builder;

  final String? hint;
  final bool isFullScreen;

  final Iterable<Widget> actions;
  final TextStyle? textStyle;

  final int debounceMilliseconds;

  final Widget? icon;

  final double elevation;
  final RoundedRectangleBorder? border;
  final Color? barColor;

  final bool bar;

  @override
  State<Sherlock<T>> createState() => _SherlockState<T>();
}

class _SherlockState<T> extends State<Sherlock<T>> {
  late final SearchController searchController;

  late final CachedStreamable<List<T>> dataStream;
  late final StreamController<String> lastTextStream;
  late final StreamController<String> debounceSearchTextStream;
  late final CachedStreamable<Set<String>> searchHistoryStream;

  String _lastText = '';

  @override
  void initState() {
    searchController = SearchController();

    dataStream = CachedStreamable([]);
    lastTextStream = StreamController.broadcast();
    debounceSearchTextStream = createDebounceFunc<String>(
      widget.debounceMilliseconds,
      fetch,
    );
    searchHistoryStream = CachedStreamable({});

    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    dataStream.close();
    lastTextStream.close();
    searchHistoryStream.close();
    debounceSearchTextStream.close();

    super.dispose();
  }

  void fetch(String v) async {
    if (searchController.text != _lastText) {
      lastTextStream.add('');

      _lastText = searchController.text;

      final d = await widget.onFetch(_lastText);
      dataStream.value = d;

      lastTextStream.add(searchController.text);
    }
  }

  void submit() async {
    if (searchController.text == "") return;
    Set<String> history = (searchHistoryStream.value).toSet();

    final value = await widget.onSubmit?.call(searchController.text);
    if (value != null) {
      dataStream.value = value;
    }

    history.add(searchController.text);
    searchHistoryStream.value = history;
    debounceSearchTextStream.add(searchController.text);
  }

  void clear() {
    searchHistoryStream.value = {};
    searchController.clear();
  }

  void close() {
    searchController.text = '';
    debounceSearchTextStream.add('');
    searchController.clear();
    searchController.closeView(null);
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.bar) {
      return SearchAnchor(
        searchController: searchController,
        isFullScreen: widget.isFullScreen,
        viewHintText: widget.hint,
        viewConstraints: const BoxConstraints(maxHeight: 400, minWidth: 300),
        viewTrailing: actions,
        viewElevation: widget.elevation,
        builder: (BuildContext context, SearchController controller) {
          return IconButton(
            icon: widget.icon ?? const Icon(Icons.search),
            onPressed: () {
              controller.openView();
            },
          );
        },
        suggestionsBuilder: suggestionsBuilder,
      );
    }

    return SearchAnchor.bar(
      searchController: searchController,
      isFullScreen: widget.isFullScreen,
      viewHintText: widget.hint,
      barHintText: widget.hint,
      barElevation: WidgetStateProperty.resolveWith((s) {
        return widget.elevation;
      }),
      barHintStyle: WidgetStateTextStyle.resolveWith((s) {
        return widget.textStyle ?? context.h8 ?? TextStyle();
      }),
      barBackgroundColor: WidgetStateProperty.resolveWith((s) {
        return widget.barColor;
      }),
      barShape: WidgetStateProperty.resolveWith((s) {
        return widget.border;
      }),
      viewHeaderTextStyle: widget.textStyle ?? context.h7,
      viewConstraints: const BoxConstraints(maxHeight: 400),
      onSubmitted: (value) {
        submit();
      },
      barLeading: widget.icon,
      viewTrailing: actions,
      suggestionsBuilder: suggestionsBuilder,
    );
  }

  List<Widget> get actions => [
    ...widget.actions,
    IconButton(onPressed: submit, icon: const Icon(Icons.add_circle)),
    IconButton(onPressed: clear, icon: const Icon(Icons.celebration_sharp)),
    IconButton(onPressed: close, icon: const Icon(Icons.cancel)),
  ];

  FutureOr<Iterable<Widget>> suggestionsBuilder(
    BuildContext context,
    SearchController controller,
  ) {
    debounceSearchTextStream.add(controller.text);

    return [
      //
      StreamBuilder(
        stream: lastTextStream.stream,
        builder: (context, snapshot) {
          // return Text('${controller.text} : ${snapshot.data}');
          if (searchController.text != snapshot.data) {
            return LinearProgressIndicator(
              minHeight: 2,
              color: HexColor.random(),
            );
          }
          return const SizedBox(height: 2);
        },
      ),

      //
      Container(
        width: context.mq.w,
        padding: const EdgeInsets.all(4),
        child: StreamBuilder(
          stream: searchHistoryStream.stream,
          builder: (context, snapshot) {
            return Wrap(
              runSpacing: 2,
              spacing: 2,
              children:
                  snapshot.data
                      ?.map(
                        (e) => ChoiceChip(
                          selected: searchController.text == e,
                          label: Text(e),
                          onSelected: (value) {
                            searchController.text = e;
                            searchController.selection =
                                TextSelection.collapsed(offset: e.length);
                            debounceSearchTextStream.add(searchController.text);
                          },
                        ),
                      )
                      .toList() ??
                  [],
            );
          },
        ),
      ),

      StreamBuilder(
        stream: dataStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Placeholder(fallbackHeight: 30, fallbackWidth: 30);
          }
          return widget.builder(snapshot.data!, controller);
        },
      ),
    ];
  }
}
