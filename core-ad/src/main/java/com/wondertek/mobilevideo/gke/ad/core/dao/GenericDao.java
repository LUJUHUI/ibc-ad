package com.wondertek.mobilevideo.gke.ad.core.dao;



import com.wondertek.mobilevideo.gke.ad.core.utils.PageList;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;



/**
 * Generic DAO (Data Access Object) with common methods to CRUD POJOs.
 *
 * <p>
 * Extend this interface if you want typesafe (no casting necessary) DAO's for
 * your domain objects.
 *
 * @author <a href="mailto:bwnoll@gmail.com">Bryan Noll</a>
 * @author jgarcia (update: added full text search + reindexing)
 *
 * @param <T>
 *            a type variable
 * @param <PK>
 *            the primary key for that type
 */
public interface GenericDao<T, PK extends Serializable> {

	/**
	 * Generic method used to get all objects of a particular type. This is the
	 * same as lookup up all rows in a table.
	 * 	
	 * @return List of populated objects
	 */
	List<T> getAll();
	
	
	List<T> getAll(Map<String, Object> conditions, String order, String sort);

	/**
	 * Gets all records without duplicates.
	 * <p>
	 * Note that if you use this method, it is imperative that your model
	 * classes correctly implement the hashcode/equals methods
	 * </p>
	 * 
	 * @return List of populated objects
	 */
	List<T> getAllDistinct();

	/**
	 * Generic method to get an object based on class and identifier. An
	 * ObjectRetrievalFailureException Runtime Exception is thrown if nothing is
	 * found.
	 *
	 * @param id
	 *            the identifier (primary key) of the object to get
	 * @return a populated object
	 * @see org.springframework.orm.ObjectRetrievalFailureException
	 */
	T get(PK id);

	/**
	 * Checks for existence of an object of type T using the id arg.
	 * 
	 * @param id
	 *            the id of the entity
	 * @return - true if it exists, false if it doesn't
	 */
	boolean exists(PK id);

	/**
	 * Generic method to save an object - handles both update and insert.
	 * 
	 * @param object
	 *            the object to save
	 * @return the persisted object
	 */
	T save(T object);

	/**
	 * Generic method to delete an object
	 * 
	 * @param object
	 *            the object to remove
	 */
	void remove(T object);

	/**
	 * Generic method to delete an object
	 * 
	 * @param id
	 *            the identifier (primary key) of the object to remove
	 */
	void remove(PK id);

	/**
	 * Find a list of records by using a named query
	 * 
	 * @param queryName
	 *            query name of the named query
	 * @param queryParams
	 *            a map of the query names and the values
	 * @return a list of the records found
	 */
	List<T> findByNamedQuery(String queryName, Map<String, Object> queryParams);

	PageList getPageList(Map<String, Object> conditions, int start, int limit,
						 String order, String sort);

	long findCount(Map<String, Object> conditions);

	List<Object[]> findSQL(String queryString, Object[] params, int start, int limit);

	T getObject(Map<String, Object> conditions);

	int removeAll(List<PK> ids);

	List<T> finalAll(List<PK> ids);

	List<T> find(Map<String, Object> conditions);

	List<T> find(Map<String, Object> conditions, int start, int limit, String order, String sort);
	
	List<T> find(String queryString, Object[] params, String order, String sort);
	
    List<T> find(String queryString, Object[] params, int start, int limit, String order, String sort);
    List<T> find(String queryString, Object[] params, int start, int limit);

	public List<T>  saveBatch(Collection<T> objs, int commitInCount);

	int remove(Map<String, Object> conditions);

	int deleteAll(List<T> list);
	void saveOrUpdate(T object);

}