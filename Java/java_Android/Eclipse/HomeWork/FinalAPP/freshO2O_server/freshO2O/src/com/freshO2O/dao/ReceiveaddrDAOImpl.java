package com.freshO2O.dao;

import java.util.List;
import org.hibernate.LockMode;
import org.hibernate.Query;
import org.hibernate.criterion.Example;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.freshO2O.po.Receiveaddr;
import com.freshO2O.po.User;

/**
 	* A data access object (DAO) providing persistence and search support for Receiveaddr entities.
 			* Transaction control of the save(), update() and delete() operations 
		can directly support Spring container-managed transactions or they can be augmented	to handle user-managed Spring transactions. 
		Each of these methods provides additional information for how to configure it for the desired type of transaction control. 	
	 * @see com.freshO2O.po.Receiveaddr
  * @author MyEclipse Persistence Tools 
 */

public class ReceiveaddrDAOImpl extends HibernateDaoSupport implements ReceiveaddrDAO  {
	     private static final Logger log = LoggerFactory.getLogger(ReceiveaddrDAOImpl.class);
	
	     public int update(Receiveaddr addr) {
	 		
	 		try {

	 			getSession().update(addr);
	 		} catch (RuntimeException re) {
	 			log.error("find by property name failed", re);
	 			throw re;
	 		}
	 		return 1;
	 	}
	     
	     public List findByPropertys(int start, int limit) {
	 		log.debug("finding Receiveaddr instance with property: ");
	 		try {
	 			String queryString = "from Receiveaddr as model ";
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
	         log.debug("finding Receiveaddr instance with property: " + propertyName
	               + ", value: " + value);
	         try {
	 			String queryString = "from Receiveaddr as model where model."
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
	 * @see com.freshO2O.dao.ReceiveaddrDAO#save(com.freshO2O.po.Receiveaddr)
	 */
    public void save(Receiveaddr transientInstance) {
        log.debug("saving Receiveaddr instance");
        try {
            getSession().save(transientInstance);
            log.debug("save successful");
        } catch (RuntimeException re) {
            log.error("save failed", re);
            throw re;
        }
    }
    
	/* (non-Javadoc)
	 * @see com.freshO2O.dao.ReceiveaddrDAO#delete(com.freshO2O.po.Receiveaddr)
	 */
	public void delete(Receiveaddr persistentInstance) {
        log.debug("deleting Receiveaddr instance");
        try {
            getSession().delete(persistentInstance);
            log.debug("delete successful");
        } catch (RuntimeException re) {
            log.error("delete failed", re);
            throw re;
        }
    }
    
    /* (non-Javadoc)
	 * @see com.freshO2O.dao.ReceiveaddrDAO#findById(java.lang.Integer)
	 */
    public Receiveaddr findById( java.lang.Integer id) {
        log.debug("getting Receiveaddr instance with id: " + id);
        try {
            Receiveaddr instance = (Receiveaddr) getSession()
                    .get("com.freshO2O.po.Receiveaddr", id);
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
    
    
    /* (non-Javadoc)
	 * @see com.freshO2O.dao.ReceiveaddrDAO#findByExample(com.freshO2O.po.Receiveaddr)
	 */
    public List findByExample(Receiveaddr instance) {
        log.debug("finding Receiveaddr instance by example");
        try {
            List results = getSession()
                    .createCriteria("com.freshO2O.po.Receiveaddr")
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
	 * @see com.freshO2O.dao.ReceiveaddrDAO#findByProperty(java.lang.String, java.lang.Object)
	 */
    public List findByProperty(String propertyName, Object value) {
      log.debug("finding Receiveaddr instance with property: " + propertyName
            + ", value: " + value);
      try {
         String queryString = "from Receiveaddr as model where model." 
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
	 * @see com.freshO2O.dao.ReceiveaddrDAO#findAll()
	 */
	public List findAll() {
		log.debug("finding all Receiveaddr instances");
		try {
			String queryString = "from Receiveaddr";
	         Query queryObject = getSession().createQuery(queryString);
			 return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}
	
    /* (non-Javadoc)
	 * @see com.freshO2O.dao.ReceiveaddrDAO#merge(com.freshO2O.po.Receiveaddr)
	 */
    public Receiveaddr merge(Receiveaddr detachedInstance) {
        log.debug("merging Receiveaddr instance");
        try {
            Receiveaddr result = (Receiveaddr) getSession()
                    .merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    /* (non-Javadoc)
	 * @see com.freshO2O.dao.ReceiveaddrDAO#attachDirty(com.freshO2O.po.Receiveaddr)
	 */
    public void attachDirty(Receiveaddr instance) {
        log.debug("attaching dirty Receiveaddr instance");
        try {
            getSession().saveOrUpdate(instance);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }
    
    /* (non-Javadoc)
	 * @see com.freshO2O.dao.ReceiveaddrDAO#attachClean(com.freshO2O.po.Receiveaddr)
	 */
    public void attachClean(Receiveaddr instance) {
        log.debug("attaching clean Receiveaddr instance");
        try {
            getSession().lock(instance, LockMode.NONE);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }
}