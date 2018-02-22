package com.freshO2O.dao;

import java.util.List;

import com.freshO2O.po.Goods;
import com.freshO2O.po.User;

public interface UserDAO {

	public abstract void save(User transientInstance);

	public abstract void delete(User persistentInstance);

	public abstract User findById(java.lang.Integer id);

	public abstract List findByExample(User instance);
	
	public abstract List findByPropertys( int start, int limit);

	public abstract List findByPropertys(String propertyName, Object value,
			int start, int limit);

	public abstract List findByProperty(String propertyName, Object value);

	public abstract List findAll();
	
	public abstract int update(User instance);

	public abstract User merge(User detachedInstance);

	public abstract void attachDirty(User instance);

	public abstract void attachClean(User instance);

}