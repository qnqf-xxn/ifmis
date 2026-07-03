if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.rectification)
    Ext.lt.pmkpi.rectification = {};

Ext.lt.pmkpi.rectification.programinfoservice = function(config, service) {
    var serviceid = config.serverid;
    var cmp = {};
    var _proguid = config.proguid,
        _viewtype = config.viewtype,
        _tablecode = config.tablecode,
        _bustype = config.bustype,   //1：项目  3：部门
        _queryYear = config.queryYear,//跨年查询查询年度
        _queryProvince = config.queryProvince,//跨年查询查询区划
        _procode = config.pro_code; //项目编码

    $(function (){
        var cols = editform.cfg.data;
        _tablecode = cols[0].tablecode;
        if(_viewtype == 'query'){
            var c = {};
            for (var i=0; i<cols.length; i++) {
                c[cols[i].colcode.toLowerCase()] = true;
            }
            editform.setdisabled(c);//设置不可编辑
        }
        cmp.initdata();
    })

    cmp.initdata = function(){
        var params = {};
        params.proguid = _proguid;
        params.tablecode = _tablecode;
        params.pro_code = _procode;
        params.bustype = _bustype;
        params.queryYear = _queryYear;
        params.queryProvince = _queryProvince;
        var rs = Ext.lt.RCP.asyncall(serviceid , "queryProdata", params);
        Ext.lt.ui.loadingClose();
        if(rs && rs.success){
            var _editdatas = rs.datas;
            editform.synchEditformByObj(_editdatas[0]);
        }
    }


    return cmp;
}