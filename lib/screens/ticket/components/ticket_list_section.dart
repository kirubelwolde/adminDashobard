import 'package:admin/utility/extensions.dart';

import '../../../core/data/data_provider.dart';
import 'view_ticket_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/color_list.dart';
import '../../../models/ticket.dart';
import '../../../utility/constants.dart';


class TicketListSection extends StatelessWidget {
  const TicketListSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            "All Ticket",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            width: double.infinity,
            child: Consumer<DataProvider>(
              builder: (context, dataProvider, child) {
                return DataTable(
                  columnSpacing: defaultPadding,
                  // minWidth: 600,
                  columns: [
                    DataColumn(
                      label: Text("Customer Name"),
                    ),
                    DataColumn(
                      label: Text("Ticket Amount"),
                    ),
                    DataColumn(
                      label: Text("Payment"),
                    ),
                    DataColumn(
                      label: Text("Status"),
                    ),
                    DataColumn(
                      label: Text("Date"),
                    ),
                    DataColumn(
                      label: Text("Edit"),
                    ),
                    DataColumn(
                      label: Text("Delete"),
                    ),
                  ],
                  rows: List.generate(
                    dataProvider.tickets.length,
                    (index) => ticketDataRow(dataProvider.tickets[index],index+1, delete: () {
                      context.ticketProvider.deleteTicket(dataProvider.tickets[index]);
                    }, edit: () {
                      showTicketForm(context, dataProvider.tickets[index]);
                    }),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

DataRow ticketDataRow(Ticket orderInfo, int index, {Function? edit, Function? delete}) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color: colors[index % colors.length],
                shape: BoxShape.circle,
              ),
              child: Text(index.toString(), textAlign: TextAlign.center),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(orderInfo.userID?.name ?? ''),
            ),
          ],
        ),
      ),
      DataCell(Text('${orderInfo.ticketTotal?.total}')),
      DataCell(Text(orderInfo.paymentMethod ?? '')),
      DataCell(Text(orderInfo.ticketStatus ?? '')),
      DataCell(Text(orderInfo.ticketDate ?? '')),
      DataCell(IconButton(
          onPressed: () {
            if (edit != null) edit();
          },
          icon: Icon(
            Icons.edit,
            color: Colors.white,
          ))),
      DataCell(IconButton(
          onPressed: () {
            if (delete != null) delete();
          },
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ))),
    ],
  );
}
