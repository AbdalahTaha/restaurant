import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import '../providers/cart.dart';
import '../widgets/invoice_item.dart';

class CreateInvoice {
  final pdf = Document();
  final file = File("C:\\Users\\KDS\\Downloads\\example_invoice.pdf");
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
    } catch (e) {
      print(e);
    }
  }
}
