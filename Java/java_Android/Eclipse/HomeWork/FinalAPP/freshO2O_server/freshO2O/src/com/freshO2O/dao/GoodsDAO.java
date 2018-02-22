package com.freshO2O.dao;

import java.util.List;

import com.freshO2O.po.Goods;

public interface GoodsDAO {

	public abstract void save(Goods transientInstance);

	public abstract void delete(Goods persistentInstance);

	public abstract Goods findById(java.lang.Integer id);

	public abstract List findByExample(Goods instance);

	public abstract List findByProperty(String propertyName, Object value);
	
	public abstract List findByPropertys( int start, int limit);

	public abstract List findByPropertys(String propertyName, Object value,
			int start, int limit);
	
	public abstract int updateGoods(Goods goods);

	public abstract List findAll();

	public abstract Goods merge(Goods detachedInstance);

	public abstract void attachDirty(Goods instance);

	public abstract void attachClean(Goods instance);

}