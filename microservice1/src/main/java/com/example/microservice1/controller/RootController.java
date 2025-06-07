package com.example.microservice1.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class RootController {

    @GetMapping("/api")
    public String home() {
        return "Welcome to Microservice 1!";
    }
}
