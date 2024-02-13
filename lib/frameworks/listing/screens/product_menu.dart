import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';

import '../../../common/config.dart';
import '../../../common/tools.dart';
import '../../../generated/l10n.dart';
import '../../../models/entities/index.dart';
import '../../../widgets/common/expansion_info.dart';

class ProductMenu extends StatelessWidget {
  final Product? product;

  const ProductMenu({this.product});

  @override
  Widget build(BuildContext context) {
    final prices = product!.listingMenu!;
    return ExpansionInfo(
      expand: kProductDetail.expandListingMenu,
      title: S.of(context).prices,
      children: <Widget>[
        Column(
          children: List.generate(prices.length, (i) {
            var showTitle =
                prices[i].title != null && prices[i].title.isNotEmpty;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (showTitle) const SizedBox(height: 10),
                  if (showTitle)
                    Text(
                      prices[i].title,
                      style: TextStyle(
                        fontSize: 22,
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.5),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    shrinkWrap: true,
                    itemCount: prices[i].menu.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    prices[i].menu[index].name,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  PriceTools.getCurrencyFormatted(
                                      prices[i].menu[index].price, null)!,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.lightGreen,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            if (isNotBlank(prices[i].menu[index].description))
                              const SizedBox(
                                height: 2,
                              ),
                            if (isNotBlank(prices[i].menu[index].description))
                              Text(
                                prices[i].menu[index].description,
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                          ]);
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  )
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
