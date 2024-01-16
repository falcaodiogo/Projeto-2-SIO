package com.shashi.utility;

import javax.crypto.SecretKey;

import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;

public class KeyManager {
    private static SecretKey secretKey;

    static {
        try {
            secretKey = generateAesKey();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static SecretKey getSecretKey() {
        return secretKey;
    }

    private static SecretKey generateAesKey() {
		try {
			KeyGenerator keyGenerator = KeyGenerator.getInstance("AES");
			keyGenerator.init(128);
			return keyGenerator.generateKey();
		} catch (Exception e) {
			e.printStackTrace(); 
			return null;
		}
	}

    public static String encrypt(String data, SecretKey secretKey) {
		try {
			Cipher cipher = Cipher.getInstance("AES");
			cipher.init(Cipher.ENCRYPT_MODE, secretKey);
			byte[] encryptedBytes = cipher.doFinal(data.getBytes());
			return Base64.getEncoder().encodeToString(encryptedBytes);
		} catch (Exception e) {
			e.printStackTrace(); // Apenas para debug, você pode tratar de forma diferente conforme necessário
			return null;
		}
	}

    public static String decrypt(String data, SecretKey secretKey) {
        try {
            Cipher cipher = Cipher.getInstance("AES");
            cipher.init(Cipher.DECRYPT_MODE, secretKey);
            byte[] decryptedBytes = cipher.doFinal(Base64.getDecoder().decode(data));
            return new String(decryptedBytes);
        } catch (Exception e) {
            e.printStackTrace(); // Apenas para debug, você pode tratar de forma diferente conforme necessário
            return null;
        }
    }
}
