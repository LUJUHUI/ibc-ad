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
            <fmt:message key="ad.material"/>
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
            <label class="control-label" for="materialName">素材名称</label>
            <input type="text" class="form-control input-sm" style="width: 80px;margin-left: 5px;" id="materialName">

            <label class="control-label" for="type">素材类型</label>
            <select class="form-control input-sm" style="margin-left: 5px;" id="type">
                <option value="">全部</option>
                <option value="201">图片</option>
                <option value="202">文字</option>
            </select>

            <label class="control-label" for="status">素材状态</label>
            <select class="form-control input-sm" id="status" style="margin-left: 5px;">
                <option value="">全部</option>
                <option value="101">待审核</option>
                <option value="103">审核失败</option>
                <option value="104">待使用</option>
                <option value="105">使用中</option>
                <option value="106">已删除</option>
                <c:forEach var="status" items="${pubStatus}">
                    <option value="${status.key}">${status.value}</option>
                </c:forEach>
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
    <!-- /.page-header -->
    <div class="row">
        <div class="col-xs-12">
            <table id="grid-table"></table>
            <div id="grid-pager"></div>
        </div>
    </div>

</div>

<script type="text/javascript">

    jQuery(function ($) {
        var grid_selector = "#grid-table";
        var pager_selector = "#grid-pager";

        var parent_column = $(grid_selector).closest('[class*="col-"]');
        //resize to fit page size
        $(window).on('resize.jqGrid', function () {
            $(grid_selector).jqGrid('setGridWidth', parent_column.width());
        })

        //resize on sidebar collapse/expand
        $(document).on('settings.ace.jqGrid', function (ev, event_name, collapsed) {
            if (event_name === 'sidebar_collapsed' || event_name === 'main_container_fixed') {
                //setTimeout is for webkit only to give time for DOM changes and then redraw!!!
                setTimeout(function () {
                    $(grid_selector).jqGrid('setGridWidth', parent_column.width());
                }, 20);
            }
        })

        $('#createTime').daterangepicker({
            "ableToNull": true,
            "showDropdowns": true,
            "showCustomRangeLabel": false,
            "alwaysShowCalendars": true,
            "startDate": moment().subtract('days', 29),
            "endDate": moment().subtract('days', -1),
            "opens": "left",
            "drops": "down"
        }, function (start, end, label) {//时间改变后执行该方法
            //alert(label);
        });

        var dateRange = $('#createTime').val().replace(/\s/g, "").split("至");
        var startDate = dateRange[0];
        var endDate = dateRange[1];
        jQuery(grid_selector).jqGrid({
            datatype: "json",
            mtype: "post",
            url: "<c:url value='/json/adMaterial_getAdMaterials.do'/>",
            postData: {
                materialName: $("#materialName").val(),
                type: $("#type").val(),
                status: $("#status").val(),
                beginDate: startDate + " 00:00:00",
                endDate: endDate + " 23:59:59"
            },
            height: 560,
            colNames: [
                '<fmt:message key="ad.material.id"/>',
                '<fmt:message key="ad.material.materialName"/>',
                '<fmt:message key="ad.material.type"/>',
                '<fmt:message key="ad.material.clickHref"/>',
                '<fmt:message key="ad.material.status"/>',
                '<fmt:message key="ad.material.createTime"/>',
                '<fmt:message key="ad.material.createPerson"/>',
                '<fmt:message key="ad.material.updateTime"/>',
                '<fmt:message key="ad.material.updatePreson"/>'
            ],
            colModel: [
                {name: 'id', index: 'id', width: 80, align: 'center', sortable: true, hidden: true},
                {name: 'materialName', index: 'materialName', width: 300, align: 'center', sortable: true},
                {name: 'type', index: 'type', width: 270, align: 'center', sortable: true, formatter: typeFmt},
                {name: 'clickHref', index: 'clickHref', width: 280, align: 'center', sortable: true},
                {
                    name: 'status',
                    index: 'status',
                    width: 108,
                    align: 'center',
                    sortable: false,
                    formatter: statusFmt,
                    unformat: unFmtStatus
                },
                {
                    name: 'createTime',
                    index: 'createTime',
                    width: 200,
                    align: 'center',
                    sortable: true,
                    formatter: "date",
                    formatoptions: {srcformat: 'Y-m-d H:i:s', newformat: 'Y-m-d H:i:s'}
                },
                {name: 'createPerson', index: 'createPerson', width: 100, align: 'center', sortable: true},
                {
                    name: 'updateTime',
                    index: 'updateTime',
                    width: 200,
                    align: 'center',
                    sortable: true,
                    formatter: "date",
                    formatoptions: {srcformat: 'Y-m-d H:i:s', newformat: 'Y-m-d H:i:s'}
                },
                {name: 'updatePerson', index: 'updatePerson', width: 100, align: 'center', sortable: true},
            ],
            shrinkToFit: false,
            hidegrid: false,
            viewrecords: true,
            rowNum: 20,
            rowList: [10, 20, 30],
            pager: pager_selector,
            altRows: true,
            multiselect: true,
            multiboxonly: true,
            jsonReader: {
                total: 'pageCount',
                records: 'records',
                root: 'rows',
                repeatitems: true
            },
            caption: '<fmt:message key="ad.material.list" />',
            toolbar: [true, 'top'],
            loadComplete: function (data) {
                var table = this;
                setTimeout(function () {
                    styleCheckbox(table);
                    updateActionIcons(table);
                    updatePagerIcons(table);
                    enableTooltips(table);
                }, 0);
            }
        });

        $("#t_grid-table").append('<table cellspacing="0" cellpadding="0" border="0" style="float:left;table-layout:auto;margin-top:7px" class="topnavtable"><tr>' +
            '<td><button type="button" id="adm_create" class="btn btn-xs btn-success"><i class="ace-icon fa fa-paper-plane-o"></i>创建</button></td>' +
            '<td>|</td>' +
            '<td><button type="button" id="adm_update" class="btn btn-xs btn-success"><i class="ace-icon glyphicon glyphicon-wrench"></i>修改</button></td>' +
            '<td>|</td>' +
            '<td><button type="button" id="adm_delete" class="btn btn-xs btn-danger"><i class="ace-icon  glyphicon glyphicon-remove"></i>删除</button></td>' +
            '</tr></table>');

        $(window).triggerHandler('resize.jqGrid');//trigger window resize to make the grid get the correct size

        //navButtons
        jQuery(grid_selector).jqGrid('navGrid', pager_selector,
            { 	//navbar options
                edit: false,
                editicon: 'ace-icon fa fa-pencil blue',
                add: false,
                addicon: 'ace-icon fa fa-plus-circle purple',
                del: false,
                delicon: 'ace-icon fa fa-trash-o red',
                search: false,
                searchicon: 'ace-icon fa fa-search orange',
                refresh: true,
                refreshicon: 'ace-icon fa fa-refresh green',
                view: false,
                viewicon: 'ace-icon fa fa-search-plus grey',
            }
        )

        function styleCheckbox(table) {

        }

        function updateActionIcons(table) {

        }

        function updatePagerIcons(table) {
            var replacement =
                {
                    'ui-icon-seek-first': 'ace-icon fa fa-angle-double-left bigger-140',
                    'ui-icon-seek-prev': 'ace-icon fa fa-angle-left bigger-140',
                    'ui-icon-seek-next': 'ace-icon fa fa-angle-right bigger-140',
                    'ui-icon-seek-end': 'ace-icon fa fa-angle-double-right bigger-140'
                };
            $('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon').each(function () {
                var icon = $(this);
                var $class = $.trim(icon.attr('class').replace('ui-icon', ''));
                if ($class in replacement) icon.attr('class', 'ui-icon ' + replacement[$class]);
            })
        }

        function enableTooltips(table) {
            $('.navtable .ui-pg-button').tooltip({container: 'body'});
            $(table).find('.ui-pg-div').tooltip({container: 'body'});
        }

        $(document).one('ajaxloadstart.page', function (e) {
            $.jgrid.gridDestroy(grid_selector);
            $('.ui-jqdialog').remove();
        });

        function typeFmt(cellvalue, options, rowObject) {
            var result = "";
            switch (cellvalue) {
                case 201:
                    result = '图片';
                    break;
                case 202:
                    result = '文字';
                    break;
            }
            return result;
        }

        function change() {
            document.getElementById("sel")[1].selected = true;
        }

        function statusFmt(cellvalue, options, rowObject) {
            var result = "";
            switch (cellvalue) {
                case 101:
                    result = '<span class="green">待审核</span>';
                    break;
                case 103:
                    result = '<span class="red">审核驳回</span>';
                    break;
                case 104:
                    result = '<span class="orange">待使用</span>';
                    break;
                case 105:
                    result = '<span class="green">使用中</span>';
                    break;
                case 106:
                    result = '<span class="red">已删除</span>';
                    break;
            }
            return result;
        }

        /*实现状态功能的比对*/
        function unFmtStatus(callValue) {
            return callValue;
        }

        /*实现重置按钮的功能*/
        $("#reset").on("click", function () {
            $('#materialName').val("");
            $('#type').val("");
            $('#status').val("");
            search();
        });
        $("#search").on("click", function () {
        	search();
        })
        function search() {
            dateRange = $('#createTime').val().replace(/\s/g, "").split("至");
            startDate = dateRange[0];
            endDate = dateRange[1];
            $("#grid-table").jqGrid('setGridParam', {
                url: "<c:url value='/json/adMaterial_getAdMaterials.do'/>",
                postData: {
                    materialName: $("#materialName").val(),
                    type: $("#type").val(),
                    status: $("#status").val(),
                    beginDate: startDate + " 00:00:00",
                    endDate: endDate + " 23:59:59"
                },
                page: 1,
                datatype: "json",
                mtype: "post"
            }).trigger("reloadGrid"); //重新载入
        } 

        $("#adm_create").on("click",function () {
            openMainPage('<c:url value="/pages/admaterial/addMaterial.jsp"/>', {}, function () {});
        });
        
        $("#adm_update").on("click", function () {
            var row = $("#grid-table").jqGrid('getGridParam', 'selarrrow');

            if (row.length == 0) {
                bootbox.alert("请选择要操作的记录！");
                return;
            }
            if (row.length > 1) {
                bootbox.alert("最多选择一条记录！");
                return;
            }
            var rowdDta = $("#grid-table").jqGrid('getRowData', row);
            if(rowdDta.status == "使用中"){
            	 bootbox.alert("使用中的素材不能修改！");
            }else{
            	 openMainPage('<c:url value="/pages/admaterial/editMaterial.jsp"/>', {"id": rowdDta.id}, function () {});
            }
        })
        
        $("#adm_delete").on("click", deleteAdMaterial);
        function deleteAdMaterial() {
            var ids = $("#grid-table").jqGrid('getGridParam', 'selarrrow');
            if (ids.length == 0) {
                bootbox.alert("请选择要操作的记录！");
                return;
            }
            var codes = [];
            var del = true;
            for (var index in ids) {
                var rowData = $("#grid-table").jqGrid('getRowData', ids[index]);
                if (rowData.status == "待审核" || rowData.status == "审核驳回") {
                    codes.push(rowData.id);
                } else {
                    bootbox.alert("请选择:审核失败或待审核状态的素材，进行删除操作！");
                    del = false;
                }
            }
            var codeStr = '';
            for (var index in codes) {
                codeStr = codeStr + codes[index] + ',';
            }
            if(codes.length > 0 && del == true){
            bootbox.confirm("确定删除？",function(re){
            if(re) {
            $.post('<c:url value="/json/adMaterial_deleteAdMaterial.do"/>',
                {"materialIds": codeStr.substring(0, codeStr.length - 1)}, function (result) {
                    /*bootbox.alert("操作成功！");*/
                    $("#search").trigger('click');
                });
                }
            })
            }
        }
    });
</script>


