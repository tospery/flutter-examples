///Package imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///Pdf import
import 'package:syncfusion_flutter_pdf/pdf.dart';

///Local imports
import '../../model/sample_view.dart';
import 'helper/save_file_mobile.dart'
    if (dart.library.html) 'helper/save_file_web.dart';

/// Find text from the PDF document
class FindTextPdf extends SampleView {
  /// Find text from the PDF document.
  const FindTextPdf(Key key) : super(key: key);
  @override
  _FindTextPdfState createState() => _FindTextPdfState();
}

class _FindTextPdfState extends SampleViewState {
  _FindTextPdfState();
  final TextEditingController _nameController =
      TextEditingController(text: 'PDF');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: model.cardThemeColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                  'This sample shows how to find a text along with bounds and page index in an existing PDF document.',
                  style: TextStyle(fontSize: 16, color: model.textColor)),
              const SizedBox(height: 20, width: 30),
              Center(
                  child: SizedBox(
                height: 60,
                width: 300,
                child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Enter the text to find',
                        labelStyle: TextStyle(
                            color:
                                model.themeData.brightness == Brightness.light
                                    ? Colors.grey
                                    : Colors.lightBlue)),
                    controller: _nameController,
                    style: TextStyle(color: model.textColor)),
              )),
              const SizedBox(height: 20, width: 30),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            model.backgroundColor),
                        padding: model.isMobile
                            ? null
                            : MaterialStateProperty.all(EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15)),
                      ),
                      onPressed: _viewTemplate,
                      child: Text('View Template',
                          style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(
                      height: 10,
                      width: 20,
                    ),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            model.backgroundColor),
                        padding: model.isMobile
                            ? null
                            : MaterialStateProperty.all(EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15)),
                      ),
                      onPressed: _generatePDF,
                      child: const Text('Find and Highlight',
                          style: TextStyle(color: Colors.white)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _viewTemplate() async {
    final List<int> documentBytes =
        await _readDocumentData('pdf_succinctly_template.pdf');
    await FileSaveHelper.saveAndLaunchFile(documentBytes, 'pdf_succinctly.pdf');
  }

  Future<void> _generatePDF() async {
    //Load the PDF document.
    final PdfDocument document = PdfDocument(
        inputBytes: await _readDocumentData('pdf_succinctly_template.pdf'));

    //Create PDF text extractor to find text.
    final PdfTextExtractor extractor = PdfTextExtractor(document);

    //Find the text
    final List<MatchedItem> result = extractor.findText([_nameController.text]);

    if (result.isEmpty) {
      document.dispose();
      _showDialog(_nameController.text);
    } else {
      //Highlight the searched text from the document.
      for (int i = 0; i < result.length; i++) {
        final MatchedItem item = result[i];

        //Get page.
        final PdfPage page = document.pages[item.pageIndex];

        //Set transparency to the page graphics.
        page.graphics.save();
        page.graphics.setTransparency(0.5);

        //Draw rectangle to highlight the text.
        page.graphics
            .drawRectangle(bounds: item.bounds, brush: PdfBrushes.yellow);
        page.graphics.restore();
      }

      //Save and dispose the document.
      final List<int> bytes = document.save();
      document.dispose();

      //Launch file.
      await FileSaveHelper.saveAndLaunchFile(bytes, 'find_text.pdf');
    }
  }

  Future<List<int>> _readDocumentData(String name) async {
    final ByteData data = await rootBundle.load('assets/pdf/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  void _showDialog(String text) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(''),
            content: Wrap(children: [
              Text('The text '),
              Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(' is not found.')
            ]),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              )
            ],
          );
        });
  }
}
