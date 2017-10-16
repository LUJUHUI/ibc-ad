<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@page import="com.wondertek.mobilevideo.bc.core.model.AuthVerifyLog"%>

<%
    String basePath = request.getContextPath();
    pageContext.setAttribute("resultFalure", AuthVerifyLog.RESULT_FALURE);
    pageContext.setAttribute("resultSuccess", AuthVerifyLog.RESULT_SUCCESS);
    pageContext.setAttribute("type1", AuthVerifyLog.TYPE_1);
    pageContext.setAttribute("type2", AuthVerifyLog.TYPE_2);
%>

<div class="breadcrumbs" id="breadcrumbs">
    <script type="text/javascript">
        try {
            ace.settings.check('breadcrumbs', 'fixed')
        } catch (e) {
        }
    </script>
    <ul class="breadcrumb">
        <li><i class="ace-icon fa fa-home home-icon"></i>
            <a href="${indexPage}"><fmt:message key="webapp.home"/></a>
        </li>
        <li class="active">
            <span><fmt:message key="business.auth.logs.show"/></span>
        </li>
    </ul>
    <!-- /.breadcrumb -->
</div>

<style type="text/css">
    .ui-jqgrid .ui-jqgrid-bdiv {
        overflow: auto;
    }
</style>
<div class="page-content">
    <div class="page-header">
        <form class="form-inline">
            <label class="control-label" for="id">ID</label>
            <input type="text" class="form-control input-sm" style="width: 80px;margin-left: 5px;" id="id">
            
            <label class="control-label" for="type"><fmt:message key="bestv.content.type"/></label>
            <select class="form-control input-sm" id="type" style="margin-left: 5px;">
            	<option value="">全部</option>
            	<option value="${type1}"><fmt:message key="bestv.log.type.1"/></option>
            	<option value="${type2}"><fmt:message key="bestv.log.type.2"/></option>
            </select>
            
            <label class="control-label" for="code"><fmt:message key="bestv.content.code"/></label>
            <input type="text" class="form-control input-sm" style="width: 80px;margin-left: 5px;" id="code">

            <label class="control-label" for="result"><fmt:message key="bestv.content.status"/></label>
            <select class="form-control input-sm" id="result" style="margin-left: 5px;">
                <option value="">全部</option>
                <option value="${resultFalure}"><fmt:message key="business.auth.logs.show.falure"/></option>
                <option value="${resultSuccess}"><fmt:message key="business.auth.logs.show.success"/></option>
            </select>

            <label class="control-label" for="createTime"><fmt:message key="bestv.content.create.time"/></label>
            <input class="form-control input-sm" style="width: 200px;" type="text" id="createTime"/>

            <button type="button" class="btn btn-info btn-sm" style="margin-left: 20px;" id="search">
                <i class="ace-icon fa fa-search bigger-110"></i>搜索
            </button>
        </form>
    </div>
    <!-- /.page-header -->
    <div class="row">
        <div class="col-xs-12">
            <table id="grid-table"></table>
            <div id="grid-pager"></div>
        </div>
    </div>
    <!-- /.row -->
</div>

<script type="text/javascript">

    jQuery(function($) {
        var grid_selector = "#grid-table";
        var pager_selector = "#grid-pager";

        var parent_column = $(grid_selector).closest('[class*="col-"]');
        //resize to fit page size
        $(window).on('resize.jqGrid', function () {
            $(grid_selector).jqGrid( 'setGridWidth', parent_column.width() );
        })

        //resize on sidebar collapse/expand
        $(document).on('settings.ace.jqGrid' , function(ev, event_name, collapsed) {
            if( event_name === 'sidebar_collapsed' || event_name === 'main_container_fixed' ) {
                //setTimeout is for webkit only to give time for DOM changes and then redraw!!!
                setTimeout(function() {
                    $(grid_selector).jqGrid( 'setGridWidth', parent_column.width() );
                }, 20);
            }
        })

        $('#createTime').daterangepicker({
            "ableToNull": true,
            "showDropdowns":true,
            "showCustomRangeLabel":false,
            "alwaysShowCalendars": true,
            "startDate": moment().subtract('days', 30),
            "endDate": moment().subtract('days', 0),
            "opens": "left",
            "drops": "down"
        }, function(start, end, label) {//时间改变后执行该方法
            //alert(label);
        });

		//定义搜索参数
		var id_ = $('#id').val();
		var type_ = $('#type').val();
		var code_ = $('#code').val();
		var result_ = $('#result').val();
		//var operateTimeMS = $('#operateTimeMS').val();
		
        var createTime_dateRange = $('#createTime').val().replace(/\s/g, "").split("至");
        var createTime_startDate = createTime_dateRange[0] + " 00:00:00";
        var createTime_endDate = createTime_dateRange[1] + " 23:59:59";
		
        jQuery(grid_selector).jqGrid({
            datatype: "json",
            mtype: "post",
            url: "<c:url value='/json/bestvLog_authLogList.do'/>",
            postData: {
            	id	: id_,
            	type	: type_,
            	code : code_,
            	result : result_,
            	createTime_beginTime : createTime_startDate,
            	createTime_endTime	: createTime_endDate,
            },
            height: 560,
            colNames:[
                'ID',
                '<fmt:message key="bestv.content.type"/>',
                '<fmt:message key="bestv.content.code"/>',
                '<fmt:message key="bestv.content.result"/>',
                '<fmt:message key="bestv.content.operate.time.MS"/>',
                '<fmt:message key="bestv.content.operate.req"/>',
                '<fmt:message key="bestv.content.operate.resp"/>',
                '<fmt:message key="bestv.content.create.time"/>',
            ],
            colModel:[
                {name:'id',index:'id', width : 100, align:'center', hidden:false},
                {name : 'type', index : 'type', width : 120, align:'center', sortable : false, formatter: typeFmt, unformat: typeUnFmt},
                {name : 'code', index : 'code', width : 120, align:'center', sortable : false},
                {name : 'result', index : 'result', width : 100, align:'center', sortable : false, formatter: resultFmt, unformat: resultUnFmt},
                {name : 'operateTimeMS', index : 'operateTimeMS', width : 100, align:'center', sortable : false},
                {name : 'reqText', index : 'reqText', width : 200, align:'center', sortable : false},
                {name : 'resText', index : 'resText', width : 100, align:'center', sortable : false},
                {name : 'createTime', index : 'createTime', width : 200, align:'center', sortable : true, formatter:"date", formatoptions: {srcformat:'Y-m-d H:i:s',newformat:'Y-m-d H:i:s'}},
            ],
            //shrinkToFit : false,
            hidegrid : false,
            viewrecords : true,
            rowNum:20,
            rowList:[10,20,30,50,100],
            pager : pager_selector,
            altRows : true,
            jsonReader : {
                total : 'pageCount',
                records : 'records',
                root : 'rows',
                repeatitems : true
            },
            caption: '<fmt:message key="logs.record.list" />',
            loadComplete : function(data) {
                var table = this;
                setTimeout(function(){
                    styleCheckbox(table);

                    updateActionIcons(table);
                    updatePagerIcons(table);
                    enableTooltips(table);
                }, 0);
            }

        });
        $(window).triggerHandler('resize.jqGrid');//trigger window resize to make the grid get the correct size

        //navButtons
        jQuery(grid_selector).jqGrid('navGrid',pager_selector,
            { 	//navbar options
                edit: false,
                editicon : 'ace-icon fa fa-pencil blue',
                add: false,
                addicon : 'ace-icon fa fa-plus-circle purple',
                del: false,
                delicon : 'ace-icon fa fa-trash-o red',
                search: false,
                searchicon : 'ace-icon fa fa-search orange',
                refresh: true,
                refreshicon : 'ace-icon fa fa-refresh green',
                view: false,
                viewicon : 'ace-icon fa fa-search-plus grey',
            }
        )

        //it causes some flicker when reloading or navigating grid
        //it may be possible to have some custom formatter to do this as the grid is being created to prevent this
        //or go back to default browser checkbox styles for the grid
        function styleCheckbox(table) {
            /**
             $(table).find('input:checkbox').addClass('ace')
             .wrap('<label />')
             .after('<span class="lbl align-top" />')


             $('.ui-jqgrid-labels th[id*="_cb"]:first-child')
             .find('input.cbox[type=checkbox]').addClass('ace')
             .wrap('<label />').after('<span class="lbl align-top" />');
             */
        }


        //unlike navButtons icons, action icons in rows seem to be hard-coded
        //you can change them like this in here if you want
        function updateActionIcons(table) {
            /**
             var replacement =
             {
                 'ui-ace-icon fa fa-pencil' : 'ace-icon fa fa-pencil blue',
                 'ui-ace-icon fa fa-trash-o' : 'ace-icon fa fa-trash-o red',
                 'ui-icon-disk' : 'ace-icon fa fa-check green',
                 'ui-icon-cancel' : 'ace-icon fa fa-times red'
             };
             $(table).find('.ui-pg-div span.ui-icon').each(function(){
						var icon = $(this);
						var $class = $.trim(icon.attr('class').replace('ui-icon', ''));
						if($class in replacement) icon.attr('class', 'ui-icon '+replacement[$class]);
					})
             */
        }

        //replace icons with FontAwesome icons like above
        function updatePagerIcons(table) {
            var replacement =
                {
                    'ui-icon-seek-first' : 'ace-icon fa fa-angle-double-left bigger-140',
                    'ui-icon-seek-prev' : 'ace-icon fa fa-angle-left bigger-140',
                    'ui-icon-seek-next' : 'ace-icon fa fa-angle-right bigger-140',
                    'ui-icon-seek-end' : 'ace-icon fa fa-angle-double-right bigger-140'
                };
            $('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon').each(function(){
                var icon = $(this);
                var $class = $.trim(icon.attr('class').replace('ui-icon', ''));

                if($class in replacement) icon.attr('class', 'ui-icon '+replacement[$class]);
            })
        }

        function enableTooltips(table) {
            $('.navtable .ui-pg-button').tooltip({container:'body'});
            $(table).find('.ui-pg-div').tooltip({container:'body'});
        }

        $(document).one('ajaxloadstart.page', function(e) {
            $.jgrid.gridDestroy(grid_selector);
            $('.ui-jqdialog').remove();
        });
	
        function resultFmt(cellvalue, options, rowObject){
        	switch(cellvalue+""){
        	case "${resultFalure}":
        		return '<fmt:message key="business.auth.logs.show.falure"/>';
        	case "${resultSuccess}":
        		return '<fmt:message key="business.auth.logs.show.success"/>';
           	default:
           		return cellvalue;
        	}
        }
        function resultUnFmt(cellvalue, options, rowObject){
        	switch(cellvalue+""){
        	case "<fmt:message key='business.auth.logs.show.falure'/>":
        		return '${resultFalure}';
        	case "<fmt:message key='business.auth.logs.show.success'/>":
        		return '${resultSuccess}';
           	default:
           		return cellvalue;
        	}
        }
        
        function typeFmt(cellvalue, options, rowObject){
        	switch(cellvalue+""){
        	case "${type1}":
        		return '<fmt:message key="bestv.log.type.1"/>';
        	case "${type2}":
    			return '<fmt:message key="bestv.log.type.2"/>';
       		default:
       			return cellvalue;
        	}
        }
		function typeUnFmt(cellvalue, options, rowObject){
			switch(cellvalue+""){
			case '<fmt:message key="bestv.log.type.1"/>':
				return '${type1}';
			case '<fmt:message key="bestv.log.type.2"/>':
				return '${type2}';
       		default:
       			return cellvalue;
			}
		}
        
        $("#search").on("click", function () {
        	prepareParams();
            $("#grid-table").jqGrid('setGridParam', {
                url : "<c:url value='/json/bestvLog_authLogList.do'/>",
                postData : {
                	id	: id_,
                	type	: type_,
                	code : code_,
                	result : result_,
                	createTime_beginTime : createTime_startDate,
                	createTime_endTime	: createTime_endDate,
                },
                page : 1,
                datatype: "json",
                mtype : "post"
            }).trigger("reloadGrid"); //重新载入
        })
        function prepareParams(){
    		id_ = $('#id').val();
    		type_ = $('#type').val();
    		code_ = $('#code').val();
    		result_ = $('#result').val();
    		
            if($('#createTime').val() == ""){
            	createTime_startDate = "";
            	createTime_endDate = "";
            } else{
                createTime_dateRange = $('#createTime').val().replace(/\s/g, "").split("至");
                createTime_startDate = createTime_dateRange[0] + " 00:00:00";
                createTime_endDate = createTime_dateRange[1] + " 23:59:59";
            }
        }
    });
</script>
