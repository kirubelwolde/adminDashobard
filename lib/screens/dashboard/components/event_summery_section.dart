import 'package:admin/utility/color_list.dart';
import 'package:admin/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/event_summery_info.dart';
import '../../../utility/constants.dart';
import 'event_summery_card.dart';

class EventSummerySection extends StatelessWidget {
  const EventSummerySection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Consumer<DataProvider>(
      builder: (context, dataProvider, _) {
        int totalEvent = 1;
        totalEvent =
            context.dataProvider.calculateEventWithQuantity(quantity: null);
        int outOfStockEvent =
            context.dataProvider.calculateEventWithQuantity(quantity: 0);
        int limitedStockEvent =
            context.dataProvider.calculateEventWithQuantity(quantity: 1);
        int otherStockEvent = totalEvent - outOfStockEvent - limitedStockEvent;
        List<EventSummeryInfo> eventSummeryItems = [
          
          EventSummeryInfo(
            title: "All Event",
            eventsCount: totalEvent,
            svgSrc: "assets/icons/Event.svg",
            color: primaryColor,
            percentage: 100,
          ),
          EventSummeryInfo(
            title: "Out of Stock",
            eventsCount: outOfStockEvent,
            svgSrc: "assets/icons/Event2.svg",
            color: Color(0xFFEA3829),
            percentage:
                totalEvent != 0 ? (outOfStockEvent / totalEvent) * 100 : 0,
          ),
          EventSummeryInfo(
            title: "Limited Stock",
            eventsCount: limitedStockEvent,
            svgSrc: "assets/icons/Event3.svg",
            color: Color(0xFFECBE23),
            percentage:
                totalEvent != 0 ? (limitedStockEvent / totalEvent) * 100 : 0,
          ),
          EventSummeryInfo(
            title: "Other Stock",
            eventsCount: otherStockEvent,
            svgSrc: "assets/icons/Event4.svg",
            color: Color(0xFF47e228),
            percentage:
                totalEvent != 0 ? (otherStockEvent / totalEvent) * 100 : 0,
          ),
        ];

        return Column(
          children: [
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: eventSummeryItems.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: defaultPadding,
                mainAxisSpacing: defaultPadding,
                childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
              ),
              itemBuilder: (context, index) => EventSummeryCard(
                info: eventSummeryItems[index],
                onTap: (eventType) {
                  context.dataProvider.filterEventsByQuantity(eventType ?? '');
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
