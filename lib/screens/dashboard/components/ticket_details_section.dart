import '../../../core/data/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/constants.dart';
import 'chart.dart';
import 'ticket_info_card.dart';

class TicketDetailsSection extends StatelessWidget {
  const TicketDetailsSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) {
        int totalTicket = dataProvider.calculateTicketsWithStatus();
        int pendingTicket =
            dataProvider.calculateTicketsWithStatus(status: 'pending');
        int processingTicket =
            dataProvider.calculateTicketsWithStatus(status: 'processing');
        int cancelledTicket =
            dataProvider.calculateTicketsWithStatus(status: 'cancelled');
        int shippedTicket =
            dataProvider.calculateTicketsWithStatus(status: 'shipped');
        int deliveredTicket =
            dataProvider.calculateTicketsWithStatus(status: 'delivered');
        return Container(
          padding: EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tickets Details",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: defaultPadding),
              Chart(isOrder: false,),
              TicketInfoCard(
                svgSrc: "assets/icons/delivery1.svg",
                title: "All Tickets",
                totalTicket: totalTicket,
              ),
              TicketInfoCard(
                svgSrc: "assets/icons/delivery5.svg",
                title: "Pending Tickets",
                totalTicket: pendingTicket,
              ),
              TicketInfoCard(
                svgSrc: "assets/icons/delivery6.svg",
                title: "Processed Tickets",
                totalTicket: processingTicket,
              ),
              TicketInfoCard(
                svgSrc: "assets/icons/delivery2.svg",
                title: "Cancelled Tickets",
                totalTicket: cancelledTicket,
              ),
              TicketInfoCard(
                svgSrc: "assets/icons/delivery4.svg",
                title: "Shipped Tickets",
                totalTicket: shippedTicket,
              ),
              TicketInfoCard(
                svgSrc: "assets/icons/delivery3.svg",
                title: "Delivered Tickets",
                totalTicket: deliveredTicket,
              ),
            ],
          ),
        );
      },
    );
  }
}
