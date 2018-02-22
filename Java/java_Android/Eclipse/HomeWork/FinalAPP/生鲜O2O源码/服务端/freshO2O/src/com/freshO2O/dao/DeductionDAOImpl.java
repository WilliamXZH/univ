package com.freshO2O.dao;

import java.util.List;
import org.hibernate.LockMode;
import org.hibernate.Query;
import org.hibernate.criterion.Example;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.freshO2O.po.Deduction;

/**
 	* A data access object (DAO) providing persistence and search support for Deduction entities.
 			* Transaction control of the save(), update() and delete() operations 
		can directly support Spring container-managed transactions or they can be augmented	to handle user-managed Spring transactions. 
		Each of these methods provides additional information for how to configure it for the desired type of transaction control. 	
	 * @see com.freshO2O.po.Deduction
  * @author MyEclipse Persistence Tools 
 */

public class DeductionDAOImpl extends HibernateDaoSupport implements DeductionDAO  {
	     private static final Logger log = LoggerFactory.getLogger(DeductionDAOImpl.class);
	

    
    /* (non-Javadoc)
	 * @see com.freshO2O.dao.DeductionDAO#save(com.freshO2O.po.Deduction)
	 */
    public void save(Deduction transientInstance) {
        log.debug("saving Deduction instance");
        try {
            getSession().save(transientInstance);
            log.debug("save successful");
        } catch (RuntimeException re) {
            log.error("save failed", re);
            throw re;
        }
    }
    
	/* (non-Javadoc)
	 * @see com.freshO2O.dao.DeductionDAO#delete(com.freshO2O.po.Deduction)
	 */
	public void delete(Deduction persistentInstance) {
        log.debug("deleting Deduction instance");
        try {
            getSession().delete(persistentInstance);
            log.debug("delete successful");
        } catch (RuntimeException re) {
            log.error("delete failed", re);
            throw re;
        }
    }
    
    /* (non-Javadoc)
	 * @see com.freshO2O.dao.DeductionDAO#findById(java.lang.Integer)
	 */
    public Deduction findById( java.lang.Integer id) {
        log.debug("getting Deduction instance with id: " + id);
        try {
            Deduction instance = (Deduction) getSession()
                    .get("com.freshO2O.po.Deduction", id);
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
    
    
    /* (non-Javadoc)
	 * @see com.freshO2O.dao.DeductionDAO#findByExample(com.freshO2O.po.Deduction)
	 */
    public List findByExample(Deduction instance) {
        log.debug("finding Deduction instance by example");
        try {
            List results = getSession()
                    .createCriteria("com.freshO2O.po.Deduction")
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
	 * @see com.freshO2O.dao.DeductionDAO#findByProperty(java.lang.String, java.lang.Object)
	 */
    public List findByProperty(String propertyName, Object value) {
      log.debug("finding Deduction instance with property: " + propertyName
            + ", value: " + value);
      try {
         String queryString = "from Deduction as model where model." 
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
	 * @see com.freshO2O.dao.DeductionDAO#findAll()
	 */
	public List findAll() {
		log.debug("finding all Deduction instances");
		try {
			String queryString = "from Deduction";
	         Query queryObject = getSession().createQuery(queryString);
			 return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}
	
    /* (non-Javadoc)
	 * @see com.freshO2O.dao.DeductionDAO#merge(com.freshO2O.po.Deduction)
	 */
    public Deduction merge(Deduction detachedInstance) {
        log.debug("merging Deduction instance");
        try {
            Deduction result = (Deduction) getSession()
                    .merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    /* (non-Javadoc)
	 * @see com.freshO2O.dao.DeductionDAO#attachDirty(com.freshO2O.po.Deduction)
	 */
    public void attachDirty(Deduction instance) {
        log.debug("attaching dirty Deduction instance");
        try {
            getSession().saveOrUpdate(instance);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }
    
    /* (non-Javadoc)
	 * @see com.freshO2O.dao.DeductionDAO#attachClean(com.freshO2O.po.Deduction)
	 */
    public void attachClean(Deduction instance) {
        log.debug("attaching clean Deduction instance");
        try {
            getSession().lock(instance, LockMode.NONE);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }
}