package com.national.computer.util;

import javax.crypto.Cipher;
import javax.crypto.CipherInputStream;
import javax.crypto.CipherOutputStream;
import javax.crypto.spec.SecretKeySpec;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PushbackInputStream;
import java.security.Key;
import java.util.zip.Deflater;
import java.util.zip.GZIPInputStream;
import java.util.zip.GZIPOutputStream;

public class AESUtil {
    private static final String ALGORITHM = "AES";
    private static final String TRANSFORMATION = "AES";
    
    // 16-byte key for AES-128
    private static final byte[] KEY = "MySuperSecretKey".getBytes();

    private static class ConfigurableGZIPOutputStream extends GZIPOutputStream {
        public ConfigurableGZIPOutputStream(OutputStream out, int level) throws IOException {
            super(out, 8192);
            def.setLevel(level);
        }
    }

    public static void encrypt(InputStream inputStream, OutputStream outputStream) throws Exception {
        Key secretKey = new SecretKeySpec(KEY, ALGORITHM);
        Cipher cipher = Cipher.getInstance(TRANSFORMATION);
        cipher.init(Cipher.ENCRYPT_MODE, secretKey);

        try (CipherOutputStream cipherOutputStream = new CipherOutputStream(outputStream, cipher);
             ConfigurableGZIPOutputStream gzipOutputStream = new ConfigurableGZIPOutputStream(cipherOutputStream, Deflater.BEST_COMPRESSION)) {
            byte[] buffer = new byte[8192];
            int bytesRead;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                gzipOutputStream.write(buffer, 0, bytesRead);
            }
            gzipOutputStream.finish();
        }
    }

    public static void decrypt(InputStream inputStream, OutputStream outputStream) throws Exception {
        Key secretKey = new SecretKeySpec(KEY, ALGORITHM);
        Cipher cipher = Cipher.getInstance(TRANSFORMATION);
        cipher.init(Cipher.DECRYPT_MODE, secretKey);

        try (CipherInputStream cipherInputStream = new CipherInputStream(inputStream, cipher)) {
            PushbackInputStream pushbackInputStream = new PushbackInputStream(cipherInputStream, 2);
            byte[] header = new byte[2];
            int bytesRead = pushbackInputStream.read(header);
            if (bytesRead == 2) {
                int magic = ((header[0] & 0xff) | ((header[1] & 0xff) << 8));
                pushbackInputStream.unread(header);
                if (magic == GZIPInputStream.GZIP_MAGIC) {
                    try (GZIPInputStream gzipInputStream = new GZIPInputStream(pushbackInputStream, 8192)) {
                        byte[] buffer = new byte[8192];
                        int n;
                        while ((n = gzipInputStream.read(buffer)) != -1) {
                            outputStream.write(buffer, 0, n);
                        }
                    }
                    return;
                }
            } else if (bytesRead > 0) {
                pushbackInputStream.unread(header, 0, bytesRead);
            }
            byte[] buffer = new byte[8192];
            int n;
            while ((n = pushbackInputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, n);
            }
        }
    }
}

