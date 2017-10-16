<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp" %>

<div class="breadcrumbs" id="breadcrumbs">
    <script type="text/javascript">
        try {
            ace.settings.check('breadcrumbs', 'fixed')
        } catch (e) {
        }
    </script>
    <ul class="breadcrumb">
        <li><i class="ace-icon fa fa-home home-icon"></i>
            <a href=""><fmt:message key="webapp.home"/></a>
        </li>
        <li>
            <fmt:message key="system.tool.title"/>
        </li>
        <li class="active">
            <span><fmt:message key="system.tool.bestv.cont.error"/></span>
        </li>
    </ul>
    <!-- /.breadcrumb -->
</div>
<style>
    .modal {
        z-index: 1048;
    }
    .modal-dialog {
        margin: 120px auto;
    }
</style>

<div class="page-content">
	<div class="row" style="height: 400px;">
		<div class="col-xs-12" id="content-detail" >
			<form class="form-inline" id="errorFile">
				<div class="form-group">
					<label class="col-sm-5 control-label" for="error_type"><fmt:message key="system.tool.bestv.cont.error.type"/>:</label>
		       		<div class="col-sm-3">
			           	<select class="form-control input-sm" id="error_type" name="type">
						   	<option value="1"><fmt:message key="system.tool.bestv.cont.error.type.1"/></option>
							<option value="2"><fmt:message key="system.tool.bestv.cont.error.type.2"/></option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-1 control-label"></label>
		       		<div class="col-sm-3">
			           <input type="file" name="error" onchange="uploadSchedule(this,'xlsx')">
					</div>
				</div>
				<div class="form-group">
		       		<div class="col-sm-3">
			           <input type="button" value="上传 " id="upload">
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
<script>
    jQuery(function($) {
    	$("#upload").on("click",function(){
    		var formData = new FormData($("#errorFile")[0]);
        	$.ajax({
    			url:"<c:url value='/json/bestvContent_inputNeiRong.do'/>",
    			cache: false,
    			data:formData,
    			type:"post",
    			processData: false,
    			contentType: false,
    			success:function(data){
    				alert(data.result);
    			},error:function(){
    				alert("保存失败，无法连接服务器");
    			}
    		});
    	});
    });
    function uploadSchedule(obj,filter){
    	var file = obj.value.match(/[^\/\\]+$/gi)[0];
        var rx = new RegExp('\\.(' + (filter?filter:'') + ')$','gi');
        if(filter&&file&&!file.match(rx)){
          alert("只能选择xlsx");
          $("#errorFile")[0].reset();
        } 
    }
</script>
