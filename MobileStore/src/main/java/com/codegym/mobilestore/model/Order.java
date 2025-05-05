package com.codegym.mobilestore.model;
import java.time.LocalDateTime;
public class Order {
    private int id;
    private double totalPrice;
    private LocalDateTime orderDate;
    private Customer customer;
    private String paymentMethod;

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public Order() {}

    public Order(int id, double totalPrice, LocalDateTime orderDate, String paymentMethod,Customer customer) {
        this.id = id;
        this.paymentMethod = paymentMethod;
        this.totalPrice = totalPrice;
        this.orderDate = orderDate;
        this.customer = customer;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public LocalDateTime getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(LocalDateTime orderDate) {
        this.orderDate = orderDate;
    }


    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

}
