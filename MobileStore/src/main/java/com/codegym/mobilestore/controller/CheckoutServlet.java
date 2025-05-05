package com.codegym.mobilestore.controller;

import com.codegym.mobilestore.model.Customer;
import com.codegym.mobilestore.model.Item;
import com.codegym.mobilestore.model.Order;
import com.codegym.mobilestore.model.OrderDetail;
import com.codegym.mobilestore.service.DBConnection;
import com.codegym.mobilestore.service.OrderDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private OrderDAO orderDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            List<Item> cart = (List<Item>) session.getAttribute("cart");
            Connection conn = DBConnection.getConnection();
            orderDAO.checkAllProductQuantities(cart,conn);
            request.getRequestDispatcher("checkout/checkout-form.jsp").forward(request, response);
        }
        catch (SQLException e) {
            request.setAttribute("checkoutError", e.getMessage());
            request.getRequestDispatcher("cart/list.jsp").forward(request, response);
        }
    }

    private void showSuccessPayment(HttpServletRequest request, HttpServletResponse response, int orderID) throws ServletException, IOException {
        List<OrderDetail> orderDetailList = orderDAO.getOrderDetails(orderID);
        Order order = orderDAO.findById(orderID);
        Customer customer = orderDetailList.get(0).getOrder().getCustomer();
        request.setAttribute("orderDetailList", orderDetailList);
        request.setAttribute("customer", customer);
        request.setAttribute("order", order);

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        String formattedDate = order.getOrderDate().format(formatter);
        request.setAttribute("createdAt", formattedDate);
        request.getRequestDispatcher("checkout/checkout-success.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<Item> cart = (List<Item>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart/list.jsp");
            return;
        }

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");


        // Lấy thông tin giao hàng từ form
        String customerName = request.getParameter("customerName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String paymentMethod = request.getParameter("paymentMethod");

        Map<String, String> customer = new HashMap<String, String>();
        customer.put("customerName", customerName);
        customer.put("phone", phone);
        customer.put("address", address);
        customer.put("paymentMethod", paymentMethod);
        try {
            int orderID = orderDAO.checkOut(cart, customer);
            showSuccessPayment(request,response, orderID);
            session.removeAttribute("cart");
        } catch (SQLException e) {
            request.setAttribute("checkoutError", e.getMessage());
            request.getRequestDispatcher("cart/list.jsp").forward(request, response);
        }

    }
}
