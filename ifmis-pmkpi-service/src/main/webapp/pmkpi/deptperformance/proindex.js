if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.proindex){
    Ext.lt.pmkpi.deptfunc = {};
}

Ext.lt.pmkpi.proindex = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var
        _mainguid = config.mainguid,
        _agency_code = config.agency_code,
        _indsource = config.indsource,
        _signs = config.signs,
        _defquery
    ;
    var cmp = {};

    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        Ext.lt.pmkpi.query();
    });

    Ext.lt.pmkpi.query = function(){
        Ext.lt.ui.loadingShow();
        var params = {};
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.agency_code = _agency_code;
        params.defquery = _defquery;
        Ext.lt.RCP.call(service , "getDatas", params, function(datas){
            if (datas && datas.length > 0) {
                datatable.setDatas(datas);
            }
            Ext.lt.ui.loadingClose();
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });
    }

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("busdatatable", "drawed", function (obj) {
        _defquery = obj.uiconfig.defquery;
    });

    /**
     * 选中
     */
    cmp.add = function(){
        var selRecords = datatable.getSelected();
        if(selRecords.size() == 0) {
            Ext.lt.ui.alert("请选择数据！",function(){});
            return;
        }
        var selMap = {};
        var tempobj = {};
        var sindex = "";
        var name = "";
        for (var i = 0; i < selRecords.length; i++) {
            var addData = {};
            tempobj = selRecords[i];
            var uuid = createUUID().replace(/-/g, '');
            addData["guid"] = uuid;
            sindex = tempobj["sindex"];
            name = tempobj["name"];
            addData.superid = sindex;
            addData.levelno = 3;
            addData.isleaf = 1;
            addData._isleaf = 1;
            addData.rowtype = "add";
            addData.obligate1 = "删除";
            addData.isfixed = "";
            addData.isfromparent = "0";
            addData.isapply = "1";
            addData.indsource = '2';
            addData.kpi_evalstd = "1"; //部标规范字段
            addData.is_add = "2";
            addData.check = 1;
            addData.findex = tempobj["findex"];
            addData.sindex = sindex;
            addData.name = name;
            addData.code = tempobj["code"];
            addData.computesign = tempobj["computesign"];
            addData.indexval = tempobj["indexval"];
            addData.meterunit = tempobj["meterunit"];
            addData.tindex = tempobj["tindex"];
            if (name && name != "") { //存在三级指标的才保存替换
                if (!selMap[sindex]) {
                    selMap[sindex] = [];
                }
                selMap[sindex].push(addData);
            }
        }
        //指标符号翻译
        var zbxs_source = [];
        for (var i = 0; i < _signs.length; i++) {
            var temparr = [];
            temparr.push(_signs[i]["guid"]);
            temparr.push(_signs[i]["code"]);
            temparr.push(_signs[i]["name"]);
            zbxs_source.push(temparr);
        }
        parent.datatable.addMapperDatas("computesign", zbxs_source);
        if (parent.datatable.getCol("indsource") && parent.datatable.getCol("indsource")["isvisiable"] == 1) {
            perfcommon.setColDatasource({"indsource": _indsource}, parent.datatable);
        }
        var parent_sel_rows;
        var parent_sel_obj;
        var _sortid;
        for (var key in selMap) {
            parent_sel_rows = parent.datatable.getRecordset().query({guid: key});
            if (parent_sel_rows.length > 0) {
                parent_sel_obj = parent_sel_rows[parent_sel_rows.length - 1];
                _sortid = parent_sel_obj._sortid;
                parent.datatable.getRecordSet().addData(selMap[key], _sortid + parent.datatable.getRecordset().toArray().length);
            }
        }
        parent.Ext.lt.ui.modalWindow.close();
    }

    return cmp;
}