package com.codegym.mobilestore.controller;

import com.codegym.mobilestore.model.Item;
import com.codegym.mobilestore.model.Product;
import com.codegym.mobilestore.service.ProductDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@WebServlet(name = "ShoppingCartServlet", urlPatterns = "/carts")
public class ShoppingCartServlet extends HttpServlet {
    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<Item> cart = (List<Item>) session.getAttribute("cart");
        request.setAttribute("cart", cart);
        request.getRequestDispatcher("cart/list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "";

        try {
            switch (action) {
                case "add":
                    addToCart(request);
                    break;
                case "update":
                    updateCart(request);
                    break;
                case "delete":
                    deleteItem(request);
                    break;
                default:
                    break;
            }
            response.sendRedirect("/carts");
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    private void deleteItem(HttpServletRequest request) {
        HttpSession session = request.getSession();
        List<Item> cart = (List<Item>) session.getAttribute("cart");
        int id = Integer.parseInt(request.getParameter("id"));

        Iterator<Item> iterator = cart.iterator();
        while (iterator.hasNext()) {
            Item item = iterator.next();
            if (item.getProduct().getProductId() == id) {
                iterator.remove();
                break;
            }
        }
    }

    private void updateCart(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        String type = request.getParameter("type");

        HttpSession session = request.getSession();
        List<Item> cart = (List<Item>) session.getAttribute("cart");

        if (cart != null) {
            int index = getIndex(id, cart);
            if (index != -1) {
                Item item = cart.get(index);
                int quantity = item.getQuantity();
                if ("add".equals(type)) {
                    item.setQuantity(quantity + 1);
                } else if ("sub".equals(type)) {
                    if (quantity > 1) {
                        item.setQuantity(quantity - 1);
                    } else {
                        cart.remove(index);
                    }
                }
            }
        }
    }

    private void addToCart(HttpServletRequest request) throws SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        HttpSession session = request.getSession();
        Product product = productDAO.findById(id);

        List<Item> cart = (List<Item>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        int index = getIndex(id, cart);
        if (index == -1) {
            cart.add(new Item(product, 1));
        } else {
            Item item = cart.get(index);
            item.setQuantity(item.getQuantity() + 1);
        }
    }

    private int getIndex(int id, List<Item> cart) {
        for (int i = 0; i < cart.size(); i++) {
            if (cart.get(i).getProduct().getProductId() == id) {
                return i;
            }
        }
        return -1;
    }
}
