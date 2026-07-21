package com.codebase.middle_order_service.repository;

import com.codebase.middle_order_service.model.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {

    @Query(value = "SELECT * FROM orders WHERE product_code = :productCode", nativeQuery = true)
    List<Order> findByProductCodeNative(@Param("productCode") String productCode);
}