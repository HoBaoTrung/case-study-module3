package com.codegym.mobilestore.service;

import java.util.List;

public interface PageableDAO<E> {
    List<E> findByPage(int offset, int limit);
    int countTotalRecords();
}
