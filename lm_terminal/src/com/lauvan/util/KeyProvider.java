package com.lauvan.util;

import java.util.UUID;

public class KeyProvider {

	public static String getPrimaryKey(){
		return UUID.randomUUID().toString();
	}
	
	public static void main(String[] args) {
		System.out.println(getPrimaryKey());
		System.out.println(getPrimaryKey().length());
	}
}
