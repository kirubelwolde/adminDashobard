import 'package:admin/core/data/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../utility/constants.dart';
import 'components/dash_board_header.dart';
import 'components/add_product_form.dart';
import 'components/add_event_form.dart';
import 'components/order_details_section.dart';
import 'components/ticket_details_section.dart';
import 'components/product_list_section.dart';
import 'components/event_list_section.dart';
import 'components/product_summery_section.dart';
import 'components/event_summery_section.dart';
import 'components/chart.dart'; // Ensure this import is added

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            DashBoardHeader(),
            Gap(defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "My Events",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          ElevatedButton.icon(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: defaultPadding * 1.5,
                                vertical: defaultPadding,
                              ),
                            ),
                            onPressed: () {
                              showAddEventForm(context, null);
                            },
                            icon: Icon(Icons.add),
                            label: Text("Add New"),
                          ),
                          Gap(20),
                          IconButton(
                            onPressed: () {
                              context
                                  .read<DataProvider>()
                                  .getAllEvent(showSnack: true);
                            },
                            icon: Icon(Icons.refresh),
                          ),
                        ],
                      ),
                      Gap(defaultPadding),
                      EventSummerySection(),
                      Gap(defaultPadding),
                      EventListSection(),
                      Gap(defaultPadding),
                      // Chart(isOrder: false), // Chart for tickets
                    ],
                  ),
                ),
                SizedBox(width: defaultPadding),
                Expanded(
                  flex: 2,
                  child: TicketDetailsSection(),
                ),
              ],
            ),
            Gap(defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "My Products",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          ElevatedButton.icon(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: defaultPadding * 1.5,
                                vertical: defaultPadding,
                              ),
                            ),
                            onPressed: () {
                              showAddProductForm(context, null);
                            },
                            icon: Icon(Icons.add),
                            label: Text("Add New"),
                          ),
                          Gap(20),
                          IconButton(
                            onPressed: () {
                              context
                                  .read<DataProvider>()
                                  .getAllProduct(showSnack: true);
                            },
                            icon: Icon(Icons.refresh),
                          ),
                        ],
                      ),
                      Gap(defaultPadding),
                      ProductSummerySection(),
                      Gap(defaultPadding),
                      ProductListSection(),
                      Gap(defaultPadding),
                      // Chart(isOrder: true), // Chart for orders
                    ],
                  ),
                ),
                SizedBox(width: defaultPadding),
                Expanded(
                  flex: 2,
                  child: OrderDetailsSection(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
