package com.codegym.mobilestore.service;

import java.util.List;

public interface GeneralDAO <E>{
   List<E> findAll();
   List<E> findAllWithStoreProcedure();
}
