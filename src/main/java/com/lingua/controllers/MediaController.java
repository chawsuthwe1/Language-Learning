package com.lingua.controllers;

import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.MediaTypeFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.net.MalformedURLException;
import java.nio.file.Path;
import java.nio.file.Paths;

@Controller
public class MediaController {

    private final Path audioRoot = Paths.get("uploads").resolve("audio").toAbsolutePath().normalize();

    @GetMapping("/media/audio/{fileName:.+}")
    public ResponseEntity<Resource> serveAudio(@PathVariable String fileName) throws MalformedURLException {
        // Prevent path traversal
        Path file = audioRoot.resolve(fileName).normalize();
        if (!file.startsWith(audioRoot)) {
            return ResponseEntity.badRequest().build();
        }
        Resource res = new UrlResource(file.toUri());
        if (!res.exists()) return ResponseEntity.notFound().build();

        MediaType mt = MediaTypeFactory.getMediaType(fileName).orElse(MediaType.APPLICATION_OCTET_STREAM);
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + file.getFileName() + "\"")
                .contentType(mt)
                .body(res);
    }
}
