package com.freshO2O.dao;

import java.util.List;

import com.freshO2O.po.Deduction;

public interface DeductionDAO {

	public abstract void save(Deduction transientInstance);

	public abstract void delete(Deduction persistentInstance);

	public abstract Deduction findById(java.lang.Integer id);

	public abstract List findByExample(Deduction instance);

	public abstract List findByProperty(String propertyName, Object value);

	public abstract List findAll();

	public abstract Deduction merge(Deduction detachedInstance);

	public abstract void attachDirty(Deduction instance);

	public abstract void attachClean(Deduction instance);

}