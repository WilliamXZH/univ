package com.freshO2O.dao;

// default package

import java.util.List;
import org.hibernate.LockMode;
import org.hibernate.Query;
import org.hibernate.criterion.Example;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.freshO2O.po.Goods;

/**
 * A data access object (DAO) providing persistence and search support for Goods
 * entities. Transaction control of the save(), update() and delete() operations
 * can directly support Spring container-managed transactions or they can be
 * augmented to handle user-managed Spring transactions. Each of these methods
 * provides additional information for how to configure it for the desired type
 * of transaction control.
 * 
 * @see .Goods
 * @author MyEclipse Persistence Tools
 */

public class GoodsDAOImpl extends HibernateDaoSupport implements GoodsDAO {
	private static final Logger log = LoggerFactory
			.getLogger(GoodsDAOImpl.class);

	public List findByPropertys(int start, int limit) {
		log.debug("finding Goods instance with property: ");
		try {
			String queryString = "from Goods as model ";
			Query queryObject = getSession().createQuery(queryString);
			;
			queryObject.setFirstResult(start);
			queryObject.setMaxResults(limit);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findByPropertys(String propertyName, Object value, int start,
			int limit) {
		log.debug("finding Goods instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Goods as model where model."
					+ propertyName + "= ?";
			Query queryObject = getSession().createQuery(queryString);
			queryObject.setParameter(0, value);
			queryObject.setFirstResult(start);
			queryObject.setMaxResults(limit);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.freshO2O.dao.GoodsDAO#save(com.freshO2O.po.Goods)
	 */
	public void save(Goods transientInstance) {
		log.debug("saving Goods instance");
		try {
			getSession().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.freshO2O.dao.GoodsDAO#delete(com.freshO2O.po.Goods)
	 */
	public void delete(Goods persistentInstance) {
		log.debug("deleting Goods instance");
		try {
			getSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.freshO2O.dao.GoodsDAO#findById(java.lang.Integer)
	 */
	public Goods findById(java.lang.Integer id) {
		log.debug("getting Goods instance with id: " + id);
		try {
			Goods instance = (Goods) getSession().get("com.freshO2O.po.Goods",
					id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.freshO2O.dao.GoodsDAO#findByExample(com.freshO2O.po.Goods)
	 */
	public List findByExample(Goods instance) {
		log.debug("finding Goods instance by example");
		try {
			List results = getSession().createCriteria("Goods").add(
					Example.create(instance)).list();
			log.debug("find by example successful, result size: "
					+ results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.freshO2O.dao.GoodsDAO#findByProperty(java.lang.String,
	 * java.lang.Object)
	 */
	public List findByProperty(String propertyName, Object value) {
		log.debug("finding Goods instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from com.freshO2O.po.Goods as model where model."
					+ propertyName + "= ?";
			Query queryObject = getSession().createQuery(queryString);
			queryObject.setParameter(0, value);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public int updateGoods(Goods goods) {
		
		try {

			getSession().update(goods);
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
		return 1;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.freshO2O.dao.GoodsDAO#findAll()
	 */
	public List findAll() {
		log.debug("finding all Goods instances");
		try {
			String queryString = "from Goods";
			Query queryObject = getSession().createQuery(queryString);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			re.printStackTrace();
			throw re;
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.freshO2O.dao.GoodsDAO#merge(com.freshO2O.po.Goods)
	 */
	public Goods merge(Goods detachedInstance) {
		log.debug("merging Goods instance");
		try {
			Goods result = (Goods) getSession().merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.freshO2O.dao.GoodsDAO#attachDirty(com.freshO2O.po.Goods)
	 */
	public void attachDirty(Goods instance) {
		log.debug("attaching dirty Goods instance");
		try {
			getSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.freshO2O.dao.GoodsDAO#attachClean(com.freshO2O.po.Goods)
	 */
	public void attachClean(Goods instance) {
		log.debug("attaching clean Goods instance");
		try {
			getSession().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}
}