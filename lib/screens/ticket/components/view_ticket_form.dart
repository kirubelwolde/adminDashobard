import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../models/ticket.dart';
import '../../../utility/constants.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_text_field.dart';
import '../provider/ticket_provider.dart';

class TicketSubmitForm extends StatelessWidget {
  final Ticket? ticket;

  const TicketSubmitForm({Key? key, this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    context.read<TicketProvider>().trackingUrlCtrl.text =
        ticket?.trackingUrl ?? '';
    context.read<TicketProvider>().ticketForUpdate = ticket;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(defaultPadding),
        width: size.width * 0.5, // Adjust width based on screen size
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF012437), Color(0xFF4A934A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Form(
          key:
              Provider.of<TicketProvider>(context, listen: false).ticketFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: formRow(
                      'Name:',
                      Text(ticket?.userID?.name ?? 'N/A',
                          style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  Expanded(
                    child: formRow(
                      'Ticket Id:',
                      Text(ticket?.sId ?? 'N/A',
                          style: TextStyle(fontSize: 12)),
                    ),
                  ),
                ],
              ),
              itemsSection(ticket),
              addressSection(ticket),
              Gap(10),
              paymentDetailsSection(ticket),
              formRow(
                'Ticket Status:',
                Consumer<TicketProvider>(
                  builder: (context, ticketProvider, child) {
                    return CustomDropdown(
                      hintText: 'Status',
                      initialValue: ticketProvider.selectedTicketStatus,
                      items: [
                        'pending',
                        'processing',
                        'shipped',
                        'delivered',
                        'cancelled'
                      ],
                      displayItem: (val) => val,
                      onChanged: (newValue) {
                        ticketProvider.selectedTicketStatus =
                            newValue ?? 'pending';
                        ticketProvider.updateUI();
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select status';
                        }
                        return null;
                      },
                    );
                  },
                ),
              ),
              formRow(
                'Tracking URL:',
                CustomTextField(
                  labelText: 'Tracking Url',
                  onSave: (val) {},
                  controller: context.read<TicketProvider>().trackingUrlCtrl,
                ),
              ),
              Gap(defaultPadding * 2),
              actionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget formRow(String label, Widget dataWidget) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Expanded(
            flex: 2,
            child: dataWidget,
          ),
        ],
      ),
    );
  }

  Widget addressSection(Ticket? ticket) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor, // Light grey background to stand out
        borderRadius: BorderRadius.circular(8.0),
        border:
            Border.all(color: Colors.blueAccent), // Blue border for emphasis
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Shipping Address',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          ),
          formRow(
            'Phone:',
            Text(ticket?.shippingAddress?.phone ?? 'N/A',
                style: TextStyle(fontSize: 16)),
          ),
          formRow(
            'Street:',
            Text(ticket?.shippingAddress?.street ?? 'N/A',
                style: TextStyle(fontSize: 16)),
          ),
          formRow(
            'City:',
            Text(ticket?.shippingAddress?.city ?? 'N/A',
                style: TextStyle(fontSize: 16)),
          ),
          formRow(
            'Postal Code:',
            Text(ticket?.shippingAddress?.postalCode ?? 'N/A',
                style: TextStyle(fontSize: 16)),
          ),
          formRow(
            'Country:',
            Text(ticket?.shippingAddress?.country ?? 'N/A',
                style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget paymentDetailsSection(Ticket? ticket) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        border: Border.all(color: Colors.blueAccent),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Payment Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          formRow(
            'Payment Method:',
            Text(ticket?.paymentMethod ?? 'N/A',
                style: TextStyle(fontSize: 16)),
          ),
          formRow(
            'Coupon Code:',
            Text(ticket?.couponCode?.couponCode ?? 'N/A',
                style: TextStyle(fontSize: 16)),
          ),
          formRow(
            'Ticket Sub Total:',
            Text(
              '\$${ticket?.ticketTotal?.subtotal?.toStringAsFixed(2) ?? 'N/A'}',
              style: TextStyle(fontSize: 16),
            ),
          ),
          formRow(
            'Discount:',
            Text(
              '\$${ticket?.ticketTotal?.discount?.toStringAsFixed(2) ?? 'N/A'}',
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
          ),
          formRow(
            'Grand Total:',
            Text(
              '\$${ticket?.ticketTotal?.total?.toStringAsFixed(2) ?? 'N/A'}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemsSection(Ticket? ticket) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        border: Border.all(color: Colors.blueAccent),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Items',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          _buildItemsList(ticket),
          SizedBox(
              height:
                  defaultPadding), // Add some spacing before the total price
          formRow(
            'Total Price:',
            Text(
              '\$${ticket?.totalPrice?.toStringAsFixed(2) ?? 'N/A'}',
              style: TextStyle(fontSize: 16, color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsList(Ticket? ticket) {
    if (ticket?.items == null || ticket!.items!.isEmpty) {
      return Text('No items', style: TextStyle(fontSize: 16));
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: ticket!.items!.length,
      itemBuilder: (context, index) {
        final item = ticket!.items![index];
        return Padding(
          padding: EdgeInsets.only(bottom: 4.0), // Add spacing between items
          child: Text(
            '${item.eventName}: ${item.quantity} x \$${item.price?.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 16),
          ),
        );
      },
    );
  }

  Widget actionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue, // foreground
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        Gap(defaultPadding),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green, // foreground
          ),
          onPressed: () {
            if (Provider.of<TicketProvider>(context, listen: false)
                .ticketFormKey
                .currentState!
                .validate()) {
              Provider.of<TicketProvider>(context, listen: false)
                  .ticketFormKey
                  .currentState!
                  .save();
              context.read<TicketProvider>().updateTicket();
              Navigator.of(context).pop();
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}

// How to show the ticket popup
void showTicketForm(BuildContext context, Ticket? ticket) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
          child: Text(
            'Ticket Details'.toUpperCase(),
            style: TextStyle(color: primaryColor),
          ),
        ),
        content: TicketSubmitForm(ticket: ticket),
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      );
    },
  );
}
