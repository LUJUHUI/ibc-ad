<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp" %>

<style>
    .form-horizontal .control-label {
        text-align: right;
        margin-bottom: 0;
        padding-top: 3px;
    }
    .col-sm-1, .col-sm-3, .col-sm-11 {
        padding-left: 6px;
        padding-right: 6px;
    }
    .preview-container {
        margin: 0px 20px 30px 30px;
        background-color: #D0D0D0;
        box-shadow: 0 0 3px #000;
        width: auto;
        height: 320px;
        display: none;
    }
    .preview-container-active {
        display: block;
    }
    .img-class {
        width: 100%;
        height: 100%;
    }
</style>
<input type="text" hidden value="${id}" id="contentId"/>
<div class="modal-content">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="gridSystemModalLabel"><fmt:message key="channel.title" /> </h4>
    </div>
    <div class="modal-body">
        <div class="row" style="height: 400px;">
            <div class="col-xs-12" id="content-detail">
                <form class="form-horizontal" role="form" id="detailForm" onsubmit="return false;">
                    <fieldset>
                        <legend><fmt:message key="channel.add.title"/> </legend>
                        <div class="form-group">
                            
                            <label class="col-sm-1 control-label" for="channelNumber"><fmt:message key="channel.channelNumber"/> </label>
                            <div class="col-sm-3">
                                <input class="form-control input-sm" id="channelNumber" name="channel.channelNumber" type="text" value="" />
                            </div>
                            <label class="col-sm-1 control-label" for="name"><fmt:message key="channel.name"/> </label>
                            <div class="col-sm-3">
                                <input class="form-control input-sm" id="name" name="channel.name" type="text" value="" />
                            </div>
                            <label class="col-sm-1 control-label" for="callSign"><fmt:message key="channel.callSign"/> </label>
                            <div class="col-sm-3">
                                <input class="form-control input-sm" id="callSign" name="channel.callSign" type="text" value="" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-1 control-label" for="timeShift"><fmt:message key="channel.timeShift"/> </label>
                            <div class="col-sm-3">
                                <select class="form-control input-sm" id="timeShift" name="channel.timeShift">
					                <option value="">全部</option>
				                    <option value="0"><fmt:message key="channel.timeShift.0"/></option>
				                    <option value="1"><fmt:message key="channel.timeShift.1"/></option>
					            </select>
                            </div>
                            <label class="col-sm-2 control-label" for="storageDuration"><fmt:message key="channel.storageDuration"/> </label>
                            <div class="col-sm-2">
                                <input class="form-control input-sm" id="storageDuration" name="channel.storageDuration" type="text" value="" />
                            </div>
                            <label class="col-sm-2 control-label" for="timeShiftDuration"><fmt:message key="channel.timeShiftDuration"/> </label>
                            <div class="col-sm-2">
                                <input class="form-control input-sm" id="timeShiftDuration" name="channel.timeShiftDuration" type="text" value="" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-1 control-label" for="country"><fmt:message key="channel.country"/> </label>
                            <div class="col-sm-3">
                                <input class="form-control input-sm" id="country" name="channel.country" type="text" value="" />
                            </div>
                             <label class="col-sm-1 control-label" for="state"><fmt:message key="channel.state"/> </label>
                            <div class="col-sm-3">
                                <input class="form-control input-sm" id="state" name="channel.state" type="text" value="" />
                            </div>
                            <label class="col-sm-1 control-label" for="city"><fmt:message key="channel.city"/> </label>
                            <div class="col-sm-3">
                                <input class="form-control input-sm" id="city" name="channel.city" type="text" value="" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-1 control-label" for="zipCode"><fmt:message key="channel.zipCode"/> </label>
                            <div class="col-sm-3">
                                <input class="form-control input-sm" id="zipCode" name="channel.zipCode" type="text" value="" />
                            </div>
                            <label class="col-sm-1 control-label" for="language"><fmt:message key="channel.language"/> </label>
                            <div class="col-sm-3">
                                <input class="form-control input-sm" id="language" name="channel.language" type="text" value="" />
                            </div>
                            <label class="col-sm-1 control-label" for="status"><fmt:message key="channel.status"/> </label>
                            <div class="col-sm-3">
					            <select class="form-control input-sm" id="status_" name="channel.status">
					                <option value="">全部</option>
				                    <option value="0"><fmt:message key="channel.status.0"/></option>
				                    <option value="1"><fmt:message key="channel.status.1"/></option>
					            </select>
                            </div>
                            
                        </div>
                        <div class="form-group">
                            <label class="col-sm-1 control-label" for="type"><fmt:message key="channel.type"/> </label>
                            <div class="col-sm-3">
                                <select class="form-control input-sm" id="type" name="channel.type">
					                <option value="">全部</option>
				                    <option value="1"><fmt:message key="channel.type.1"/></option>
				                    <option value="2"><fmt:message key="channel.type.2"/></option>
					            </select>
                            </div>
                            <label class="col-sm-1 control-label" for="subType"><fmt:message key="channel.subType"/> </label>
                            <div class="col-sm-3">
                                <input class="form-control input-sm" id="subType" name="channel.subType" type="text" value="" />
                            </div>
                            <label class="col-sm-1 control-label" for="macrovision"><fmt:message key="channel.macrovision"/> </label>
                            <div class="col-sm-3">
                                <select class="form-control input-sm" id="macrovision">
					                <option value="">全部</option>
				                    <option value="0"><fmt:message key="channel.macrovision.0"/></option>
				                    <option value="1"><fmt:message key="channel.macrovision.1"/></option>
					            </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-1 control-label" for="videoType"><fmt:message key="channel.videoType"/> </label>
                     	       <div class="col-sm-3">
                                <input class="form-control input-sm" id="videoType" name="channel.videoType" type="text" value="" />
                            </div>
                            <label class="col-sm-1 control-label" for="audioType"><fmt:message key="channel.audioType"/> </label>
                     	       <div class="col-sm-3">
                                <input class="form-control input-sm" id="audioType" name="channel.audioType" type="text" value="" />
                            </div>
                            <label class="col-sm-1 control-label" for="streamType"><fmt:message key="channel.streamType"/> </label>
                            <div class="col-sm-3">
                                <input class="form-control input-sm" id="streamType" name="channel.streamType" type="text" value="" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-1 control-label" for="startTime"><fmt:message key="channel.startTime"/> </label>
                            <div class="col-sm-3">
                                <input class="form-control input-sm" id="startTime" name="channel.startTime" type="text" value="" />
                            </div>
                            <label class="col-sm-1 control-label" for="endTime"><fmt:message key="channel.endTime"/> </label>
                            <div class="col-sm-3">
                                <input class="form-control input-sm" id="endTime" name="channel.endTime" type="text" value="" />
                            </div>
                            <label class="col-sm-1 control-label" for=bilingual><fmt:message key="channel.bilingual"/> </label>
                            <div class="col-sm-3">
                                <input class="form-control input-sm" id="bilingual" name="channel.bilingual" type="text" value="" />
                            </div>
                        </div>
                        <div class="form-group">
                        	<label class="col-sm-1 control-label" for="code_"><fmt:message key="channel.code"/> </label>
                            <div class="col-sm-5">
                                <input class="form-control input-sm" id="code_" name="channel.code" type="text" value="" />
                            </div>
                            <label class="col-sm-1 control-label" for="description"><fmt:message key="channel.description"/> </label>
                            <div class="col-sm-5">
                                <input class="form-control input-sm" id="description" name="channel.description" type="text" value="" />
                            </div>
                        </div>
                        <div class="form-group">
                        	<label class="col-sm-1 control-label" for="url"><fmt:message key="channel.url"/> </label>
                            <div class="col-sm-11">
                                <input class="form-control input-sm" id="url" name="channel.url" type="text" value="" />
                            </div>
                        </div>
                    </fieldset>
                    <fieldset>
                    	<legend><fmt:message key="channel.multiCast.title"/> </legend>
                    	<div id="multiCastDiv">
                    		<div class="form-group">
	                            <label class="col-sm-1 control-label" for="bitRateType"><fmt:message key="channel.bitRateType"/> </label>
	                            <div class="col-sm-2">
	                                <select class="form-control input-sm" id="bitRateType" name="physicalChannelList[0].bitRateType">
						                <option value="">全部</option>
					                    <option value="2"><fmt:message key="channel.bitRateType.2"/></option>
					                    <option value="4"><fmt:message key="channel.bitRateType.4"/></option>
						            </select>
	                            </div>
	                            <label class="col-sm-1 control-label" for="multiCastIP"><fmt:message key="channel.multiCastIP"/> </label>
	                   	       	<div class="col-sm-3">
	                              	<input class="form-control input-sm" id="multiCastPort" name="physicalChannelList[0].multiCastIP" type="text" value="" />
	                          	</div>
	                            <label class="col-sm-1 control-label" for="multiCastPort"><fmt:message key="channel.multiCastPort"/> </label>
	                	       	<div class="col-sm-2">
	                           		<input class="form-control input-sm" id="multiCastPort" name="physicalChannelList[0].multiCastPort" type="text" value="" />
	                      		</div>
	                        </div>
                    	</div>
                        <div class="form-group">
                        	<div class="col-sm-3">
                        		<button type="button" class="btn btn-info btn-sm" style="margin-left: 20px;" id="addMultiCast">
				                	<i class="ace-icon glyphicon glyphicon-plus"></i><fmt:message key="channel.multiCast.add"/>
				            	</button>
                        	</div>
                        </div>
                    </fieldset>
                    <fieldset>
                    	<legend></legend>
                    	<div class="form-group">
							<div class="col-sm-12">
								<button class="btn btn-danger btn-block" id="save">Save</button>
							</div>
						</div>
                    </fieldset>
                </form>
            </div>
        </div>
        <div class="hr hr-18 hr-double dotted"></div>
        <div class="row" style="height: 400px;">
            <div class="col-xs-6" id="related-info">
                
            </div>
            <div class="col-xs-6" id="preview-div">
                
            </div>
        </div>
    </div>
</div><!-- /.modal-content -->


<script>
    jQuery(function($) {
    	
        var multiCas = 1;
        $("#addMultiCast").on("click",function(e){
        	var multiCastStr = '<div class="form-group" id="multiCasList_'+multiCas+'">'+
						        	'<label class="col-sm-1 control-label" for="bitRateType"><fmt:message key="channel.bitRateType"/></label>'+
						        	'<div class="col-sm-2">'+
						        		'<select class="form-control input-sm" id="bitRateType" name="physicalChannelList['+multiCas+'].bitRateType">'+
						        			'<option value="">全部</option>'+
						        			'<option value="2"><fmt:message key="channel.bitRateType.2"/></option>'+
						        			'<option value="4"><fmt:message key="channel.bitRateType.4"/></option>'+
						        		'</select>'+
						        	'</div>'+
						        	'<label class="col-sm-1 control-label" for="multiCastIP"><fmt:message key="channel.multiCastIP"/></label>'+
						        	'<div class="col-sm-3">'+
						        		'<input class="form-control input-sm" id="multiCastIP" name="physicalChannelList['+multiCas+'].multiCastIP" type="text" value="" />'+
						        	'</div>'+
						        	'<label class="col-sm-1 control-label" for="multiCastPort"><fmt:message key="channel.multiCastPort"/></label>'+
						        	'<div class="col-sm-2">'+
						        		'<input class="form-control input-sm" id="multiCastPort" name="physicalChannelList['+multiCas+'].multiCastPort" type="text" value="" />'+
						        	'</div>'+
						        	'<div class="col-sm-2">'+
		                        		'<button type="button" id="'+multiCas+'" onclick="delmultiCas(this)" class="btn btn-info btn-sm" style="margin-left: 20px;" id="addMultiCast">'+
						                	'<i class="ace-icon glyphicon glyphicon-remove"></i><fmt:message key="channel.multiCast.remove"/>'+
						            	'</button>'+
	                        		'</div>'+
						        '</div>';
			$("#multiCastDiv").append(multiCastStr);
			multiCas++;
        });
        
        $("#save").on("click",function(e){
        	var name = $("#name").val();
        	var callSign = $("#callSign").val();
        	var type = $("#type").val();
        	var status = $("#status_").val();
        	var startTime = $("#startTime").val();
        	var endTime = $("#endTime").val();
        	var endTime = $("#endTime").val();
        	var url = $("#url").val();
        	var code = $("#code_").val();
        	if(name == null || name == ''){
        		$("#name").tips({side:2,msg:'此项必填 ',time:3});
        		return false;
        	}
        	if(callSign == ''){
        		$("#callSign").tips({side:2,msg:'此项必填 ',time:3});
        		return false;
        	}
        	if(type == ''){
        		$("#type").tips({side:2,msg:'此项必填 ',time:3});
        		return false;
        	}
        	if(status == ''){
        		$("#status_").tips({side:2,msg:'此项必填 ',time:3});
        		return false;
        	}
        	if(startTime == ''){
        		$("#startTime").tips({side:2,msg:'此项必填 ',time:3});
        		return false;
        	}
        	if(endTime == ''){
        		$("#endTime").tips({side:2,msg:'此项必填 ',time:3});
        		return false;
        	}
        	if(type == '2' && url == ''){
        		$("#url").tips({side:2,msg:'此项必填 ',time:3});
    			return false;
        	}
        	if(code == ''){
        		$("#code_").tips({side:2,msg:'此项必填 ',time:3});
    			return false;
        	}
        	
          	$.ajax({
				url:"<c:url value='/json/liveChannel_addChannel.do'/>",
				data:$("#detailForm").serialize(),
				type:"post",
				success:function(data){
					$("#detailModal").modal('hide')
				},error:function(){
					alert("保存失败，无法连接服务器");
				}
			});

        });
        	
    });
    function delmultiCas(obj){
    	$("#multiCasList_"+obj.id).remove();
    }
</script>