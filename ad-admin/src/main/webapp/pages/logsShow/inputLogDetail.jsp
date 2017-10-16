<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html;charset=utf-8"%>
<%@ include file="/common/taglibs.jsp"%>

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

.img-pre-container {
	margin: 0px 20px 30px 30px;
	background-color: #D0D0D0;
	box-shadow: 0 0 3px #000;
	width: auto;
	height: 320px;
}
</style>

<div class="row" style="height: 750px;">
	<div class="col-xs-12" id="content-detail">
		<form class="form-horizontal" role="form">
			<fieldset>
				<div class="form-group">
					<label class="col-sm-1 control-label" for=id>ID</label>
					<div class="col-sm-4">
						<input class="form-control input-sm" id="id" type="text"
							value="${bestvInputLog.id}" readonly />
					</div>
					<label class="col-sm-2 control-label" for="code"><fmt:message
							key="bestv.content.code" /> </label>
					<div class="col-sm-4">
						<input class="form-control input-sm" id="code" type="text"
							value="${bestvInputLog.code}" readonly />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-1 control-label" for="descInfo"><fmt:message
							key="bestv.log.resutlt.msg" /> </label>
					<div class="col-sm-11">
						<textarea class="form-control" id="descInfo" rows="3"
							style="resize: none;" readonly>${bestvInputLog.resultMsg}</textarea>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-1 control-label" for="descInfo"><fmt:message
							key="bestv.log.message" /> </label>
					<div class="col-sm-11">
						<textarea class="form-control" id="descInfo" rows="5"
							style="resize: none;" readonly>${bestvInputLog.message}</textarea>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-1 control-label" for="descInfo"><fmt:message
							key="bestv.log.message.replay" /> </label>
					<div class="col-sm-11">
						<textarea class="form-control" id="descInfo" rows="5"
							style="resize: none;" readonly>${bestvInputLog.messageRes}</textarea>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-1 control-label" for="descInfo"><fmt:message
							key="bestv.log.result.notify.msg" /> </label>
					<div class="col-sm-11">
						<textarea class="form-control" id="descInfo" rows="5"
							style="resize: none;" readonly>${bestvInputLog.resultNotifyReq}</textarea>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-1 control-label" for="descInfo"><fmt:message
							key="bestv.log.result.notify.result" /> </label>
					<div class="col-sm-11">
						<textarea class="form-control" id="descInfo" rows="5"
							style="resize: none;" readonly>${bestvInputLog.resultNotifyRes}</textarea>
					</div>
				</div>
			</fieldset>
		</form>
	</div>
</div>

<script>
	jQuery(function($) {

		$(window).triggerHandler('resize.jqGrid');//trigger window resize to make the grid get the correct size

	})
</script>