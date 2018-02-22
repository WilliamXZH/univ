package com.freshO2O.dao;

import java.util.List;

import com.freshO2O.po.Receiveaddr;

public interface ReceiveaddrDAO {

	public abstract void save(Receiveaddr transientInstance);

	public abstract void delete(Receiveaddr persistentInstance);

	public abstract Receiveaddr findById(java.lang.Integer id);

	public abstract List findByExample(Receiveaddr instance);

	public abstract List findByProperty(String propertyName, Object value);
	
	public abstract List findByPropertys( int start, int limit);
	
	public abstract int update(Receiveaddr instance);

	public abstract List findByPropertys(String propertyName, Object value,
			int start, int limit);

	public abstract List findAll();

	public abstract Receiveaddr merge(Receiveaddr detachedInstance);

	public abstract void attachDirty(Receiveaddr instance);

	public abstract void attachClean(Receiveaddr instance);

}