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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.apache.struts2.json.annotations.JSON;

/**
 * Created by Administrator on 2017/6/22.
 */
@Entity
@Table(name = "data_dict")
public class DataDict implements Serializable {
    private static final long serialVersionUID = 1731961197409486301L;

    public static final String PUB_STATE_TYPE = "bestv_cnt_state";
    public static final String ZTE_PUB_STATE_TYPE = "zte_cnt_state";
    public static final String OBJ_ACTION = "obj_action";
    public static final String AUDIO_TYPE = "audio_type";
    public static final String BIT_RATE_TYPE = "bit_rate_type";
    public static final String VIDEO_TYPE = "video_type";
    public static final String AUDIEO_TYPE = "audieo_type";
    public static final String RESOLUTION = "resolution";
    public static final String VIDEO_PROFILE = "video_profile";
    public static final String SCREEN_FORMAT = "screen_format";
    public static final String CLOSED_CAPTIONING = "closed_captioning";
    public static final String MACROVISION = "macrovision";
    public static final String SERIES_PROGRAM_STATUS = "series_program_status";
    public static final String MOVIE_TYPE = "movie_type";
    public static final String SOURCE_DRM_TYPE = "source_drm_type";
    public static final String DEST_DRM_TYPE = "dest_drm_type";
    public static final String SYSTEM_LAYER = "system_layer";

    @Id
    @GeneratedValue(strategy= GenerationType.AUTO, generator="data_dict_SEQ")
    @SequenceGenerator(name="data_dict_SEQ", allocationSize = 1, sequenceName = "data_dict_SEQ")
    @Column(name = "id_")
    private Integer id;
    @Column(name = "type_")
    private String type;
    @Column(name = "type_desc")
    private String typeDesc;
    @Column(name = "value_")
    private String value;
    @Column(name = "name_")
    private String name;
    @Column(name = "status_")
    private Integer status;
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "create_time", updatable = false)
    private Date createTime;
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "update_time")
    private Date updateTime;

    @Override
    public String toString() {
        return "DataDict{" +
                "id=" + id +
                ", type='" + type + '\'' +
                ", typeDesc='" + typeDesc + '\'' +
                ", value='" + value + '\'' +
                ", name='" + name + '\'' +
                ", status=" + status +
                ", createTime=" + createTime +
                ", updateTime=" + updateTime +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        DataDict dataDict = (DataDict) o;

        if (id != null ? !id.equals(dataDict.id) : dataDict.id != null) return false;
        if (type != null ? !type.equals(dataDict.type) : dataDict.type != null) return false;
        if (typeDesc != null ? !typeDesc.equals(dataDict.typeDesc) : dataDict.typeDesc != null) return false;
        if (value != null ? !value.equals(dataDict.value) : dataDict.value != null) return false;
        if (name != null ? !name.equals(dataDict.name) : dataDict.name != null) return false;
        if (status != null ? !status.equals(dataDict.status) : dataDict.status != null) return false;
        if (createTime != null ? !createTime.equals(dataDict.createTime) : dataDict.createTime != null) return false;
        return updateTime != null ? updateTime.equals(dataDict.updateTime) : dataDict.updateTime == null;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (type != null ? type.hashCode() : 0);
        result = 31 * result + (typeDesc != null ? typeDesc.hashCode() : 0);
        result = 31 * result + (value != null ? value.hashCode() : 0);
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        result = 31 * result + (createTime != null ? createTime.hashCode() : 0);
        result = 31 * result + (updateTime != null ? updateTime.hashCode() : 0);
        return result;
    }

    public Integer getId() {

        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTypeDesc() {
        return typeDesc;
    }

    public void setTypeDesc(String typeDesc) {
        this.typeDesc = typeDesc;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
    @JSON(format = "yyyy-MM-dd HH:mm:ss")
    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
    @JSON(format = "yyyy-MM-dd HH:mm:ss")
    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }
}
