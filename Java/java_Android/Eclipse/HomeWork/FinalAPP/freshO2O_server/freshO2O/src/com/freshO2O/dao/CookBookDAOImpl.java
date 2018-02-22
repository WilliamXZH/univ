package com.freshO2O.dao;

import java.util.List;
import org.hibernate.LockMode;
import org.hibernate.Query;
import org.hibernate.criterion.Example;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.freshO2O.po.CookBook;
import com.freshO2O.po.User;

/**
 	* A data access object (DAO) providing persistence and search support for CookBook entities.
 			* Transaction control of the save(), update() and delete() operations 
		can directly support Spring container-managed transactions or they can be augmented	to handle user-managed Spring transactions. 
		Each of these methods provides additional information for how to configure it for the desired type of transaction control. 	
	 * @see com.freshO2O.po.CookBook
  * @author MyEclipse Persistence Tools 
 */

public class CookBookDAOImpl extends HibernateDaoSupport implements CookBookDAO  {
	     private static final Logger log = LoggerFactory.getLogger(CookBookDAOImpl.class);
	
	     public int update(CookBook c) {
	 		
	 		try {

	 			getSession().update(c);
	 		} catch (RuntimeException re) {
	 			log.error("find by property name failed", re);
	 			throw re;
	 		}
	 		return 1;
	 	}
	     
	     public List findByPropertys(int start, int limit) {
	 		log.debug("finding CookBook instance with property: ");
	 		try {
	 			String queryString = "from CookBook as model ";
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
	         log.debug("finding CookBook instance with property: " + propertyName
	               + ", value: " + value);
	         try {
	 			String queryString = "from CookBook as model where model."
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
	 * @see com.freshO2O.dao.CookBookDAO#save(com.freshO2O.po.CookBook)
	 */
    public void save(CookBook transientInstance) {
        log.debug("saving CookBook instance");
        try {
            getSession().save(transientInstance);
            log.debug("save successful");
        } catch (RuntimeException re) {
            log.error("save failed", re);
            throw re;
        }
    }
    
	/* (non-Javadoc)
	 * @see com.freshO2O.dao.CookBookDAO#delete(com.freshO2O.po.CookBook)
	 */
	public void delete(CookBook persistentInstance) {
        log.debug("deleting CookBook instance");
        try {
            getSession().delete(persistentInstance);
            log.debug("delete successful");
        } catch (RuntimeException re) {
            log.error("delete failed", re);
            throw re;
        }
    }
    
    /* (non-Javadoc)
	 * @see com.freshO2O.dao.CookBookDAO#findById(java.lang.Integer)
	 */
    public CookBook findById( java.lang.Integer id) {
        log.debug("getting CookBook instance with id: " + id);
        try {
            CookBook instance = (CookBook) getSession()
                    .get("com.freshO2O.po.CookBook", id);
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            re.printStackTrace();
            throw re;
        }
    }
    
    
    /* (non-Javadoc)
	 * @see com.freshO2O.dao.CookBookDAO#findByExample(com.freshO2O.po.CookBook)
	 */
    public List findByExample(CookBook instance) {
        log.debug("finding CookBook instance by example");
        try {
            List results = getSession()
                    .createCriteria("com.freshO2O.po.CookBook")
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
	 * @see com.freshO2O.dao.CookBookDAO#findByProperty(java.lang.String, java.lang.Object)
	 */
    public List findByProperty(String propertyName, Object value) {
      log.debug("finding CookBook instance with property: " + propertyName
            + ", value: " + value);
      try {
         String queryString = "from CookBook as model where model." 
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
	 * @see com.freshO2O.dao.CookBookDAO#findAll()
	 */
	public List findAll() {
		log.debug("finding all CookBook instances");
		try {
			String queryString = "from CookBook";
	         Query queryObject = getSession().createQuery(queryString);
			 return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}
	
    /* (non-Javadoc)
	 * @see com.freshO2O.dao.CookBookDAO#merge(com.freshO2O.po.CookBook)
	 */
    public CookBook merge(CookBook detachedInstance) {
        log.debug("merging CookBook instance");
        try {
            CookBook result = (CookBook) getSession()
                    .merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    /* (non-Javadoc)
	 * @see com.freshO2O.dao.CookBookDAO#attachDirty(com.freshO2O.po.CookBook)
	 */
    public void attachDirty(CookBook instance) {
        log.debug("attaching dirty CookBook instance");
        try {
            getSession().saveOrUpdate(instance);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }
    
    /* (non-Javadoc)
	 * @see com.freshO2O.dao.CookBookDAO#attachClean(com.freshO2O.po.CookBook)
	 */
    public void attachClean(CookBook instance) {
        log.debug("attaching clean CookBook instance");
        try {
            getSession().lock(instance, LockMode.NONE);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }
}