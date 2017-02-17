package com.lauvan.util;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import javax.crypto.spec.IvParameterSpec;
import com.sun.org.apache.xml.internal.security.utils.Base64;

public class PwdUtil {
	private static final String PASSWORD_CRYPT_KEY = "@A5$d9`Z";
	private static final byte[] Iv = new byte[] { 0x12, 0x34, 0x56, 120, (byte) 0x90, (byte) 0xab, (byte) 0xcd, (byte) 0xef };

	public static String decrypt(String message, String key) throws Exception {
		byte[] bytesrc = Base64.decode(message);
		Cipher cipher = Cipher.getInstance("DES/CBC/PKCS5Padding");
		DESKeySpec desKeySpec = new DESKeySpec(key.getBytes("UTF-8"));
		SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
		SecretKey secretKey = keyFactory.generateSecret(desKeySpec);
		IvParameterSpec iv = new IvParameterSpec(Iv);
		cipher.init(Cipher.DECRYPT_MODE, secretKey, iv);
		byte[] retByte = cipher.doFinal(bytesrc);
		return new String(retByte);
	}

	public static byte[] encrypt(String message, String key) throws Exception {
		Cipher cipher = Cipher.getInstance("DES/CBC/PKCS5Padding");
		DESKeySpec desKeySpec = new DESKeySpec(key.getBytes("UTF-8"));
		SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
		SecretKey secretKey = keyFactory.generateSecret(desKeySpec);
		IvParameterSpec iv = new IvParameterSpec(Iv);
		cipher.init(Cipher.ENCRYPT_MODE, secretKey, iv);
		return cipher.doFinal(message.getBytes("UTF-8"));
	}

	/**
	 * 加密
	 * @param value
	 * @return
	 */
	public static String encrypt(String value) {
		String result = "";
		try {
			result = Base64.encode(encrypt(value, PASSWORD_CRYPT_KEY));
		} catch (Exception ex) {
			ex.printStackTrace();
			return "";
		}
		return result;
	}

	/**
	 * 解密
	 * @param value
	 * @return
	 */
	public static String decrypt(String value) {
		String result = "";
		try {
			result = decrypt(value, PASSWORD_CRYPT_KEY);
		} catch (Exception ex) {
			ex.printStackTrace();
			return "";
		}
		return result;
	}

}
