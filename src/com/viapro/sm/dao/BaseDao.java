package com.viapro.sm.dao;

import java.io.Serializable;
import java.util.List;

public interface BaseDao<T> {

	// add object in database.
	boolean add(T t);

	// delete object by id.
	boolean deleteById(Serializable id);

	// update.
	boolean update(T t);

	// query.
	T getById(Serializable id);

	// more query.
	List<T> getPageList(String name, String attr, Integer start, Integer end);

}
