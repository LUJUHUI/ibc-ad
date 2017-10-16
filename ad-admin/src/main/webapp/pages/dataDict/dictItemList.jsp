<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp" %>

<style>
    .widget-toolbar {
        display: inline-block;
        padding: 0 10px;
        line-height: 37px;
        float: left;
        position: relative;
    }
    #grid-pager-1_left {
        width: inherit!important;
    }
</style>
<div class="row" style="height: 460px;">
    <div class="col-xs-12 widget-container-col ui-sortable">
        <div class="widget-box ui-sortable-handle">
            <div class="widget-header">
                <div class="widget-toolbar no-border">
                    <form class="form-inline">
                        <label class="control-label" for="type1"><fmt:message key="data.dict.type"/> </label>
                        <input type="text" class="form-control input-sm" style="width: 100px;margin-left: 5px;" value="${type}" id="type1" readonly>

                        <label class="control-label" for="typeDesc1"><fmt:message key="data.dict.type.desc"/> </label>
                        <input type="text" class="form-control input-sm" style="width: 100px;margin-left: 5px;" value="${typeDesc}" id="typeDesc1" readonly>

                    </form>
                </div>
            </div>

            <div class="widget-body" id="widget-table">
                <div class="widget-main padding-6">
                    <table id="grid-table-1"></table>
                    <div id="grid-pager-1"></div>
                </div>
            </div>
        </div>
    </div>
</div>


<script>
    jQuery(function($) {
        var grid_selector_1 = "#grid-table-1";
        var pager_selector_1 = "#grid-pager-1";

        //var parent_column = $(grid_selector).closest('[class*="col-"]');

        //resize to fit page size
        $(window).on('resize.jqGrid', function () {
            $(grid_selector_1).jqGrid( 'setGridWidth', $("#widget-table").width()-10);
        })

        //resize on sidebar collapse/expand
        $(document).on('settings.ace.jqGrid' , function(ev, event_name, collapsed) {
            if( event_name === 'sidebar_collapsed' || event_name === 'main_container_fixed' ) {
                //setTimeout is for webkit only to give time for DOM changes and then redraw!!!
                setTimeout(function() {
                    $(grid_selector_1).jqGrid( 'setGridWidth', $("#widget-table").width()-10);
                }, 20);
            }
        })

        jQuery(grid_selector_1).jqGrid({
            datatype: "json",
            mtype: "post",
            url: "<c:url value='/json/dataDict_dictItemList.do'/>",
            postData: {
                type: $("#type1").val(),
                typeDesc: $("#typeDesc1").val()
            },
            height: 300,
            colNames:['ID', 'type', 'typeDesc',
                '<fmt:message key="data.dict.item.value"/>',
                '<fmt:message key="data.dict.item.name"/>',
                '<fmt:message key="data.dict.item.status"/>',
                '<fmt:message key="data.dict.item.update.time"/>'
            ],
            colModel:[
                {
                    name: 'id',
                    index: 'id_',
                    hidden:true
                },
                {
                    name: 'type',
                    index: 'type_',
                    editable: true,
                    hidden:true
                },
                {
                    name: 'typeDesc',
                    index: 'type_desc',
                    editable: true,
                    hidden:true
                },
                {
                    name: 'value',
                    index: 'value_',
                    width : 60,
                    align: 'center',
                    editable: true,
                    editrules:{
                        required:true
                    }
                },
                {
                    name: 'name',
                    index: 'name_',
                    width : 120,
                    align: 'center',
                    editable: true,
                    editrules:{
                        required:true
                    }
                },
                {
                    name: 'status',
                    index: 'status_',
                    width : 60,
                    align:'center',
                    formatter: statusFmt,
                    unformat: statusUnfmt,
                    editable: true,
                    editrules:{
                        required:true
                    },
                    edittype:"select",
                    editoptions: {value:'1:启用;0:禁用'},
                },
                {
                    name: 'updateTime',
                    index: 'update_time',
                    width : 150,
                    align:'center',
                    sortable : true,
                    formatter:"date",
                    formatoptions: {
                        srcformat:'Y-m-d H:i:s',
                        newformat:'Y-m-d H:i:s'
                    }
                }
            ],
            sortname: 'update_time',
            sortorder: 'desc',
            viewrecords : true,
            rowNum:10,
            rowList:[10,20,30],
            pager : pager_selector_1,
            altRows: true,
            multiselect: true,
            multiboxonly: true,
            jsonReader : {
                total : 'pageCount',
                records : 'records',
                root : 'rows',
                repeatitems : true
            },
            editurl : "<c:url value='/json/dataDict_itemEdit.do'/>",
            loadComplete : function() {
                var table = this;
                setTimeout(function(){
                    styleCheckbox(table);

                    updateActionIcons(table);
                    updatePagerIcons(table);
                    enableTooltips(table);
                }, 0);
            },
        });
        $(window).triggerHandler('resize.jqGrid');//trigger window resize to make the grid get the correct size

        //navButtons
        jQuery(grid_selector_1).jqGrid('navGrid',pager_selector_1,
            {   //navbar options
                edit: true,
                editicon : 'ace-icon fa fa-pencil blue',
                add: true,
                addicon : 'ace-icon fa fa-plus-circle purple',
                del: true,
                delicon : 'ace-icon fa fa-trash-o red',
                search: false,
                searchicon : 'ace-icon fa fa-search orange',
                refresh: true,
                refreshicon : 'ace-icon fa fa-refresh green',
                view: false,
                viewicon : 'ace-icon fa fa-search-plus grey',
            },
            {
                //edit record form
                closeAfterEdit: true,
                recreateForm: true,
                top:260,
                left:700,
                beforeShowForm : function(e) {
                    var form = $(e[0]);
                    form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
                    style_edit_form(form);
                },
                afterComplete:function(xhr){
                    var data = eval("("+xhr.responseText+")");
                    if(data.result == "success"){
                        bootbox.alert("修改成功！");
                    }else if(data.result == "samekey"){
                        bootbox.alert("枚举值键重复，请重新修改！");
                    }else{
                        bootbox.alert("修改失败！");
                    };
                }
            },
            {
                //new record form
                //width: 700,
                top:300,
                left:800,
                closeAfterAdd: true,
                recreateForm: true,
                viewPagerButtons: false,
                beforeShowForm : function(e) {
                    $(".FormData #typeDesc").val($("#typeDesc1").val());
                    $(".FormData #type").val($("#type1").val());
                    var form = $(e[0]);
                    form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar')
                        .wrapInner('<div class="widget-header" />')
                    style_edit_form(form);
                },
                afterComplete:function(xhr){
                    var data = eval("("+xhr.responseText+")");
                    if(data.result == "success"){
                        bootbox.alert("添加成功！");
                    }else if(data.result == "samekey"){
                        bootbox.alert("枚举值键重复，请重新添加！");
                    }else{
                        bootbox.alert("添加失败！");
                    };
                }
            },
            {
                //delete record form
                top:300,
                left:800,
                recreateForm: true,
                beforeShowForm : function(e) {
                    var form = $(e[0]);
                    if(form.data('styled')) return false;

                    form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
                    style_delete_form(form);

                    form.data('styled', true);
                },
                onClick : function(e) {
                    //alert(1);
                }
            },
            {
                //search form
                recreateForm: true,
                afterShowSearch: function(e){
                    var form = $(e[0]);
                    form.closest('.ui-jqdialog').find('.ui-jqdialog-title').wrap('<div class="widget-header" />')
                    style_search_form(form);
                },
                afterRedraw: function(){
                    style_search_filters($(this));
                }
                ,
                multipleSearch: true,
                /**
                 multipleGroup:true,
                 showQuery: true
                 */
            },
            {
                //view record form
                recreateForm: true,
                beforeShowForm: function(e){
                    var form = $(e[0]);
                    form.closest('.ui-jqdialog').find('.ui-jqdialog-title').wrap('<div class="widget-header" />')
                }
            }
        )



        function style_edit_form(form) {

            //form.find('input[name=status]').addClass('ace ace-switch ace-switch-5').after('<span class="lbl"></span>');


            //update buttons classes
            var buttons = form.next().find('.EditButton .fm-button');
            buttons.addClass('btn btn-sm').find('[class*="-icon"]').hide();//ui-icon, s-icon
            buttons.eq(0).addClass('btn-primary').prepend('<i class="ace-icon fa fa-check"></i>');
            buttons.eq(1).prepend('<i class="ace-icon fa fa-times"></i>')

            buttons = form.next().find('.navButton a');
            buttons.find('.ui-icon').hide();
            buttons.eq(0).append('<i class="ace-icon fa fa-chevron-left"></i>');
            buttons.eq(1).append('<i class="ace-icon fa fa-chevron-right"></i>');
        }

        function style_delete_form(form) {
            var buttons = form.next().find('.EditButton .fm-button');
            buttons.addClass('btn btn-sm btn-white btn-round').find('[class*="-icon"]').hide();//ui-icon, s-icon
            buttons.eq(0).addClass('btn-danger').prepend('<i class="ace-icon fa fa-trash-o"></i>');
            buttons.eq(1).addClass('btn-default').prepend('<i class="ace-icon fa fa-times"></i>')
        }

        function style_search_filters(form) {
            form.find('.delete-rule').val('X');
            form.find('.add-rule').addClass('btn btn-xs btn-primary');
            form.find('.add-group').addClass('btn btn-xs btn-success');
            form.find('.delete-group').addClass('btn btn-xs btn-danger');
        }
        function style_search_form(form) {
            var dialog = form.closest('.ui-jqdialog');
            var buttons = dialog.find('.EditTable')
            buttons.find('.EditButton a[id*="_reset"]').addClass('btn btn-sm btn-info').find('.ui-icon').attr('class', 'ace-icon fa fa-retweet');
            buttons.find('.EditButton a[id*="_query"]').addClass('btn btn-sm btn-inverse').find('.ui-icon').attr('class', 'ace-icon fa fa-comment-o');
            buttons.find('.EditButton a[id*="_search"]').addClass('btn btn-sm btn-purple').find('.ui-icon').attr('class', 'ace-icon fa fa-search');
        }

        function beforeDeleteCallback(e) {
            var form = $(e[0]);
            if(form.data('styled')) return false;

            form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
            style_delete_form(form);

            form.data('styled', true);
        }

        function beforeEditCallback(e) {
            var form = $(e[0]);
            form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
            style_edit_form(form);
        }



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

        //var selr = jQuery(grid_selector).jqGrid('getGridParam','selrow');

        $(document).one('ajaxloadstart.page', function(e) {
            $.jgrid.gridDestroy(grid_selector_1);
            $('.ui-jqdialog').remove();
        });

        function statusFmt(cellvalue, options, rowObject){
            return cellvalue == '1' ? '启用' : '禁用';
        }

        function statusUnfmt(cellvalue, options, rowObject) {
            return cellvalue == "启用" ? "1" : "0";
        }

    })
</script>