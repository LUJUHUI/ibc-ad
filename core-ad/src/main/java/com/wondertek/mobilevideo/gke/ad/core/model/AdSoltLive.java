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

public class AdSoltLive implements Serializable {
 
	    private static final long serialVersionUID = 467620661858607767L;
		
		private String name;				     //名称
		private String classType;				     //类型
		private String requestURL;				 //请求URL
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public String getClassType() {
			return classType;
		}
		public void setClassType(String classType) {
			this.classType = classType;
		}
		public String getRequestURL() {
			return requestURL;
		}
		public void setRequestURL(String requestURL) {
			this.requestURL = requestURL;
		}
		@Override
		public int hashCode() {
			final int prime = 31;
			int result = 1;
			result = prime * result + ((classType == null) ? 0 : classType.hashCode());
			result = prime * result + ((name == null) ? 0 : name.hashCode());
			result = prime * result + ((requestURL == null) ? 0 : requestURL.hashCode());
			return result;
		}
		@Override
		public boolean equals(Object obj) {
			if (this == obj)
				return true;
			if (obj == null)
				return false;
			if (getClass() != obj.getClass())
				return false;
			AdSoltLive other = (AdSoltLive) obj;
			if (classType == null) {
				if (other.classType != null)
					return false;
			} else if (!classType.equals(other.classType))
				return false;
			if (name == null) {
				if (other.name != null)
					return false;
			} else if (!name.equals(other.name))
				return false;
			if (requestURL == null) {
				if (other.requestURL != null)
					return false;
			} else if (!requestURL.equals(other.requestURL))
				return false;
			return true;
		}
		@Override
		public String toString() {
			return "AdSoltLive [name=" + name + ", classType=" + classType + ", requestURL=" + requestURL + "]";
		}
	   
		
}
