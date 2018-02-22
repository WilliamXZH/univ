package com.freshO2O.dao;

import java.util.List;

import com.freshO2O.po.CookBook;
import com.freshO2O.po.User;

public interface CookBookDAO {

	public abstract void save(CookBook transientInstance);

	public abstract void delete(CookBook persistentInstance);

	public abstract CookBook findById(java.lang.Integer id);

	public abstract List findByExample(CookBook instance);

	public abstract List findByProperty(String propertyName, Object value);

	public abstract List findAll();
	
	public abstract int update(CookBook instance);
	
	public abstract List findByPropertys( int start, int limit);

	public abstract List findByPropertys(String propertyName, Object value,
			int start, int limit);

	public abstract CookBook merge(CookBook detachedInstance);

	public abstract void attachDirty(CookBook instance);

	public abstract void attachClean(CookBook instance);

}