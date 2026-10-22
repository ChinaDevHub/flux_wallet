import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/core/widgets/lazy_indexed_stack.dart';

class _Probe extends StatefulWidget {
  const _Probe(this.name, this.built);

  final String name;
  final List<String> built;

  @override
  State<_Probe> createState() => _ProbeState();
}

class _ProbeState extends State<_Probe> {
  @override
  void initState() {
    super.initState();
    widget.built.add(widget.name);
  }

  @override
  Widget build(BuildContext context) => Text(widget.name);
}

void main() {
  testWidgets('builds a tab the first time it is shown and keeps it', (
    t,
  ) async {
    final built = <String>[];
    Widget app(int index) => MaterialApp(
      home: LazyIndexedStack(
        index: index,
        children: [_Probe('a', built), _Probe('b', built), _Probe('c', built)],
      ),
    );
    await t.pumpWidget(app(0));
    expect(built, ['a']);
    await t.pumpWidget(app(2));
    expect(built, ['a', 'c']);
    await t.pumpWidget(app(0));
    await t.pumpWidget(app(2));
    expect(built, ['a', 'c'], reason: 'kept alive, not rebuilt');
  });
}
