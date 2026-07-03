if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.randomTabEdit){
    Ext.lt.pmkpi.randomTabEdit = {};
}

Ext.lt.pmkpi.randomTabEdit = function(config, service){
    var serviceid = service,
        _projguid = config.projguid,
        _tabcode,
        _tablecode,//表名
        _defquery,//表配置过滤条件
        _orderby,//表排序sql
        _busguid,//审核定义
        _modelguid,//指标模板guid
        XMJXJKBB01_ZZTS,
        pmkpiReportAppId = config.pmkpiReportAppId
        ;
    var cmp = {};

    cmp.query = function(){
    	var params = {};
        params.tablecode = _tablecode;
        params.projguid = _projguid;
		var url = Ext.lt.token.urlAddToken("/hqreport/show.htm?reportId="+XMJXJKBB01_ZZTS+"&sysId="+pmkpiReportAppId+"&year="+config.year+"&proguid="+_projguid);
		el = layoutservice.redarw();
		var layout = {};
		var main = [];
		var mainids = [];
		layout.main = main;
		layout.mainids = mainids;
		layoutservice.layout = layout;
		layoutservice.draw(el);
		el.innerHTML = '<div style="width:'
			+ el.offsetWidth + 'px; height:' + el.offsetHeight + 'px;"><iframe src="'
			+ url + '" scrolling="yes" style="width:'
			+ el.offsetWidth + 'px; height:' + (el.offsetHeight ) + 'px"></iframe></div>'
    }

    $(function () {
        debugger
        cmp.query();
    })

    return cmp;
}