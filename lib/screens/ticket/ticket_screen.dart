import 'package:admin/utility/extensions.dart';

import 'components/ticket_header.dart';
import 'components/ticket_list_section.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../utility/constants.dart';
import '../../widgets/custom_dropdown.dart';

class TicketScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            TicketHeader(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Text(
                              "My Tickets",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          Gap(20),
                          SizedBox(
                            width: 280,
                            child: CustomDropdown(
                              hintText: 'Filter Ticket By status',
                              initialValue: 'All ticket',
                              items: ['All ticket', 'pending', 'processing', 'shipped', 'delivered', 'cancelled'],
                              displayItem: (val) => val,
                              onChanged: (newValue) {
                                if (newValue?.toLowerCase() == 'all ticket') {
                                  context.dataProvider.filterTickets('');
                                } else {
                                  context.dataProvider.filterTickets(newValue?.toLowerCase() ?? '');
                                }
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select status';
                                }
                                return null;
                              },
                            ),
                          ),
                          Gap(40),
                          IconButton(
                              onPressed: () {
                                context.dataProvider.getAllTickets(showSnack: true);
                              },
                              icon: Icon(Icons.refresh)),
                        ],
                      ),
                      Gap(defaultPadding),
                      TicketListSection(),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
