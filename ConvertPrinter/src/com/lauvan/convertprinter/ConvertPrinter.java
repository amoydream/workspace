package com.lauvan.convertprinter;

import javax.jws.WebService;

@WebService
public interface ConvertPrinter {
	String convert(String sourceFile, String fileType);

	void print(String sourceFile);
}
