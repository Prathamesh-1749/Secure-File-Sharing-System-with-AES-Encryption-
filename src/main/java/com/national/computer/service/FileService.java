package com.national.computer.service;

import com.national.computer.dto.FileInfo;
import com.national.computer.util.AESUtil;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.nio.file.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;
import java.util.Properties;
import java.text.SimpleDateFormat;

@Service
public class FileService {

    private final Path uploadDir = Paths.get("F:", "Encrypted Uploades").toAbsolutePath().normalize();

    public FileService() {
        try {
            Files.createDirectories(uploadDir);
        } catch (IOException e) {
            throw new RuntimeException("Could not create upload directory!", e);
        }
    }

    private static class CountingOutputStream extends OutputStream {
        private long count = 0;
        @Override
        public void write(int b) { count++; }
        @Override
        public void write(byte[] b, int off, int len) { count += len; }
        public long getCount() { return count; }
    }

    public String saveEncrypted(MultipartFile file) throws Exception {
        String originalFilename = file.getOriginalFilename();
        if (originalFilename == null || originalFilename.trim().isEmpty()) {
            originalFilename = "unknown";
        }

        // Append .enc to the original filename
        String storedFileName = originalFilename + ".enc";
        Path targetLocation = uploadDir.resolve(storedFileName).normalize();

        if (!targetLocation.startsWith(uploadDir)) {
             throw new SecurityException("Invalid file path");
        }

        try (InputStream inputStream = file.getInputStream();
             OutputStream outputStream = Files.newOutputStream(targetLocation)) {
            AESUtil.encrypt(inputStream, outputStream);
        }

        long originalSize = file.getSize();
        long encryptedSize = Files.size(targetLocation);
        Path metaPath = uploadDir.resolve(storedFileName + ".meta").normalize();
        Properties meta = new Properties();
        meta.setProperty("originalSize", String.valueOf(originalSize));
        meta.setProperty("encryptedSize", String.valueOf(encryptedSize));
        try (OutputStream metaOut = Files.newOutputStream(metaPath)) {
            meta.store(metaOut, "SecureShare File Metadata");
        }

        return storedFileName;
    }

    public List<FileInfo> listFiles() {
        List<FileInfo> fileInfos = new ArrayList<>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        try (DirectoryStream<Path> stream = Files.newDirectoryStream(uploadDir, "*.enc")) {
            for (Path path : stream) {
                File f = path.toFile();
                String storedName = f.getName();
                String originalName = storedName.endsWith(".enc") ? storedName.substring(0, storedName.length() - 4) : storedName;
                String uploadDate = sdf.format(new Date(f.lastModified()));
                long encryptedSize = f.length();
                long originalSize = encryptedSize;

                Path metaPath = uploadDir.resolve(storedName + ".meta");
                if (Files.exists(metaPath)) {
                    try (InputStream metaIn = Files.newInputStream(metaPath)) {
                        Properties meta = new Properties();
                        meta.load(metaIn);
                        originalSize = Long.parseLong(meta.getProperty("originalSize", String.valueOf(encryptedSize)));
                        encryptedSize = Long.parseLong(meta.getProperty("encryptedSize", String.valueOf(encryptedSize)));
                    } catch (Exception ignore) {}
                } else {
                    try {
                        CountingOutputStream sink = new CountingOutputStream();
                        streamDecrypted(storedName, sink);
                        originalSize = sink.getCount();
                        Properties meta = new Properties();
                        meta.setProperty("originalSize", String.valueOf(originalSize));
                        meta.setProperty("encryptedSize", String.valueOf(encryptedSize));
                        try (OutputStream metaOut = Files.newOutputStream(metaPath)) {
                            meta.store(metaOut, "SecureShare File Metadata");
                        }
                    } catch (Exception ignore) {}
                }

                FileInfo info = new FileInfo(originalName, storedName, uploadDate, originalSize, encryptedSize);
                fileInfos.add(info);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return fileInfos;
    }

    public void streamDecrypted(String fileName, OutputStream responseOutputStream) throws Exception {
        Path filePath = uploadDir.resolve(fileName).normalize();
        if (!filePath.startsWith(uploadDir)) {
            throw new SecurityException("Invalid file path");
        }

        if (Files.exists(filePath)) {
            try (InputStream inputStream = Files.newInputStream(filePath)) {
                AESUtil.decrypt(inputStream, responseOutputStream);
            }
        } else {
            throw new FileNotFoundException("File not found: " + fileName);
        }
    }

    public boolean deleteFile(String fileName) {
        Path filePath = uploadDir.resolve(fileName).normalize();
        if (!filePath.startsWith(uploadDir)) {
            return false; // Prevent directory traversal
        }
        try {
            Path metaPath = uploadDir.resolve(fileName + ".meta").normalize();
            if (metaPath.startsWith(uploadDir)) {
                Files.deleteIfExists(metaPath);
            }
            return Files.deleteIfExists(filePath);
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }
}

