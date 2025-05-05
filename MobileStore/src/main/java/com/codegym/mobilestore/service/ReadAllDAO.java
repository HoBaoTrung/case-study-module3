package com.codegym.mobilestore.service;

import java.util.List;

public interface ReadAllDAO<E> {
    List<E> findAll();

    List<E> findAllWithStoreProcedure();
}
