import 'package:flutter/material.dart';
import 'package:moonspace/helper/extensions/theme_ext.dart';

class TypographyScreen extends StatelessWidget {
  const TypographyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: <Widget>[
            const SizedBox(height: 8),
            Text('Display Large', style: context.dl),
            Text('Display Medium', style: context.dm),
            Text('Display Small', style: context.ds),
            Text('Headline Large', style: context.hl),
            Text('Headline Medium', style: context.hm),
            Text('Headline Small', style: context.hs),
            Text('Title Large', style: context.tl),
            Text('Title Medium', style: context.tm),
            Text('Title Small', style: context.ts),
            Text('Body Large', style: context.bl),
            Text('Body Medium', style: context.bm),
            Text('Body Small', style: context.bs),
            Text('Label Large', style: context.ll),
            Text('Label Medium', style: context.lm),
            Text('Label Small', style: context.ls),
          ],
        ),
        Theme(
          data: ThemeData(brightness: context.brightness),
          child: Builder(
            builder: (context) {
              return Column(
                children: <Widget>[
                  const SizedBox(height: 8),
                  Text('Display Large', style: context.dl),
                  Text('Display Medium', style: context.dm),
                  Text('Display Small', style: context.ds),
                  Text('Headline Large', style: context.hl),
                  Text('Headline Medium', style: context.hm),
                  Text('Headline Small', style: context.hs),
                  Text('Title Large', style: context.tl),
                  Text('Title Medium', style: context.tm),
                  Text('Title Small', style: context.ts),
                  Text('Body Large', style: context.bl),
                  Text('Body Medium', style: context.bm),
                  Text('Body Small', style: context.bs),
                  Text('Label Large', style: context.ll),
                  Text('Label Medium', style: context.lm),
                  Text('Label Small', style: context.ls),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
