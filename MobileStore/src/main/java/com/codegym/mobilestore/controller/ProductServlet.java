package com.codegym.mobilestore.controller;

import com.codegym.mobilestore.model.Product;
import com.codegym.mobilestore.service.ProductDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductServlet", value = "/products")
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        try {
            switch (action) {
                case "create":
                    break;
                case "edit":
                    break;
                case "delete":
                    break;
                default:
                    listProducts(request, response);
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }

    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        List<Product> products = productDAO.findAll();
        List<Product> products = productDAO.findAllWithStoreProcedure();
        request.setAttribute("products", products);
        request.getRequestDispatcher("product/list.jsp").forward(request, response);
    }

}
