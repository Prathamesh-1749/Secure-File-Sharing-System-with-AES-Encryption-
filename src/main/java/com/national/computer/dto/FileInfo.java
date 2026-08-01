package com.national.computer.dto;

public class FileInfo {
    private String originalName;
    private String storedName;
    private String uploadDate;
    private long originalSize;
    private long encryptedSize;

    public FileInfo() {}

    public FileInfo(String originalName, String storedName) {
        this.originalName = originalName;
        this.storedName = storedName;
    }

    public FileInfo(String originalName, String storedName, String uploadDate) {
        this.originalName = originalName;
        this.storedName = storedName;
        this.uploadDate = uploadDate;
    }

    public FileInfo(String originalName, String storedName, String uploadDate, long originalSize, long encryptedSize) {
        this.originalName = originalName;
        this.storedName = storedName;
        this.uploadDate = uploadDate;
        this.originalSize = originalSize;
        this.encryptedSize = encryptedSize;
    }

    public String getOriginalName() {
        return originalName;
    }

    public void setOriginalName(String originalName) {
        this.originalName = originalName;
    }

    public String getStoredName() {
        return storedName;
    }

    public void setStoredName(String storedName) {
        this.storedName = storedName;
    }

    public String getUploadDate() {
        return uploadDate;
    }

    public void setUploadDate(String uploadDate) {
        this.uploadDate = uploadDate;
    }

    public long getOriginalSize() {
        return originalSize;
    }

    public void setOriginalSize(long originalSize) {
        this.originalSize = originalSize;
    }

    public long getEncryptedSize() {
        return encryptedSize;
    }

    public void setEncryptedSize(long encryptedSize) {
        this.encryptedSize = encryptedSize;
    }

    public String getFormattedOriginalSize() {
        return formatSize(originalSize);
    }

    public String getFormattedEncryptedSize() {
        return formatSize(encryptedSize);
    }

    public long getSizeReductionPercentage() {
        if (originalSize <= 0) return 0;
        long diff = originalSize - encryptedSize;
        if (diff <= 0) return 0;
        return (diff * 100) / originalSize;
    }

    private String formatSize(long bytes) {
        if (bytes <= 0) return "0 B";
        if (bytes < 1024) return bytes + " B";
        int exp = (int) (Math.log(bytes) / Math.log(1024));
        char pre = "KMGTPE".charAt(exp - 1);
        return String.format("%.1f %sB", bytes / Math.pow(1024, exp), pre);
    }
}

