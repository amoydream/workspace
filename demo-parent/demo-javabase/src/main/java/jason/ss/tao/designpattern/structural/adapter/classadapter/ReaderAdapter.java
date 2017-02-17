package jason.ss.tao.designpattern.structural.adapter.classadapter;

public class ReaderAdapter extends DocumentReader implements PDFReader {
	@Override
	public void readPDF(String uri) {
		System.out.println("Reading " + uri);
	}
}
