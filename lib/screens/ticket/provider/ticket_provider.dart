import 'dart:developer';

import 'package:get/get_connect/http/src/response/response.dart';

import '../../../models/api_response.dart';
import '../../../models/ticket.dart';
import '../../../services/http_services.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/data/data_provider.dart';
import '../../../utility/snack_bar_helper.dart';


class TicketProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;
  final ticketFormKey = GlobalKey<FormState>();
  TextEditingController trackingUrlCtrl = TextEditingController();
  String selectedTicketStatus = 'pending';
  Ticket? ticketForUpdate;

  TicketProvider(this._dataProvider);

  updateTicket() async {
    try {
      if (ticketForUpdate != null) {
        Map<String, dynamic> ticket = {'trackingUrl': trackingUrlCtrl.text, 'ticketStatus': selectedTicketStatus};
        final response =
        await service.updateItem(endpointUrl: 'tickets', itemData: ticket, itemId: ticketForUpdate?.sId ?? '');
        if (response.isOk) {
          ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
          if (apiResponse.success == true) {
            SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
            log('Ticket Updated');
            _dataProvider.getAllTickets();
          } else {
            SnackBarHelper.showErrorSnackBar('Failed to add Ticket: ${apiResponse.message}');
          }
        } else {
          SnackBarHelper.showErrorSnackBar('Error ${response.body?['message'] ?? response.statusText}');
        }
      }
    } catch (e) {
      print(e);
      SnackBarHelper.showErrorSnackBar('An error occurred: $e');
      rethrow;
    }
  }

  deleteTicket(Ticket ticket) async {
    try {
      Response response = await service.deleteItem(endpointUrl: 'tickets', itemId: ticket.sId ?? '');
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          SnackBarHelper.showSuccessSnackBar('Ticket Deleted Successfully');
          _dataProvider.getAllTickets();
        }
      } else {
        SnackBarHelper.showErrorSnackBar('Error ${response.body?['message'] ?? response.statusText}');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }


  //? to update UI
  updateUI() {
    notifyListeners();
  }
}
