package com.freshO2O.dao;

import java.util.List;
import org.hibernate.LockMode;
import org.hibernate.Query;
import org.hibernate.criterion.Example;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.freshO2O.po.Area;

/**
 	* A data access object (DAO) providing persistence and search support for Area entities.
 			* Transaction control of the save(), update() and delete() operations 
		can directly support Spring container-managed transactions or they can be augmented	to handle user-managed Spring transactions. 
		Each of these methods provides additional information for how to configure it for the desired type of transaction control. 	
	 * @see com.freshO2O.po.Area
  * @author MyEclipse Persistence Tools 
 */

public class AreaDAOImpl extends HibernateDaoSupport implements AreaDAO  {
	     private static final Logger log = LoggerFactory.getLogger(AreaDAOImpl.class);
	
	     public List findByPropertys(int start, int limit) {
	 		log.debug("finding Area instance with property: ");
	 		try {
	 			String queryString = "from Area as model ";
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
	 	
	 	public List findByPropertys(String propertyName, Object value, int start, int limit) {
	         log.debug("finding Area instance with property: " + propertyName
	               + ", value: " + value);
	         try {
	 			String queryString = "from Area as model where model."
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
    
    /* (non-Javadoc)
	 * @see com.freshO2O.dao.AreaDAO#save(com.freshO2O.po.Area)
	 */
    public void save(Area transientInstance) {
        log.debug("saving Area instance");
        try {
            getSession().save(transientInstance);
            log.debug("save successful");
        } catch (RuntimeException re) {
            log.error("save failed", re);
            throw re;
        }
    }
    
	/* (non-Javadoc)
	 * @see com.freshO2O.dao.AreaDAO#delete(com.freshO2O.po.Area)
	 */
	public void delete(Area persistentInstance) {
        log.debug("deleting Area instance");
        try {
            getSession().delete(persistentInstance);
            log.debug("delete successful");
        } catch (RuntimeException re) {
            log.error("delete failed", re);
            throw re;
        }
    }
    
    /* (non-Javadoc)
	 * @see com.freshO2O.dao.AreaDAO#findById(java.lang.Integer)
	 */
    public Area findById( java.lang.Integer id) {
        log.debug("getting Area instance with id: " + id);
        try {
            Area instance = (Area) getSession()
                    .get("com.freshO2O.po.Area", id);
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
    
    
    /* (non-Javadoc)
	 * @see com.freshO2O.dao.AreaDAO#findByExample(com.freshO2O.po.Area)
	 */
    public List findByExample(Area instance) {
        log.debug("finding Area instance by example");
        try {
            List results = getSession()
                    .createCriteria("com.freshO2O.po.Area")
                    .add(Example.create(instance))
            .list();
            log.debug("find by example successful, result size: " + results.size());
            return results;
        } catch (RuntimeException re) {
            log.error("find by example failed", re);
            throw re;
        }
    }    
    
    /* (non-Javadoc)
	 * @see com.freshO2O.dao.AreaDAO#findByProperty(java.lang.String, java.lang.Object)
	 */
    public List findByProperty(String propertyName, Object value) {
      log.debug("finding Area instance with property: " + propertyName
            + ", value: " + value);
      try {
         String queryString = "from Area as model where model." 
         						+ propertyName + "= ?";
         Query queryObject = getSession().createQuery(queryString);
		 queryObject.setParameter(0, value);
		 return queryObject.list();
      } catch (RuntimeException re) {
         log.error("find by property name failed", re);
         throw re;
      }
	}


	/* (non-Javadoc)
	 * @see com.freshO2O.dao.AreaDAO#findAll()
	 */
	public List findAll() {
		log.debug("finding all Area instances");
		try {
			String queryString = "from Area";
	         Query queryObject = getSession().createQuery(queryString);
			 return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}
	
    /* (non-Javadoc)
	 * @see com.freshO2O.dao.AreaDAO#merge(com.freshO2O.po.Area)
	 */
    public Area merge(Area detachedInstance) {
        log.debug("merging Area instance");
        try {
            Area result = (Area) getSession()
                    .merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    /* (non-Javadoc)
	 * @see com.freshO2O.dao.AreaDAO#attachDirty(com.freshO2O.po.Area)
	 */
    public void attachDirty(Area instance) {
        log.debug("attaching dirty Area instance");
        try {
            getSession().saveOrUpdate(instance);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }
    
    /* (non-Javadoc)
	 * @see com.freshO2O.dao.AreaDAO#attachClean(com.freshO2O.po.Area)
	 */
    public void attachClean(Area instance) {
        log.debug("attaching clean Area instance");
        try {
            getSession().lock(instance, LockMode.NONE);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }
}