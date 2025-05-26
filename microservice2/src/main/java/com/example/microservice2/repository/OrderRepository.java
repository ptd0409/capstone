package com.example.microservice2.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.example.microservice2.model.Order;

public interface OrderRepository extends JpaRepository<Order, Long> {
}
