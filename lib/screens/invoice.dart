import 'dart:io';

import 'package:flutter/cupertino.dart' as cu;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import '../providers/cart.dart';
import '../widgets/invoice_item.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateInvoice {
  final pdf = Document();
  final file = File("assets/example_invoice.pdf");

  void saveInvoice(Cart cart) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final netImage = await networkImage(prefs.getString("logoUrl")!);
    pdf.addPage(
      Page(
        pageFormat: PdfPageFormat.roll80,
        build: (Context context) {
          return Column(
            children: [
              Image(netImage),
              ListView.separated(
                  separatorBuilder: (context, i) {
                    return Divider();
                  },
                  itemBuilder: (context, i) {
                    return ItemInCart()
                        .buildInvoiceItem(cart.cartItems.values.toList()[i]);
                  },
                  itemCount: cart.cartItems.length),
              Divider(),
              Center(
                child: Text(
                  'Total: ${cart.cartTotalPrice} LE',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(prefs.getString("slogan")!),
                    Text(prefs.getString("hotline")!),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
    try {
      await file.writeAsBytes(await pdf.save());
      print(await Printing.listPrinters().then((printers) => printers.first));
      await Printing.directPrintPdf(
          printer: await Printing.listPrinters().then((availablePrinters) =>
              availablePrinters
                  .firstWhere((printer) => printer.isAvailable == true)),
          onLayout: (PdfPageFormat format) async => pdf.save(),
          format: PdfPageFormat.roll80);
      // print(await Printing.info());
      // await Printing.layoutPdf(
      //     onLayout: (PdfPageFormat format) async => pdf.save(),
      //     format: PdfPageFormat.roll80);
    } catch (e) {
      print(e);
    }
  }
}
