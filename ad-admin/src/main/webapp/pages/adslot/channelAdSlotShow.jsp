<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp" %>
<%@page import="com.wondertek.mobilevideo.gke.ad.BcConstants"%>
<%@ page import="com.wondertek.mobilevideo.gke.ad.core.model.DataDict" %>

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
            <fmt:message key="ad.slot"/>
        </li> 
        <li class="active">
            <span><fmt:message key="channel.slot.content.show"/></span>
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
            <label class="control-label" for="code">广告位名称</label>
            <input type="text" class="form-control input-sm" style="width: 80px;margin-left: 5px;" id="code">

            <label class="control-label" for="attr">导航名称</label>
            <select class="form-control input-sm" style="margin-left: 5px;" id="attr">
                <option value="">全部</option>
                <option value="1">首页</option>
                <option value="2">直播</option>
                <option value="3">会员</option>
            </select>
			
			<label class="control-label" for="attr">状态</label>
            <select class="form-control input-sm" style="margin-left: 5px;" id="attr">
                <option value="">全部</option>
                <option value="1">正常</option>
                <option value="2">禁用</option>
            </select>
            <label class="control-label" for="createTime">创建时间</label>
            <input class="form-control input-sm" style="width: 200px;" type="text" id="createTime"/>

            <button type="button" class="btn btn-info btn-sm" style="margin-left: 20px;" id="search">
                <i class="ace-icon fa fa-search bigger-110"></i><fmt:message key="icon-search"/>
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

        var dateRange = $('#createTime').val().replace(/\s/g, "").split("至");
        var startDate = dateRange[0];
        var endDate = dateRange[1];

        jQuery(grid_selector).jqGrid({
            datatype: "json",
            mtype: "post",
            url: "<c:url value='/json/bestvContent_beanList.do'/>",
            postData: {
                code: $("#code").val(),
                attr: $("#attr").val(),
                title: $("#title").val(),
                searchName: $("#searchName").val(),
                status: $("#status").val(),
                pcId: $("#pcId").val(),
                cId: $("#cId").val(),
                beginDate: startDate,
                endDate: endDate
            },
            height: 560,
            colNames:[ 
                '<fmt:message key="ad.slot.id"/>',                      
                '<fmt:message key="ad.slot.name"/>',
                '<fmt:message key="ad.slot.navig"/>',
                '<fmt:message key="ad.slot.channel.id"/>',
                '<fmt:message key="ad.slot.type"/>',
                '<fmt:message key="ad.slot.width"/>',
                '<fmt:message key="ad.slot.height"/>',
                '<fmt:message key="ad.slot.status"/>',
                '<fmt:message key="ad.slot.createTime"/>',
                '<fmt:message key="ad.slot.creater"/>',
                '<fmt:message key="ad.slot.updateTime"/>',
                '<fmt:message key="ad.slot.updater"/>',
                '<fmt:message key="ad.slot.remark"/>',
            ],
            colModel:[
                {name :' id ', index:'id', width : 100, align:'center',hidden:true},
                {name : 'slotName', index : 'slot_name', width : 100, align:'center', sortable : false},
                {name : 'navig', index : 'navig', width : 100, align:'center', sortable : false},
                {name : 'channelId', index : 'channel_id', width : 300, align:'center', sortable : false},
                {name : 'type', index : 'type_', width : 150, align:'center', sortable : false},
                {name : 'width', index : 'width_', width : 100, align:'center', sortable : false},
                {name : 'height', index : 'height_', width : 150, align:'center', sortable : false},
                {name : 'status', index : 'status_', width : 120, align:'center', sortable : false},
                {name : 'createTime', index : 'create_time', width : 250, align:'center', sortable : false},
                {name : 'createrId', index : 'create_id', width : 100, align:'center', sortable : false},
                {name : 'updateTime', index : 'update_time', width : 100, align:'center', sortable : false},
                {name : 'updateId', index : 'update_id', width : 100, align:'center', sortable : false},
                {name : 'remark', index : 'remark_', width : 150, align:'center', sortable : false},
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
            caption: '<fmt:message key="channel.slot.content.list" />',
            <cas:havePerm url="/bestvContent_loadDetailPage.do">
                ondblClickRow : function (rowid, iRow, iCol, e) {
                },
            </cas:havePerm>
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

        $("#t_grid-table").append('<table cellspacing="0" cellpadding="0" border="0" style="float:left;table-layout:auto;margin-top:7px" class="topnavtable"><tr>' +
            
        
            '<td><button type="button" id="online" class="glyphicon glyphicon-plus"><i class="ace-icon fa fa-cloud-upload"></i>增加</button></td>' +
            '<td>|</td>' +
            '<td><button type="button" id="online" class="glyphicon glyphicon-edit"><i class="ace-icon fa fa-cloud-upload"></i>修改</button></td>' +
            '<td>|</td>' +
            '<td><button type="button" id="offline" class="glyphicon glyphicon-minus"><i class="ace-icon fa fa-cloud-download"></i>删除</button></td>' +
            '</tr></table>');

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

        function attrFmt(cellvalue, options, rowObject){
            return cellvalue == '1' ? '单片' : '连续剧';
        }

        function attrUnFmt(cellvalue, options, rowObject) {
            return cellvalue == "单片" ? "1" : "2";
        }

        $("#search").on("click", function () {

            if($('#createTime').val() == ""){
                startDate = "";
                endDate = "";
            } else{
                dateRange = $('#createTime').val().replace(/\s/g, "").split("至");
                startDate = dateRange[0];
                endDate = dateRange[1];
            }

            $("#grid-table").jqGrid('setGridParam', {
                url : "<c:url value='/json/bestvContent_beanList.do'/>",
                postData : {
                    code: $("#code").val(),
                    attr: $("#attr").val(),
                    title: $("#title").val(),
                    searchName: $("#searchName").val(),
                    status: $("#status").val(),
                    pcId: $("#pcId").val(),
                    cId: $("#cId").val(),
                    beginDate: startDate,
                    endDate: endDate
                },
                page : 1,
                datatype: "json",
                mtype : "post"
            }).trigger("reloadGrid"); //重新载入
        })
        
        $("#pcId").on("change", function () {
            if ($("#pcId").val() == ""){
                $("#cId").html('').attr("disabled", true);
            }else {
                $.get('<c:url value="/json/bestvContent_cascade.do"/>', {"pcId": $("#pcId").val()}, function (data) {
                    var optionHtml = '<option value="">全部</option>';
                    for (var i in data.result){
                        optionHtml = optionHtml + '<option value="'+ i +'">' + data.result[i] + '</option>';
                    }
                    $("#cId").html(optionHtml).removeAttr("disabled");
                })
            }
        })

        $("#online, #offline").on("click", onOrOffLine);

        function onOrOffLine(){
            var actionType = $(this).attr("id") == 'online' ? '1' : '2';//上线为1，下线为2
            var status1;//上线为102，下线为105
            var status2;//上线为200，下线为107
            if (actionType == '1'){
                status1 = '102';
                status2 = '105';
            }else {
                status1 = '200';
                status2 = '107';
            }
            var ids = $("#grid-table").jqGrid('getGridParam', 'selarrrow');
            if (ids.length == 0){
                bootbox.alert("请选择要操作的记录！");
                return;
            }
            var codes = [];
            for (var index in ids){
                var rowData = $("#grid-table").jqGrid('getRowData', ids[index]);
                if (rowData.status == status1 || rowData.status == status2)
                    continue;
                codes.push(rowData.code);
            }
            if (codes.length < 1){
                bootbox.alert("没有选择有效记录！");
                return;
            }
            var codeStr = '';
            for (var index in codes){
                codeStr =codeStr + codes[index] + ',';
            }
            $.post('<c:url value="/json/bestvContent_onOrOffLine.do"/>', {"codes": codeStr.substring(0, codeStr.length-1), "actionType": actionType}, function (result) {
                bootbox.alert("操作成功！");
                $("#search").trigger('click');
            });
        }
    });
</script>
