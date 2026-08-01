package com.national.computer.controller;

import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.national.computer.dto.FileInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.national.computer.service.FileService;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class FileController {
    private static final Logger log = Logger.getLogger(FileController.class.getName());

    @Autowired
    private FileService fileService;

    @GetMapping("/")
    public String Home() { return "index"; }

    @GetMapping("/login1")
    public String loginPage() { return "login"; }

    @GetMapping("/forgot")
    public String forgotPage() { return "forgot"; }

    @GetMapping("/registration")
    public String registrationPage() { return "registration"; }

    @GetMapping("/upload")
    public String uploadPage() { return "upload"; }

    @PostMapping("/uploadFile")
    public String uploadFile(@RequestParam("file") MultipartFile file, Model model, RedirectAttributes redirectAttrs) {
        try {
            if (file.isEmpty()) {
                redirectAttrs.addFlashAttribute("msg", "Please select a file");
                return "redirect:/upload";
            }
            String stored = fileService.saveEncrypted(file);
            redirectAttrs.addFlashAttribute("msg", "File uploaded and encrypted securely!");
            redirectAttrs.addFlashAttribute("fileName", stored);
            return "redirect:/files";
        } catch (Exception e) {
            log.log(Level.SEVERE, "Upload failed", e);
            redirectAttrs.addFlashAttribute("msg", "Upload failed: " + e.getMessage());
            return "redirect:/upload";
        }
    }

    @GetMapping("/files")
    public String listFiles(Model model) {
        List<FileInfo> files = fileService.listFiles();
        model.addAttribute("files", files);
        return "list";
    }

    @GetMapping("/download")
    public void downloadFile(@RequestParam("name") String fileName, HttpServletResponse response) {
        try {
            String originalFileName = fileName.endsWith(".enc") ? fileName.substring(0, fileName.length() - 4) : fileName;
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition", "attachment; filename=\"" + originalFileName + "\"");
            fileService.streamDecrypted(fileName, response.getOutputStream());
            response.flushBuffer();
        } catch (Exception e) {
            log.log(Level.SEVERE, "Download error for " + fileName, e);
            try { response.getWriter().write("Download failed"); } catch (Exception ignored) {}
        }
    }

    @PostMapping("/delete")
    public String deleteFile(@RequestParam("name") String fileName, RedirectAttributes redirectAttrs) {
        if (fileName == null || !fileName.endsWith(".enc")) {
            redirectAttrs.addFlashAttribute("msg", "Invalid file name for deletion");
            return "redirect:/files";
        }
        boolean ok = fileService.deleteFile(fileName);
        if (ok) redirectAttrs.addFlashAttribute("msg", "File deleted successfully");
        else redirectAttrs.addFlashAttribute("msg", "File not found or could not be deleted");
        return "redirect:/files";
    }

    @GetMapping("/logout1")
    public String logout(HttpSession session) {
        if (session != null) session.invalidate();
        return "logout";
    }
}