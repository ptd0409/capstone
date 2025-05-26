package com.example.microservice2.controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import java.util.List;
import com.example.microservice2.model.Order;
import com.example.microservice2.repository.OrderRepository;

@CrossOrigin
@RestController
@RequestMapping("/orders")
public class OrderController {

    @Autowired
    private OrderRepository repository;

    @GetMapping
    public List<Order> getAllOrders() {
        return repository.findAll();
    }

    @PostMapping
    public Order createOrder(@RequestBody Order order) {
        return repository.save(order);
    }
}
