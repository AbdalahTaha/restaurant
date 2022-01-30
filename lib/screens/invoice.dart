import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import '../providers/cart.dart';
import '../widgets/invoice_item.dart';
import 'package:printing/printing.dart';

class CreateInvoice {
  final pdf = Document();
  final file = File("assets/example_invoice.pdf");
  void saveInvoice(Cart cart) async {
    pdf.addPage(
      Page(
        pageFormat: PdfPageFormat.roll80,
        build: (Context context) {
          return Column(
            children: [
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
            ],
          );
        },
      ),
    );
    try {
      await file.writeAsBytes(await pdf.save());
      print(await Printing.listPrinters().then((printers) => printers.first));
      // await Printing.directPrintPdf(printer: await Printing.listPrinters().then((availablePrinters) => availablePrinters.first), onLayout: (PdfPageFormat format) async => pdf.save(),format:PdfPageFormat.roll80 );
      // print(await Printing.info());
      await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async => pdf.save(),
          format: PdfPageFormat.roll80);
    } catch (e) {
      print(e);
    }
    // return PdfPreview(
    //   build: (format) => pdf.save(),
    // );
  }
}
