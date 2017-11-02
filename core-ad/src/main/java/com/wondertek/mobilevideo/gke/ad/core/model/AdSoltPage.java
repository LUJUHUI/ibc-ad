package com.wondertek.mobilevideo.gke.ad.core.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

public class AdSoltPage implements Serializable {
 
	    private static final long serialVersionUID = 467620661858607767L;
		
		private String nodeId;                          //广告位Id
		private String name;				 //广告位名称 
		private String type;				     //导航   1.首页   2.直播   3.会员
		private String theme;				 //导航频道ID
		private String imageURL;					 //广告位宽度
		private String requestURL;					 //广告位高度
		public String getNodeId() {
			return nodeId;
		}
		public void setNodeId(String nodeId) {
			this.nodeId = nodeId;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public String getType() {
			return type;
		}
		public void setType(String type) {
			this.type = type;
		}
		public String getTheme() {
			return theme;
		}
		public void setTheme(String theme) {
			this.theme = theme;
		}
		public String getImageURL() {
			return imageURL;
		}
		public void setImageURL(String imageURL) {
			this.imageURL = imageURL;
		}
		public String getRequestURL() {
			return requestURL;
		}
		public void setRequestURL(String requestURL) {
			this.requestURL = requestURL;
		}
		@Override
		public String toString() {
			return "AdSoltPage [nodeId=" + nodeId + ", name=" + name + ", type=" + type + ", theme=" + theme
					+ ", imageURL=" + imageURL + ", requestURL=" + requestURL + "]";
		}
	 
		
}
