package com.freshO2O.dao;

import java.util.List;
import org.hibernate.LockMode;
import org.hibernate.Query;
import org.hibernate.criterion.Example;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.freshO2O.po.Goods;
import com.freshO2O.po.Indent;

/**
 	* A data access object (DAO) providing persistence and search support for Indent entities.
 			* Transaction control of the save(), update() and delete() operations 
		can directly support Spring container-managed transactions or they can be augmented	to handle user-managed Spring transactions. 
		Each of these methods provides additional information for how to configure it for the desired type of transaction control. 	
	 * @see com.freshO2O.po.Indent
  * @author MyEclipse Persistence Tools 
 */

public class IndentDAOImpl extends HibernateDaoSupport implements IndentDAO  {
	     private static final Logger log = LoggerFactory.getLogger(IndentDAOImpl.class);
	

	     
	     public int update(Indent indent) {
	 		
	 		try {

	 			getSession().update(indent);
	 		} catch (RuntimeException re) {
	 			log.error("find by property name failed", re);
	 			throw re;
	 		}
	 		return 1;
	 	}
    
    /* (non-Javadoc)
	 * @see com.freshO2O.dao.IndentDAO#save(com.freshO2O.po.Indent)
	 */
    public void save(Indent transientInstance) {
        log.debug("saving Indent instance");
        try {
            getSession().save(transientInstance);
            log.debug("save successful");
        } catch (RuntimeException re) {
            log.error("save failed", re);
            throw re;
        }
    }
    
	/* (non-Javadoc)
	 * @see com.freshO2O.dao.IndentDAO#delete(com.freshO2O.po.Indent)
	 */
	public void delete(Indent persistentInstance) {
        log.debug("deleting Indent instance");
        try {
            getSession().delete(persistentInstance);
            log.debug("delete successful");
        } catch (RuntimeException re) {
            log.error("delete failed", re);
            throw re;
        }
    }
	
	public List findByPropertys(int start, int limit) {
		log.debug("finding Indent instance with property: ");
		try {
			String queryString = "from Indent as model order by OTime desc";
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
        log.debug("finding Indent instance with property: " + propertyName
              + ", value: " + value);
        try {
			String queryString = "from Indent as model where model."
					+ propertyName + "= ?  order by OTime desc";
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
	 * @see com.freshO2O.dao.IndentDAO#findById(java.lang.Integer)
	 */
    public Indent findById( java.lang.Integer id) {
        log.debug("getting Indent instance with id: " + id);
        try {
            Indent instance = (Indent) getSession()
                    .get("com.freshO2O.po.Indent", id);
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
    
    
    /* (non-Javadoc)
	 * @see com.freshO2O.dao.IndentDAO#findByExample(com.freshO2O.po.Indent)
	 */
    public List findByExample(Indent instance) {
        log.debug("finding Indent instance by example");
        try {
            List results = getSession()
                    .createCriteria("com.freshO2O.po.Indent")
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
	 * @see com.freshO2O.dao.IndentDAO#findByProperty(java.lang.String, java.lang.Object)
	 */
    public List findByProperty(String propertyName, Object value) {
      log.debug("finding Indent instance with property: " + propertyName
            + ", value: " + value);
      try {
         String queryString = "from Indent as model where model." 
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
	 * @see com.freshO2O.dao.IndentDAO#findAll()
	 */
	public List findAll() {
		log.debug("finding all Indent instances");
		try {
			String queryString = "from Indent";
	         Query queryObject = getSession().createQuery(queryString);
			 return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}
	
    /* (non-Javadoc)
	 * @see com.freshO2O.dao.IndentDAO#merge(com.freshO2O.po.Indent)
	 */
    public Indent merge(Indent detachedInstance) {
        log.debug("merging Indent instance");
        try {
            Indent result = (Indent) getSession()
                    .merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    /* (non-Javadoc)
	 * @see com.freshO2O.dao.IndentDAO#attachDirty(com.freshO2O.po.Indent)
	 */
    public void attachDirty(Indent instance) {
        log.debug("attaching dirty Indent instance");
        try {
            getSession().saveOrUpdate(instance);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }
    
    /* (non-Javadoc)
	 * @see com.freshO2O.dao.IndentDAO#attachClean(com.freshO2O.po.Indent)
	 */
    public void attachClean(Indent instance) {
        log.debug("attaching clean Indent instance");
        try {
            getSession().lock(instance, LockMode.NONE);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }
}