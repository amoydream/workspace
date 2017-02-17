package com.lauvan.convertprint.service;

import javax.jws.WebService;

@WebService
public interface ConvertPrintService {
	String convert(String sourceFile, String fileType);

	void print(String sourceFile);
}
