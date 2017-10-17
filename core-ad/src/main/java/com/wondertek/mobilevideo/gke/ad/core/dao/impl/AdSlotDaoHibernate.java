package com.wondertek.mobilevideo.gke.ad.core.dao.impl;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.wondertek.mobilevideo.gke.ad.core.dao.AdSlotDao;
import com.wondertek.mobilevideo.gke.ad.core.model.AdSlot;
import com.wondertek.mobilevideo.gke.ad.core.utils.PageList;

public class AdSlotDaoHibernate extends GenericDaoHibernate<AdSlot, Long> implements AdSlotDao{

	public AdSlotDaoHibernate() {
		super(AdSlot.class);
	}
	public PageList listAdSlot(Map<String, Object> params, Integer pageNo, Integer pageSize, String sort, String order) {
		StringBuffer hql  = new StringBuffer();
		hql.append("from Channel where 1=1 ");
		List<String> hqlParam = new ArrayList<String>();
		this.getParams(params, hql, true, hqlParam);
		Integer recordCount = findCount(" select count(1) "+hql.toString(), hqlParam.toArray());
		
		PageList pageList = new PageList();
		if(recordCount==null || recordCount<1){
			return pageList;
		}
		pageList.setPageIndex(pageNo);
		pageList.setRecordCount(recordCount);
		pageList.setPageSize(pageSize);
		pageList.initialize();
		
		if(StringUtils.isNotBlank(order) && StringUtils.isNotBlank(sort) ){
			hql.append(" order by "+ sort +"  "+ order);
		}else{
			hql.append(" order by id desc ");
		}
		
		List<AdSlot> list=find(hql.toString(), hqlParam.toArray(), (pageList.getPageIndex() - 1) * pageSize, pageSize);
		pageList.setList(list);
	    return pageList;
	}
	
	public void deleteByAdId(Long logId) {
		  this.deleteByAdId(logId);
	}
	public void saveAdSlot(AdSlot adSlot) {
		 this.saveAdSlot(adSlot);
	}
	public void updateAdSlot(AdSlot adSlot) {
		  this.updateAdSlot(adSlot);
	}
	public AdSlot getAdSlotById(Long logId) {
		// TODO Auto-generated method stub
		return  this.get(logId);
	}
	public void getParams(Map<String, Object> params,StringBuffer hql,boolean isHql,List<String> hqlParam){
		String slotName = params.get("slotName").toString();
		if(!StringUtils.isBlank(slotName)){
			if(isHql){
				hql.append(" and slotName = ? ");
			}else{
				hql.append(" and channel_number");
			}
			hqlParam.add(slotName);
		}
		String navig = params.get("navig").toString();
		if(!StringUtils.isBlank(navig)){
			if(isHql){
				hql.append(" and navig = ? ");
			}else{
				hql.append(" and channel_number");
			}
			hqlParam.add(navig);
		}
		String type = params.get("type").toString();
		if(!StringUtils.isBlank(type)){
			if(isHql){
				hql.append(" and type = ? ");
			}else{
				hql.append(" and channel_number");
			}
			hqlParam.add(type);
		}
		String status = params.get("status").toString();
		if(!StringUtils.isBlank(status)){
			if(isHql){
				hql.append(" and status = ? ");
			}else{
				hql.append(" and channel_number");
			}
			hqlParam.add(status);
		}
		String startCreateTime = params.get("startCreateTime").toString();
		if(!StringUtils.isBlank(startCreateTime)){
			if(isHql){
				hql.append(" and startCreateTime = ? ");
			}else{
				hql.append(" and channel_number");
			}
			hqlParam.add(startCreateTime);
		}
		String endCreateTime = params.get("endCreateTime").toString();
		if(!StringUtils.isBlank(endCreateTime)){
			if(isHql){
				hql.append(" and endCreateTime = ? ");
			}else{
				hql.append(" and channel_number");
			}
			hqlParam.add(endCreateTime);
		}
	}
}
