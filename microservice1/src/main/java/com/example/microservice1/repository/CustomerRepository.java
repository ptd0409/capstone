package com.example.microservice1.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.example.microservice1.model.Customer;

public interface CustomerRepository extends JpaRepository<Customer, Long> {
}
