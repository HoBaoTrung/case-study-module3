package com.codegym.mobilestore.controller;

import com.codegym.mobilestore.model.Brand;
import com.codegym.mobilestore.model.Category;
import com.codegym.mobilestore.model.Product;
import com.codegym.mobilestore.service.BrandDAO;
import com.codegym.mobilestore.service.CategoryDAO;
import com.codegym.mobilestore.service.ProductDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

@WebServlet(name = "ProductServlet", value = "/products")
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int RECORDS_PER_PAGE = 3;

    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;
    private BrandDAO brandDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO();
        brandDAO = new BrandDAO();
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
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Lấy keyword tìm kiếm
        String keyword = request.getParameter("keyword");

        // Lấy danh sách category được chọn (checkbox)
        String[] selectedCategories = request.getParameterValues("cateID");

        // Lấy khoảng giá
        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");

        Double minPrice = (minPriceStr != null && !minPriceStr.isEmpty())
                ? Double.valueOf(minPriceStr) : null;

        Double maxPrice = (maxPriceStr != null && !maxPriceStr.isEmpty())
                ? Double.valueOf(maxPriceStr) : null;


        // Lấy danh sách hãng (brand)
        String[] selectedBrands = request.getParameterValues("brandID");

        Map<String, Object> filterParams = new HashMap<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            filterParams.put("keyword", keyword);
        }

        if (selectedCategories != null && selectedCategories.length > 0) {
            filterParams.put("categories", selectedCategories);
        }

        if (selectedBrands != null && selectedBrands.length > 0) {
            filterParams.put("brands", selectedBrands);
        }

        if (minPrice != null) {
            filterParams.put("minPrice", minPrice);
        }

        if (maxPrice != null) {
            filterParams.put("maxPrice", maxPrice);
        }

//        Phân trang
        String pageStr = request.getParameter("page");
        int page = (pageStr != null) ? Integer.parseInt(pageStr) : 1;

        int start = (page - 1) * RECORDS_PER_PAGE;
        filterParams.put("start", start);
        filterParams.put("recordsPerPage", RECORDS_PER_PAGE);
        int totalRecords = 0, totalPages;


        List<Product> products;
        if (filterParams.size() == 0) {
            products = productDAO.findByPage(start, RECORDS_PER_PAGE);
            totalRecords = productDAO.countTotalRecords();

        } else {
            Map result = productDAO.searchProduct(filterParams);
            Object resultList = result.get("products");
            Object resultTotal = result.get("total");
            products = (List<Product>) resultList;
            totalRecords = (int) resultTotal;
        }

        totalPages = (int) Math.ceil(totalRecords * 1.0 / RECORDS_PER_PAGE);
        List<Category> categories = categoryDAO.findAll();
        List<Brand> brands = brandDAO.findAll();
        String[] rangeValues = productDAO.getRangePrice();
        request.setAttribute("products", products);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("categories", categories);
        request.setAttribute("brands", brands);
        request.setAttribute("minPrice", rangeValues[0]);
        request.setAttribute("maxPrice", rangeValues[1]);

        request.getRequestDispatcher("product/list.jsp").forward(request, response);
    }

}
