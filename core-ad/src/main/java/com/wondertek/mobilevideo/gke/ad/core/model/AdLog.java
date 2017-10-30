package com.wondertek.mobilevideo.gke.ad.core.model;

import java.awt.*;
import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name = "ad_log")//广告位
public class AdLog implements Serializable {

    /**
     * 操作类型枚举
     */
    public enum adLogOperType {
        /**
         * 301:播控通过，302：播控驳回
         */
        OPER_TYPE_301(301), OPER_TYPE_302(302);

        private Integer operType;

        private adLogOperType(Integer operType) {
            this.operType = operType;
        }

        public Integer getOperType() {
            return operType;
        }
    }

    /**
     * 日志类型枚举
     */
    public enum adLogType{

        /**
         * 401:广告素材审核，402，广告位审核
         */
        AD_LOG_TYPE_401(401), AD_LOG_TYPE(402);
        private Integer logType;

        private adLogType(Integer logType) {
            this.logType = logType;
        }

        public Integer getLogType() {
            return logType;
        }
    }

    private static final long serialVersionUID = 467620661858607767L;
		
    private Integer id;                          //日志Id
    private Integer logType;                     //日志类型
    private Integer operType;                    //操作类型
    private String operResult;                   //操作结果
    private String operName;                     //操作人
    private Date createTime;                     //创建时间

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "AD_LOG_SEQ")
    @SequenceGenerator(name = "AD_LOG_SEQ", allocationSize = 1, sequenceName = "AD_LOG_SEQ")
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    @Column(name = "oper_type")
    public Integer getOperType() {
        return operType;
    }

    public void setOperType(Integer operType) {
        this.operType = operType;
    }

    @Column(name = "oper_result")
    public String getOperResult() {
        return operResult;
    }

    public void setOperResult(String operResult) {
        this.operResult = operResult;
    }

    @Column(name = "oper_name")
    public String getOperName() {
        return operName;
    }

    public void setOperName(String operName) {
        this.operName = operName;
    }

    @Column(name = "create_time")
    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    @Column(name = "log_type")
    public Integer getLogType() {
        return logType;
    }

    public void setLogType(Integer logType) {
        this.logType = logType;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        AdLog adLog = (AdLog) o;

        if (id != null ? !id.equals(adLog.id) : adLog.id != null) return false;
        if (logType != null ? !logType.equals(adLog.logType) : adLog.logType != null) return false;
        if (operType != null ? !operType.equals(adLog.operType) : adLog.operType != null) return false;
        if (operResult != null ? !operResult.equals(adLog.operResult) : adLog.operResult != null) return false;
        if (operName != null ? !operName.equals(adLog.operName) : adLog.operName != null) return false;
        return createTime != null ? createTime.equals(adLog.createTime) : adLog.createTime == null;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (logType != null ? logType.hashCode() : 0);
        result = 31 * result + (operType != null ? operType.hashCode() : 0);
        result = 31 * result + (operResult != null ? operResult.hashCode() : 0);
        result = 31 * result + (operName != null ? operName.hashCode() : 0);
        result = 31 * result + (createTime != null ? createTime.hashCode() : 0);
        return result;
    }

    @Override
    public String toString() {
        return "AdLog{" +
                "id=" + id +
                ", logType=" + logType +
                ", operType=" + operType +
                ", operResult='" + operResult + '\'' +
                ", operName='" + operName + '\'' +
                ", createTime=" + createTime +
                '}';
    }
}
