package com.ahmadiallo.CMS.repository;

import java.util.Collection;

import com.ahmadiallo.CMS.model.User;

public interface UserRepository <T extends User>{
/* Basic CRUD Operations */
    T creat(T data);
    Collection<T> list(int page, int pageSize);
    T get(Long id);
    T update(T data);
    Boolean delete(Long id);

    /*More complex operations */
}
