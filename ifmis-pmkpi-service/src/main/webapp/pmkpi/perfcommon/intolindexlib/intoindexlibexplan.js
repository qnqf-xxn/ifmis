if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
Ext.lt.pmkpi.intoindexlibexplan = function(config, serviceid) {
    var common = Ext.lt.pmkpi.perfcommon(config, serviceid);
    var _cmp = {};
    var _tablecode,
        _defquery;

    /**
     * 初始化
     */
    $(function () {
        common.initDatatable();
        Ext.lt.pmkpi.query();
    });

    /**
     * 查询
     */
    Ext.lt.pmkpi.query = function () {
        Ext.lt.ui.loadingShow();
        var params = {};
        params.tablecode = _tablecode;
        params.tablesql = _defquery;
        params.beanid = "pmkpi.intoindexlib.IntoIndexLibBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params, function () {
            Ext.lt.ui.loadingClose();
        });
    }

    /**
     * 关闭
     */
    _cmp.close = function () {
        parent.Ext.lt.ui.modalWindow.close();
    }

    Ext.lt.message.hook("datatable", "drawed",function(obj){
        var uiconfig = obj.uiconfig;
        //表配置
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
    });

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj) {
        var cols = obj.cols;
        if (!Ext.lt.isArray(cols))
            cols = [cols];
        for (var i = 0; i < cols.length; i++) {
            var col = cols[i];
            if(col["colcode"] == "explan_type"){
                var findex = "";
                var subfindex = "";
                col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
                    if(j==1){
                        var tabledata = datatable.getRecordSet().toArray();
                        var statnum = 0;
                        if(i==statnum){
                            findex = Ext.lt.cloneobj(rs["explan_type"]);
                        }
                        if(findex == rs["explan_type"]){
                            style ='style="border-bottom-style:none;text-align:center;position:relative;padding-top:5px;';
                        } else {
                            style ='style="border-top-width:1px;text-align:center;border-top-color:#cccccc;border-bottom-style:none;';
                        }
                        findex = Ext.lt.cloneobj(rs["explan_type"]);
                        if(i == tabledata.length-1){
                            style =style +'border-bottom-style:solid;"';
                        } else {
                            style =style + '"';
                        }
                    }
                    return style;
                }
                col.fn = function(i,c,rs,value){ //行的显示样式.
                    if(rs["explan_type"]){
                        subfindex = Ext.lt.cloneobj(rs["explan_type"]);
                        var seq = showMidleName(subfindex,"explan_type");
                        if(i==seq){
                            return value;
                        }
                        return "";
                    }
                }
            }
        }
    });

    return _cmp;
}

/**
 * 计算表格合并name居中
 * @param val
 * @param col
 * @returns {number}
 */
showMidleName = function(val,col){
    var tabledata = datatable.getRecordSet().toArray();
    var a = -1,b=-1;
    var atemp = {};
    for ( var i = 0; i < tabledata.length; i++) {
        atemp = tabledata[i];
        if(val == atemp[col]){
            a = atemp["_sortid"]; //首次出现值
            break;
        }
    }
    var btemp = {};
    for ( var i = tabledata.length-1; i >-1; i--) {
        btemp = tabledata[i];
        if(val == btemp[col]){
            b = btemp["_sortid"]; //结束出现值
            break;
        }
    }
    return parseInt((b-a)/2)+a;
}