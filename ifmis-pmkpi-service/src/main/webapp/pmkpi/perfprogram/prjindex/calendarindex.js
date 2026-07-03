if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
/**
 * 初始化加载.
 */
Ext.lt.pmkpi.calendarindex = function(config, serviceid) {
    var common = Ext.lt.pmkpi.perfcommon(config, serviceid);
    var _years = config.years;
    var _proguid = config.proguid;
    var _procode = config.procode;
    var _signs = config["signs"];//计算符号
    var _cmp = {};

    /**
     * 页面加载完成
     */
    $(function() {
        _cmp.setTableColum();
        _cmp.query();
    })

    _cmp.query = function () {
        var params = {};
        params.proguid = _proguid;
        params.years = _years;
        params.procode = _procode;
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid, "getDatas", params, function (data) {
            datatable.setDatas(data);
            Ext.lt.ui.loadingClose();
        }, function () {
            Ext.lt.ui.loadingClose();
            Ext.lt.pmkpi.alert('查询失败！', function () {
            });
        });
    }

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        _cmp.query();
    });

    /**
     * 动态配置表格的列.
     *
     * @param data --
     */
    _cmp.setTableColum = function(){
        var cols = datatable.getCols(); //获取列表所有列
        var j = 0;
        for (var i = 0; i < cols.length; i++) {
            var colcode = cols[i].colcode;
            if (colcode && colcode.indexOf("indexval") != -1) {
                cols[i].alias = _years[j] + "年指标值";
                j++;
            }
        }
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw(); //从新绘制表格
    }

    /**
     * 确定
     */
    _cmp.addindex = function(){
        var datas = datatable.getSelected().toArray();
        for(var i=0; i<datas.length; i++) {
            var data = datas[i];
            data.guid = getCreateguid(serviceid);
            data.rowtype = "add";
            data.levelno = 3;
            data.isleaf = 1;
            data._isleaf = 1;
            data.isfixed = "";
            data.isfromparent = "0";
            data.isapply = "1";
            data.superid = data.sindex;
            if (parent._curtab == "total") {
                data.yearflag = "1";
            } else if (parent._curtab == "year") {
                data.yearflag = "0";
            }
            parent.tabcomps["#year"].push(data);
        }
        //指标符号翻译
        var zbxs_source = [];
        for(var i=0; i<_signs.length; i++){
            var temparr = [];
            temparr.push(_signs[i]["guid"]);
            temparr.push(_signs[i]["code"]);
            temparr.push(_signs[i]["name"]);
            zbxs_source.push(temparr);
        }
        parent.datatable.addMapperDatas("computesign",zbxs_source);
        if (parent.datatable.getCol("isapply") && parent.datatable.getCol("isapply")["isvisiable"] == 1){
            var isapply_source = [];
            var _isapply = [{guid: "2", code: 2, name: "否"}, {guid: "1", code: 1, name: "是"}];
            for (var i = 0; i < _isapply.length; i++) {
                var temparr = [];
                temparr.push(_isapply[i]["guid"]);
                temparr.push(_isapply[i]["code"]);
                temparr.push(_isapply[i]["name"]);
                isapply_source.push(temparr);
            }
            parent.datatable.addMapperDatas("isapply", isapply_source);
        }
        if (parent._curtab == "year") {
            parent.datatable.getRecordSet().addData(datas);
        }
        parent.Ext.lt.ui.modalWindow.close();
    }

    return _cmp;
}