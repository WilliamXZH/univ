package com.freshO2O.dao;

import java.util.List;

import com.freshO2O.po.Goods;
import com.freshO2O.po.Indent;

public interface IndentDAO {

	public abstract void save(Indent transientInstance);

	public abstract void delete(Indent persistentInstance);

	public abstract Indent findById(java.lang.Integer id);

	public abstract List findByExample(Indent instance);

	public abstract List findByProperty(String propertyName, Object value);
	
	public abstract List findByPropertys( int start, int limit);

	public abstract List findByPropertys(String propertyName, Object value,
			int start, int limit);

	public abstract List findAll();
	
	public abstract int update(Indent indent);

	public abstract Indent merge(Indent detachedInstance);

	public abstract void attachDirty(Indent instance);

	public abstract void attachClean(Indent instance);

}