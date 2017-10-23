package com.wondertek.mobilevideo.gke.ad.core.service;
import com.wondertek.mobilevideo.gke.ad.core.utils.PageList;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;





/**
 * Generic Manager that talks to GenericDao to CRUD POJOs.
 *
 * <p>Extend this interface if you want typesafe (no casting necessary) managers
 * for your domain objects.
 *
 * @author <a href="mailto:matt@raibledesigns.com">Matt Raible</a>
 *  Updated by jgarcia: added full text search + reindexing
 * @param <T> a type variable
 * @param <PK> the primary key for that type
 */
public interface GenericManager<T, PK extends Serializable> {

    /**
     * Generic method used to get all objects of a particular type. This
     * is the same as lookup up all rows in a table.
     * @return List of populated objects
     */
    List<T> getAll();
    
    List<T> getAll(Map<String, Object> conditions, String order, String sort);

    /**
     * Generic method to get an object based on class and identifier. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if
     * nothing is found.
     *
     * @param id the identifier (primary key) of the object to get
     * @return a populated object
     * @see org.springframework.orm.ObjectRetrievalFailureException
     */
    T get(PK id);

    /**
     * Checks for existence of an object of type T using the id arg.
     * @param id the identifier (primary key) of the object to get
     * @return - true if it exists, false if it doesn't
     */
    boolean exists(PK id);

    /**
     * Generic method to save an object - handles both update and insert.
     * @param object the object to save
     * @return the updated object
     */
    T save(T object);

    /**
     * Generic method to delete an object
     * @param object the object to remove
     */
    void remove(T object);

    /**
     * Generic method to delete an object based on class and id
     * @param id the identifier (primary key) of the object to remove
     */
    void remove(PK id);

    PageList getPageList(Map<String, Object> conditions, int pageNo, int pageSize, String order, String sort);
    
    long findCount(Map<String, Object> conditions);
    
     T getObject(Map<String, Object> conditions);
     
     int removeAll(List<PK> ids);
     
     List<T> finalAll(List<PK> ids);
     
     List<T> find(Map<String, Object> conditions);
     
    List<T>  saveBatch(Collection<T> objs, int commitInCount);
      
  	int deleteAll(List<T> ist);
  	
  	int remove(Map<String, Object> paramsMap);
  	
  	void saveOrUpdateAll(List<T> list);
  	
  	void saveOrUpdate(T object);
  	
}