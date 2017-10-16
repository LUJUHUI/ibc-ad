package com.wondertek.mobilevideo.bc.core.dao.impl;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.HibernateException;
import org.hibernate.IdentifierLoadAccess;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.orm.ObjectRetrievalFailureException;

import com.wondertek.mobilevideo.bc.core.dao.GenericDao;
import com.wondertek.mobilevideo.bc.core.utils.PageList;

/**
 * This class serves as the Base class for all other DAOs - namely to hold
 * common CRUD methods that they might all use. You should only need to extend
 * this class when your require custom CRUD logic.
 * <p/>
 * <p>To register this class in your Spring context file, use the following XML.
 * <pre>
 *      &lt;bean id="fooDao" class="com.yourcompany.dao.hibernate.GenericDaoHibernate"&gt;
 *          &lt;constructor-arg value="com.yourcompany.model.Foo"/&gt;
 *      &lt;/bean&gt;
 * </pre>
 *
 * @param <T>  a type variable
 * @param <PK> the primary key for that type
 * @author <a href="mailto:bwnoll@gmail.com">Bryan Noll</a>
 *         Updated by jgarcia: update hibernate3 to hibernate4
 * @author jgarcia (update: added full text search + reindexing)
 */
public class GenericDaoHibernate<T, PK extends Serializable> implements GenericDao<T, PK> {
    /**
     * Log variable for all child classes. Uses LogFactory.getLog(getClass()) from Commons Logging
     */
    protected final Log log = LogFactory.getLog(getClass());
    private Class<T> persistentClass;
    
    private SessionFactory sessionFactory;


	/**
     * Constructor that takes in a class to see which type of entity to persist.
     * Use this constructor when subclassing.
     *
     * @param persistentClass the class type you'd like to persist
     */
    public GenericDaoHibernate(final Class<T> persistentClass) {
        this.persistentClass = persistentClass;
    }

    /**
     * Constructor that takes in a class and sessionFactory for easy creation of DAO.
     *
     * @param persistentClass the class type you'd like to persist
     * @param sessionFactory  the pre-configured Hibernate SessionFactory
     */
    public GenericDaoHibernate(final Class<T> persistentClass, SessionFactory sessionFactory) {
        this.persistentClass = persistentClass;
        this.sessionFactory = sessionFactory;
    }

    public SessionFactory getSessionFactory() {
        return this.sessionFactory;
    }

    public Session getSession() throws HibernateException {
        Session sess = getSessionFactory().getCurrentSession();
        if (sess == null) {
            sess = getSessionFactory().openSession();
        }
        return sess;
    }

    @Autowired
    @Required
    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

	/**
     * {@inheritDoc}
     */
    @SuppressWarnings("unchecked")
    public List<T> getAll() {
        Session sess = getSession();
        return sess.createCriteria(persistentClass).list();
    }
    
    
    @SuppressWarnings("unchecked")
    public List<T> getAll(Map<String, Object> conditions,String order,String sort) {
	    StringBuffer queryBuf=new StringBuffer(" from  "+persistentClass.getName()+" where 1=1 ");
	    Session sess = getSession();
		List<Object> params=new ArrayList<Object>();
		if(conditions!=null){
			setQueryParam(conditions, queryBuf, params);
		}
		
		if(StringUtils.isNotBlank(order) && StringUtils.isNotBlank(sort) ){
			queryBuf.append(" order by "+ sort  +"  "+ order);
		}
		Query query = sess.createQuery(queryBuf.toString());
		if (params != null) {
			for (int i = 0; i < params.size(); i++) {
				query.setParameter(i,params.get(i));
			}
		}
	
        return query.list();
    }


    /**
     * {@inheritDoc}
     */
    @SuppressWarnings("unchecked")
    public List<T> getAllDistinct() {
        Collection<T> result = new LinkedHashSet<T>(getAll());
        return new ArrayList<T>(result);
    }

   
    /**
     * {@inheritDoc}
     */
    @SuppressWarnings("unchecked")
    public T get(PK id) {
        Session sess = getSession();
        IdentifierLoadAccess byId = sess.byId(persistentClass);
        T entity = (T) byId.load(id);

        if (entity == null) {
            log.warn("Uh oh, '" + this.persistentClass + "' object with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(this.persistentClass, id);
        }

        return entity;
    }
    

    /**
     * {@inheritDoc}
     */
    @SuppressWarnings("unchecked")
    public boolean exists(PK id) {
        Session sess = getSession();
        IdentifierLoadAccess byId = sess.byId(persistentClass);
        T entity = (T) byId.load(id);
        return entity != null;
    }

    /**
     * {@inheritDoc}
     */
    @SuppressWarnings("unchecked")
    public T save(T object) {
        Session sess = getSession();
        return (T) sess.merge(object);
    }

    /**
     * {@inheritDoc}
     */
    public void remove(T object) {
        Session sess = getSession();
        sess.delete(object);
    }

    /**
     * {@inheritDoc}
     */
    public void remove(PK id) {
        Session sess = getSession();
        IdentifierLoadAccess byId = sess.byId(persistentClass);
        T entity = (T) byId.load(id);
        sess.delete(entity);
    }
    
    
    public int removeAll(List<PK> ids) {
        Session sess = getSession();
        Query query = sess.createQuery(" delete from "+persistentClass.getName()+" where id in (:ids) ");
        query.setParameterList("ids", ids);
        return  query.executeUpdate();
    }

    public List<T> finalAll(List<PK> ids) {
        Session sess = getSession();
        Query query = sess.createQuery("  from "+persistentClass.getName()+" where id in (:ids) ");
        query.setParameterList("ids", ids);
        return  query.list();
    }
    /**
     * {@inheritDoc}
     */
    @SuppressWarnings("unchecked")
    public List<T> findByNamedQuery(String queryName, Map<String, Object> queryParams) {
        Session sess = getSession();
        Query namedQuery = sess.getNamedQuery(queryName);
        for (String s : queryParams.keySet()) {
            Object val = queryParams.get(s);
            if (val instanceof Collection) {
                namedQuery.setParameterList(s, (Collection) val);
            } else {
                namedQuery.setParameter(s, val);
            }
        }
        return namedQuery.list();
    }
    
    @SuppressWarnings("unchecked")
    public T getObject(Map<String, Object> conditions){
    	StringBuffer queryBuf=new StringBuffer(" from  "+persistentClass.getName()+" where 1=1 ");
		List<Object> params=new ArrayList<Object>();
		setQueryParam(conditions, queryBuf, params);
	    Session sess = getSession();
		Query query = sess.createQuery(queryBuf.toString());
		if (params != null) {
			for (int i = 0; i < params.size(); i++) {
				query.setParameter(i, params.get(i));
			}
		}
		List<T> list=query.list();
		if(list!=null && list.size()>0){
			return list.get(0);
		}
		return null;
    }
    
	public PageList getPageList(Map<String, Object> conditions, int pageNo, int pageSize, String order, String sort){
		
		StringBuffer queryBuf=new StringBuffer(" from  "+persistentClass.getName()+" where 1=1 ");
		List<Object> params=new ArrayList<Object>();
		setQueryParam(conditions, queryBuf, params);
		log.info("=="+params.toArray());
		Integer recordCount = findCount(" select count(1) "+queryBuf, params.toArray());
		PageList pageList = new PageList();
		
		if(recordCount==null || recordCount<1){
			return pageList;
		}
		pageList.setPageIndex(pageNo);
		pageList.setRecordCount(recordCount);
		pageList.setPageSize(pageSize);
		pageList.initialize();

		if(StringUtils.isNotBlank(order) && StringUtils.isNotBlank(sort) ){
			queryBuf.append(" order by "+ sort +"  "+ order);
		}else{
			queryBuf.append(" order by id desc ");
		}
		List<T>  list= find(queryBuf.toString(), params.toArray(), (pageList.getPageIndex() - 1) * pageSize, pageSize);
	    pageList.setList(list);
	    return pageList;
	}
	
	public long findCount(Map<String, Object> conditions){
		StringBuffer queryBuf=new StringBuffer(" select count(1) from  "+persistentClass.getName()+" where 1=1 ");
		List<Object> params=new ArrayList<Object>();
		setQueryParam(conditions, queryBuf, params);
	    return findCount(queryBuf.toString(), params.toArray());
	}
	
	 public List<T> find(Map<String, Object> conditions){
		    StringBuffer queryBuf=new StringBuffer(" from  "+persistentClass.getName()+" where 1=1 ");
		    Session sess = getSession();
			List<Object> params=new ArrayList<Object>();
			setQueryParam(conditions, queryBuf, params);
			Query query = sess.createQuery(queryBuf.toString());
			if (params != null) {
				for (int i = 0; i < params.size(); i++) {
					query.setParameter(i,params.get(i));
				}
			}
	        return query.list();
	 }
	
	 public List<T> find(Map<String, Object> conditions, int start, int limit,String order,String sort){
		    StringBuffer queryBuf=new StringBuffer(" from  "+persistentClass.getName()+" where 1=1 ");
		    Session sess = getSession();
			List<Object> params=new ArrayList<Object>();
			setQueryParam(conditions, queryBuf, params);
			if(StringUtils.isNotBlank(order) && StringUtils.isNotBlank(sort) ){
				queryBuf.append(" order by "+ sort +"  "+ order);
			}
			Query query = sess.createQuery(queryBuf.toString());
			if (params != null) {
				for (int i = 0; i < params.size(); i++) {
					query.setParameter(i,params.get(i));
				}
			}
			query.setFirstResult(start);
			query.setMaxResults(limit);
	        return query.list();
	 }
	 
    public List<T> find(String queryString, Object[] params,String order,String sort) {
		StringBuffer queryBuf=new StringBuffer(queryString);
		if(StringUtils.isNotBlank(order) && StringUtils.isNotBlank(sort) ){
			queryBuf.append(" order by "+ sort +"  "+ order);
		}
		Session sess = getSession();
		Query query = sess.createQuery(queryBuf.toString());
		if (params != null) {
			for (int i = 0; i < params.length; i++) {
				query.setParameter(i, params[i]);
			}
		}
        return query.list();
    }
		 
	
    public List<T> find(String queryString, Object[] params, int start, int limit,String order,String sort) {
		StringBuffer queryBuf=new StringBuffer(queryString);
		if(StringUtils.isNotBlank(order) && StringUtils.isNotBlank(sort) ){
			queryBuf.append(" order by "+ sort +"  "+ order);
		}
		Session sess = getSession();
		Query query = sess.createQuery(queryBuf.toString());
		if (params != null) {
			for (int i = 0; i < params.length; i++) {
				query.setParameter(i, params[i]);
			}
		}
		query.setFirstResult(start);
		query.setMaxResults(limit);
        return query.list();
    }
	 
	
    /**
     * {@inheritDoc}
     */
    @SuppressWarnings("unchecked")
	public List<T> find(String queryString, Object[] params, int start, int limit) {
        Session sess = getSession();
		Query query = sess.createQuery(queryString);
		if (params != null) {
			for (int i = 0; i < params.length; i++) {
				query.setParameter(i, params[i]);
			}
		}
		query.setFirstResult(start);
		query.setMaxResults(limit);
        return query.list();
    }
    
    protected Integer findCount(String queryString, Object[] params) {
        Session sess = getSession();
		Query query = sess.createQuery(queryString);
		if (params != null) {
			for (int i = 0; i < params.length; i++) {
				query.setParameter(i, params[i]);
			}
		}
        return Integer.valueOf(query.uniqueResult().toString());
    }
    
    
    protected Integer findSQLCount(String queryString, Object[] params) {
        Session sess = getSession();
		Query query = sess.createSQLQuery(queryString.toUpperCase());
		if (params != null) {
			for (int i = 0; i < params.length; i++) {
				query.setParameter(i, params[i]);
			}
		}
        return Integer.valueOf(query.uniqueResult().toString());
    }
    

    
    
    @SuppressWarnings("unchecked")
    public List<Object[]> findSQL(String queryString,Object[] params, int start, int limit) {
        Session sess = getSession();
    	Query query=sess.createSQLQuery(queryString.toUpperCase());
		query.setFirstResult(start);
		query.setMaxResults(limit);
		if (params != null) {
			for (int i = 0; i < params.length; i++) {
				query.setParameter(i, params[i]);
			}
		}
        return query.list();
    }
    
    @SuppressWarnings("unchecked")
    public List<Object[]> findSQL(String queryString,Object[] params) {
        Session sess = getSession();
    	Query query=sess.createSQLQuery(queryString.toUpperCase());
		if (params != null) {
			for (int i = 0; i < params.length; i++) {
				query.setParameter(i, params[i]);
			}
		}
        return query.list();
    }
    
	protected void setQueryParam(Map<String, Object> conditions, StringBuffer whereString, List<Object> params) {
		if (conditions == null) {
			return;
		}
		Boolean isExist=false;
		if(conditions.containsKey("isExist")){
			isExist=true;
			conditions.remove("isExist");
		}
		
		Set<Map.Entry<String, Object>> conditionSet = conditions.entrySet();
		for (Map.Entry<String, Object> condition : conditionSet) {
			String paramName = condition.getKey();
			Object paramValue = condition.getValue();
			if (paramName!=null && StringUtils.isNotBlank(paramName) && paramValue != null) {
				if (paramValue instanceof String && isExist) {
					String value = paramValue.toString().trim();
					if (StringUtils.isNotBlank((String) paramValue)) {
						whereString.append(" and " + paramName + " = ? ");
						params.add(value);
					}
				}else if (paramValue instanceof String) {
					String value = paramValue.toString().trim();
					if (StringUtils.isNotBlank((String) paramValue)) {
						whereString.append(" and " + paramName + " like ? ");
						params.add("%" + value + "%");
					}
				} else if (paramValue instanceof Date) {
					if (paramName.endsWith("_beginTime")) {
						whereString.append(" and " + paramName.replaceAll("_beginTime", "") + " >= ?");
						params.add(paramValue);
					} else if (paramName.endsWith("_endTime")) {
						whereString.append(" and " + paramName.replaceAll("_endTime", "") + " <= ?");
						params.add(paramValue);
					} else {
						whereString.append(" and " + paramName + " = ?");
						params.add(paramValue);
					}
				}else {
					whereString.append(" and " + paramName + " = ?");
					params.add(paramValue);
				}
			}
		}
	}
	
	
	public List<T> saveBatch(Collection<T> objs,int commitInCount){
	    try {
	    	List<T> models=new ArrayList<T>();
	    	synchronized (this) {
				Session session = getSession();
				int i=0;
				for (T model : objs) {
					model = save(model);
					if (i % commitInCount == 0) {
						session.flush();
						session.clear();
					}
					i++;
					models.add(model);
				}
				session.flush();
				session.clear();
			}
			return models;
		} catch (Exception e) {
			e.printStackTrace();
		}
	    return null;
	}

	public int remove(Map<String, Object> conditions) {
		StringBuffer queryBuf=new StringBuffer(" delete from "+persistentClass.getName()+" where 1=1 ");
        Session sess = getSession();
		List<Object> params=new ArrayList<Object>();
        setQueryParam(conditions, queryBuf, params);
        Query query = sess.createQuery(queryBuf.toString());
		if (params != null) {
			for (int i = 0; i < params.size(); i++) {
				query.setParameter(i,params.get(i));
			}
		}
        return  query.executeUpdate();
	}

	public int deleteAll(List<T> list) {
        Session sess = getSession();
        for(T t : list)
        	sess.delete(t);
		return list.size();
	}

	public void saveOrUpdate(T object) {
		Session sess = getSession();
		sess.saveOrUpdate(object);
	}
}