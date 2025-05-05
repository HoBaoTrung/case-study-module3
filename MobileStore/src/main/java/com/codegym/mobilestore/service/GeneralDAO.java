package com.codegym.mobilestore.service;

import com.codegym.mobilestore.model.Product;

import java.util.List;
import java.util.Map;

public interface GeneralDAO <E> {
   E findById(int id);
}
