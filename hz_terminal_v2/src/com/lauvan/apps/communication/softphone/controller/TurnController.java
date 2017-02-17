package com.lauvan.apps.communication.softphone.controller;

import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.core.annotation.RouteBind;

@RouteBind(path="Main/turn",viewPath="communication/softphone1")
public class TurnController extends BaseController {
	
      public void getBook(){
    	  render("getBook.jsp");
      }
      
      public void  getAllDialRecord(){
    	  render("getDialRecord.jsp");
      }
      
      public void getSms(){
    	  render("getSms.jsp");
      }
      
      public void getSpeedDial(){
    	  render("getSpeedDial.jsp");
      }
     
      public void getDialVoice(){
    	  render("getDialVoice.jsp");
      }
}
