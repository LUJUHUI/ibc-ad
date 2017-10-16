package com.wondertek.mobilevideo.bc.core.service.impl;
import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.wondertek.mobilevideo.bc.core.dao.GenericDao;
import com.wondertek.mobilevideo.bc.core.service.GenericManager;
import com.wondertek.mobilevideo.bc.core.utils.PageList;



/**
 * This class serves as the Base class for all other Managers - namely to hold
 * common CRUD methods that they might all use. You should only need to extend
 * this class when your require custom CRUD logic.
 * <p/>
 * <p>To register this class in your Spring context file, use the following XML.
 * <pre>
 *     &lt;bean id="userManager" class="com.yourcompany.service.impl.GenericManagerImpl"&gt;
 *         &lt;constructor-arg&gt;
 *             &lt;bean class="com.yourcompany.dao.hibernate.GenericDaoHibernate"&gt;
 *                 &lt;constructor-arg value="com.yourcompany.model.User"/&gt;
 *                 &lt;property name="sessionFactory" ref="sessionFactory"/&gt;
 *             &lt;/bean&gt;
 *         &lt;/constructor-arg&gt;
 *     &lt;/bean&gt;
 * </pre>
 * <p/>
 * <p>If you're using iBATIS instead of Hibernate, use:
 * <pre>
 *     &lt;bean id="userManager" class="com.yourcompany.service.impl.GenericManagerImpl"&gt;
 *         &lt;constructor-arg&gt;
 *             &lt;bean class="com.yourcompany.dao.ibatis.GenericDaoiBatis"&gt;
 *                 &lt;constructor-arg value="com.yourcompany.model.User"/&gt;
 *                 &lt;property name="dataSource" ref="dataSource"/&gt;
 *                 &lt;property name="sqlMapClient" ref="sqlMapClient"/&gt;
 *             &lt;/bean&gt;
 *         &lt;/constructor-arg&gt;
 *     &lt;/bean&gt;
 * </pre>
 *
 * @param <T>  a type variable
 * @param <PK> the primary key for that type
 * @author <a href="mailto:matt@raibledesigns.com">Matt Raible</a>
 *  Updated by jgarcia: added full text search + reindexing
 */
public class GenericManagerImpl<T, PK extends Serializable> implements GenericManager<T, PK> {
    /**
     * Log variable for all child classes. Uses LogFactory.getLog(getClass()) from Commons Logging
     */
    protected final Log log = LogFactory.getLog(getClass());

    /**
     * GenericDao instance, set by constructor of child classes
     */
    protected GenericDao<T, PK> dao;


    public GenericManagerImpl() {
    }

    public GenericManagerImpl(GenericDao<T, PK> genericDao) {
        this.dao = genericDao;
    }

    /**
     * {@inheritDoc}
     */
    public List<T> getAll() {
        return dao.getAll();
    }

    /**
     * {@inheritDoc}
     */
    public T get(PK id) {
        return dao.get(id);
    }

    /**
     * {@inheritDoc}
     */
    public boolean exists(PK id) {
        return dao.exists(id);
    }

    /**
     * {@inheritDoc}
     */
    public T save(T object) {
        return dao.save(object);
    }

    /**
     * {@inheritDoc}
     */
    public void remove(T object) {
        dao.remove(object);
    }

    /**
     * {@inheritDoc}
     */
    public void remove(PK id) {
        dao.remove(id);
    }
    
    public PageList getPageList(Map<String, Object> conditions, int pageNo, int pageSize, String order, String sort){
    	return dao.getPageList(conditions, pageNo, pageSize,order,sort);
    }
    
    public long findCount(Map<String, Object> conditions){
    	return dao.findCount(conditions);
    }

    public T getObject(Map<String, Object> conditions){
    	return dao.getObject(conditions);
    }
    
    public int removeAll(List<PK> ids){
    	return dao.removeAll(ids);
    }
    public List<T> finalAll(List<PK> ids){
    	return dao.finalAll(ids);
    }
    
    public   List<T> getAll(Map<String, Object> conditions,String order,String sort){
    	return dao.getAll(conditions, order, sort);
    }
    
    public List<T> find(Map<String, Object> conditions){
    	return dao.find(conditions);
    }
    
    public List<T>  saveBatch(Collection<T> objs, int commitInCount){
    	return  dao.saveBatch(objs, commitInCount);
    }

	public int deleteAll(List<T> list) {
		return dao.deleteAll(list);
	}

	public int remove(Map<String, Object> conditions) {
		return dao.remove(conditions);
	}

	public void saveOrUpdateAll(List<T> list) {
		saveBatch(list, list.size());
	}

	public void saveOrUpdate(T object) {
		dao.saveOrUpdate(object);
	}
  
}