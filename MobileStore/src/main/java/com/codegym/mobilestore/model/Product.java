package com.codegym.mobilestore.model;


public class Product {
    private Integer productId;
    private String productName;
    private String description;
    private double price;
    private Integer stockQuantity;
    private String imageUrl;
    public Product() {}

    public Product(Integer productId, String productName, String description, double price, Integer stockQuantity, String imageUrl) {
        this.productId = productId;
        this.productName = productName;
        this.description = description;
        this.price = price;
        this.stockQuantity = stockQuantity;
        this.imageUrl = imageUrl;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Integer getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(Integer stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    @Override
    public String toString() {
        return "Product{" +
                "stockQuantity=" + stockQuantity +
                ", price=" + price +
                ", description='" + description + '\'' +
                ", productName='" + productName + '\'' +
                ", productId=" + productId +
                '}';
    }
}
