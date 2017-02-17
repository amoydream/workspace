package com.lauvan.print.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lauvan.convertprint.client.ConvertPrintClient;

public class PrintServlet extends HttpServlet {
	private static final long	serialVersionUID	= 1L;
	private ConvertPrintClient	printClient			= null;
	private String				sourceFolder		= null;

	@Override
	public void init(ServletConfig config) throws ServletException {
		String wsdlLocation = config.getInitParameter("wsdlLocation");
		printClient = ConvertPrintClient.getInstance(wsdlLocation);
		sourceFolder = config.getInitParameter("sourceFolder");
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPrint(request, response);
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPrint(request, response);
	}

	protected void doPrint(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String filename = request.getParameter("filename");
		printClient.print(sourceFolder + "\\" + filename);
		response.setContentType("text/xml; charset=UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Pragma", "no-cache");
		PrintWriter out = response.getWriter();
		out.write("{\"success\": true}");
		out.flush();
		out.close();
	}
}