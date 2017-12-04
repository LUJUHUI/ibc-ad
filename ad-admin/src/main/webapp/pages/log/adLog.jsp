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
            <fmt:message key="ad.log"/>
        </li> 
        <li class="active">
            <span><fmt:message key="ad.log.check"/></span>
        </li>
    </ul>
    <!-- /.breadcrumb -->
</div>

<style type="text/css">
    .ui-jqgrid .ui-jqgrid-bdiv {
        overflow: auto;
    }
    .ui-jqgrid .ui-userdata {
        border-left: 1px solid #D3D3D3;
        border-right: 1px solid #D3D3D3;
        height: 44px;
        overflow: hidden;
    }
    .ui-jqgrid .topnavtable td {
        font-weight: 400;
        vertical-align: middle;
        padding: 0 8px;
    }
</style>

<div class="page-content">
    <div class="page-header">
        <form class="form-inline">
            <label class="control-label" for="code">日志ID</label>
            <input type="text" class="form-control input-sm" style="width: 80px;margin-left: 5px;" id="logId">

            <label class="control-label" for="attr">操作类型</label>
            <select class="form-control input-sm" style="margin-left: 5px;" id="operType">
                <option value="">全部</option>
                <option value=301>通过</option>
                <option value=302>驳回</option>
            </select>
			
			<label class="control-label" for="attr">日志类型</label>
            <select class="form-control input-sm" style="margin-left: 5px;" id="logType">
                <option value="">全部</option>
                <option value=401>广告素材</option>
                <option value=402>广告位</option>
            </select>
            
			<label class="control-label" for="attr">审核结果</label>
            <select class="form-control input-sm" style="margin-left: 5px;" id="operResult">
                <option value="">全部</option>
                <option value="失败">失败</option>
                <option value="成功">成功</option>
            </select>
            <label class="control-label" for="createTime">创建时间</label>
            <input class="form-control input-sm" style="width: 200px;" type="text" id="createTime"/>
            <button type="button" class="btn btn-info btn-sm" style="margin-left: 20px;" id="search">
                <i class="ace-icon fa fa-search bigger-110"></i><fmt:message key="icon-search"/>
            </button>
			<button type="button" class="btn btn-info btn-sm" style="margin-left: 20px;" id="reset">
                <i class="ace-icon fa fa-reply bigger-110"></i><fmt:message key="icon-reset"/>
            </button>
        </form>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <table id="grid-table"></table>
            <div id="grid-pager"></div>
        </div>
    </div>
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

        var dateRange = $('#createTime').val().replace(/\s/g, "").split("至");
        var startDate = dateRange[0];
        var endDate = dateRange[1];
        jQuery(grid_selector).jqGrid({
            datatype: "json",
            mtype: "post",
            url: "<c:url value='/json/adSlot_listAdLogs.do'/>",
            postData: {
            	logId: $("#logId").val(),
            	operType: $("#operType").val(),
            	operResult: $("#operResult").val(),
            	startDate: startDate + " 00:00:00",
          	    endDate: endDate + " 23:59:59"
                
            },
            height: 560,
            colNames:[ 
                '<fmt:message key="ad.log.id"/>',
                '<fmt:message key="ad.log.type"/>',
                '<fmt:message key="ad.log.operType"/>',
                '<fmt:message key="ad.log.operResult"/>',
                '<fmt:message key="ad.log.creater"/>',
                '<fmt:message key="ad.log.createTime"/>',
            ],
            colModel:[
                {name : 'id', index:'id', width : 100, align:'center',sortable : true },
                {name : 'logType', index : 'logType', width : 200, align:'center', sortable : true,formatter:fmtLogType},
                {name : 'operType', index : 'operType', width : 200, align:'center', sortable : true,formatter:attrOperType}, 
                {name : 'operResult', index : 'operResult', width : 300, align:'center', sortable : true},
                {name : 'operName', index : 'operName', width : 300, align:'center', sortable : true},
                {name : 'createTime', index : 'createTime', width : 250, align:'center', sortable : true,formatter:"date", formatoptions: {srcformat:'Y-m-d H:i:s',newformat:'Y-m-d H:i:s'}},
            ],
            shrinkToFit : false,
            hidegrid : false,
            viewrecords : true,
            rowNum:20,
            rowList:[10,20,30],
            pager : pager_selector,
            altRows : true,
            multiselect: true,
            multiboxonly: true,
            jsonReader : {
                total : 'pageCount',
                records : 'records',
                root : 'rows',
                repeatitems : true
            },
            caption: '<fmt:message key="ad.log.list" />',
            toolbar: [true,'top'],
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
        $("#t_grid-table").addClass("hidden");
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
  		function styleCheckbox(table) {
            
        }

        function updateActionIcons(table) {
            
        }
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

        function attrOperType(callValue) {
            var result="";
            switch (callValue){
                case 301:
                    result =  '<span class="green">审核通过</span>';
                    break;
                case 302:
                    result = '<span class="red">审核驳回</span>';
                    break;
            }
            return result;
        }
        function fmtLogType(callValue) {
            var result="";
            switch (callValue){
                case 401:
                    result='广告素材';
                    break;
                case 402:
                    result = '广告位';
                    break;
            }
            return result;
        }
		
        $("#reset").on("click", function () {
        	$("#logId").val(""),
        	$("#operType").val(""),
        	$("#operResult").val(""), 
        	$("#logType").val(""),
            search();
        })
        $("#search").on("click",search);
        function search(){
            if($('#createTime').val() == ""){
                startDate = "";
                endDate = "";
            } else{
                dateRange = $('#createTime').val().replace(/\s/g, "").split("至");
                startDate = dateRange[0];
                endDate = dateRange[1];
            }

            $("#grid-table").jqGrid('setGridParam', {
            	  url: "<c:url value='/json/adSlot_listAdLogs.do'/>",
                postData : {
                	logId: $("#logId").val(),
                	operType: $("#operType").val(),
                	operResult: $("#operResult").val(),
                	logType: $("#logType").val(),
                	startDate: startDate + " 00:00:00",
              	    endDate: endDate + " 23:59:59"
                },
                page : 1,
                datatype: "json",
                mtype : "post"
            }).trigger("reloadGrid"); //重新载入
        }
 
    });
</script>
