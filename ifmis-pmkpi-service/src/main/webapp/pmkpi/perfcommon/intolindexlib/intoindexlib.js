if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
/**
 * 初始化加载.
 */
Ext.lt.pmkpi.intoindexlib = function(config, serviceid) {
    var common = Ext.lt.pmkpi.perfcommon(config, serviceid);
    var _cmp = {};
    var _bustype = config.bustype;
    var _workflow = config.workflow;
    var _agency_code = config.agency_code;
    var _pro_name = decodeURIComponent(config.pro_name);
    var _displaycols = [];
    var _isNINGXIA = config.isNINGXIA;
    var height = Math.floor(document.documentElement.clientHeight * 0.95);
    var width =  Math.floor(document.documentElement.clientWidth * 0.95);
    if (height < 400) {
        height = 400;
    }
    if (width < 800) {
        width = 1000;
    }

    $(function () {
        _cmp.setTableColum();
        var datas = parent.datatable.getSelected();
        if (datas.length > 0) {
            var d = [];
            for (var i=0; i<datas.length; i++) {
                if (datas[i].levelno == "3") {
                    d.push(datas[i]);
                }
            }
            datatable.setDatas(d);
        }
    });

    /**
     * 动态配置表格的列.
     * @param data --
     */
    _cmp.setTableColum = function(){
        var cols = datatable.getCols(); //获取列表所有列
        cols.push.apply(cols, _displaycols);
        _displaycols = [];
        for (var i = 0, len = cols.length; i < len; i++) {
            var col = cols[i];
            var config = eval(col.config);
            if (config && !$.isEmptyObject(config) && col.alias != "序号") {
                if (config.bustype == _bustype) {
                    col.display = true;
                } else {
                    _displaycols.push(col); //隐藏前暂存至sfagency;
                    col.display = false; //display置为false，隐藏
                    col.requirement = "0";
                }
            }
        }
        datatable.redraw();
    }

    /**
     * 纳入指标库
     */
    _cmp.initindex = function () {
        if (datatable.getEditor()){
            datatable.closeEdit();
        }
        // 可以勾选纳入，而不是全部
        var datas= datatable.getSelected();
        if(datas.length == 0){
            datas = datatable.getRecordSet().toArray();
        }
        if(datas.length == 0){
            Ext.lt.ui.alert("无指标数据！",function(){});
            return;
        }
        if (!datatable.checkAll()) {
            return;
        }
        var _selindiguid = []; // 选中的纳入指标
        for (var a = 0, leni = datas.length; a < leni; a++) {
            if (!common.checkSpaceValue(datas[a],"绩效指标-第" + (datas[a]["_sortid"] + 1) + "行","datatable")) return;//校验空格
            datas[a].name = convertStr(datas[a].name);
            datas[a].indexval = convertStr(datas[a].indexval);
            datas[a].kpi_val = convertStr(datas[a].kpi_val);
            if (_isNINGXIA) {
                datas[a].pro_name = _pro_name;
            }
            _selindiguid.push(datas[a].guid);
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.datas = datas;
        params.bustype = _bustype;
        params.workflow = _workflow;
        params.agency_code = _agency_code;
        params.selindguids = _selindiguid;
        var canintolib = true;
        if (_isNINGXIA) { //宁夏 重复校验，单位编码+类别(功能科目类款级)+二级指标+指标名称
            var checkrs = Ext.lt.RCP.asyncall(serviceid , "checkExists", params);
            if (checkrs.nopassname.length > 0){
                var units = [];
                for (var j = 0; j < checkrs.nopassname.length; j++) {
                    if (checkrs.nopassname[j] != null) {
                        units.push(checkrs.nopassname[j]);
                    }
                }
                var msg = "[" + units.join("、") + "]指标库已存在同名称指标，无需重复纳入！";
                Ext.lt.ui.alert(msg);
                Ext.lt.ui.loadingClose();
                canintolib = false;
            }
        }
        if(canintolib){
            Ext.lt.RCP.call(serviceid , "intoindexlib", params, function(rs){
                if(rs.success){
                    Ext.lt.ui.alert('纳入指标库成功！', function(){
                        // 刷新父级申报指标列表选中数据的标记状态 is_intoindexlib = 1
                        var parentalldatas = parent.datatable.getRecordset().toArray();
                        for (var i = 0; i < parentalldatas.length; i++) {
                            var guid = parentalldatas[i].guid;
                            if(_selindiguid.includes(guid)){
                                parentalldatas[i].is_intoindexlib = 1;
                                // var _sortid = parentalldatas[i]._sortid;
                                // parent.datatable.reflash(_sortid);
                            }
                        }
                        parent.datatable.reflash();
                        Ext.lt.ui.closeModalWindow();
                    });
                } else {
                    Ext.lt.ui.alert('纳入指标库失败！' + rs.msg, function(){});
                }
                Ext.lt.ui.loadingClose();
            },function(rs){
                Ext.lt.ui.loadingClose();
                Ext.lt.ui.alert('纳入指标库失败！' + rs, function(){});
            });
        }
    }

    /**
     * 填报要素说明
     */
    _cmp.reportelementexplan = function (obj){
        var url = '/pmkpi/intoindexlib/explan.page';
        var params = {};
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,width,height,"填报要素说明");
    }

    return _cmp;
}