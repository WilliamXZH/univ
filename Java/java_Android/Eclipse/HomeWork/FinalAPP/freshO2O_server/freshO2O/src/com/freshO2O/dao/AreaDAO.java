package com.freshO2O.dao;

import java.util.List;

import com.freshO2O.po.Area;

public interface AreaDAO {

	public abstract void save(Area transientInstance);

	public abstract void delete(Area persistentInstance);

	public abstract Area findById(java.lang.Integer id);

	public abstract List findByExample(Area instance);
	
	public abstract List findByPropertys( int start, int limit);

	public abstract List findByPropertys(String propertyName, Object value,
			int start, int limit);

	public abstract List findByProperty(String propertyName, Object value);

	public abstract List findAll();

	public abstract Area merge(Area detachedInstance);

	public abstract void attachDirty(Area instance);

	public abstract void attachClean(Area instance);

}